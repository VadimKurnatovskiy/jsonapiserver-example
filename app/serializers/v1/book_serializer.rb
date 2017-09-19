module V1
  class BookSerializer < SimpleJsonApi::ResourceSerializer
    resource_type 'books'

    include V1::SerializerFactory::Author
    include V1::SerializerFactory::Publisher
    include V1::SerializerFactory::Comment
    include V1::SerializerFactory::Checkout

    def links
      { self: File.join(base_url, "/api/v1/books/#{@object.id}") }
    end

    def data
      {}.tap do |h|
        h[:type] = self.class.type
        h[:id] = @object.id
        h[:attributes] = attributes
        h[:relationships] = inclusions.relationships if inclusions?
      end
    end

    def included
      inclusions.included if inclusions?
    end

    protected

    def inclusions?
      @includes.respond_to?(:any?) && @includes.any?
    end

    def attributes
      attributes_builder
        .add_multi(@object, :title, :description, :price)
        .add_multi(@object, :publisher_id, :author_id)
        .add('publication_date', @object.publication_date.to_s)
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        rb.relate('author', author_serializer(@object.author)) if
          relationship?('book.author')
        rb.relate('publisher', publisher_serializer(@object.publisher)) if
          relationship?('book.publisher')
        rb.relate_each('comments', @object.cached_comments('v1', 5)){|c| comment_serializer(c)} if
          relationship?('book.comments')
        rb.relate_each('checkouts', @object.cached_checkouts('v1', 5)){|c| checkout_serializer(c)} if
          relationship?('book.checkouts')
        rb
      end
    end
  end
end
