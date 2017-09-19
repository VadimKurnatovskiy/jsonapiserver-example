module V1
  class CommentSerializer < SimpleJsonApi::ResourceSerializer
    resource_type 'comments'

    include V1::SerializerFactory::Book
    include V1::SerializerFactory::Patron

    def links
      { self: File.join(base_url, "/api/v1/comments/#{@object.id}") }
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

    def attributes
      attributes_builder
        .add('text', @object.text)
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        rb.relate('book', book_serializer(@object.book)) if
          relationship?('comment.book')
        rb.relate('patron', patron_serializer(@object.patron)) if
          relationship?('comment.patron')
        rb
      end
    end
  end
end
