module V1
  class PublisherSerializer < JsonApiServer::ResourceSerializer
    resource_type 'publishers'

    include V1::SerializerFactory::Book

    def links
      { self: File.join(base_url, "/api/v1/publishers/#{@object.id}") }
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
        .add('name', @object.name)
        .add('country', @object.country)
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        # Example of nested relationships and nested includes.
        if relationship?('publisher.books')
          rb.relate_each('books', @object.books) { |b| book_serializer(b) }
        elsif relationship?('publisher.books.include')
          rb.include_each('books', @object.books, relate: {include: [:relationship_data]}) { |b| book_serializer(b) }
        end
        rb
      end
    end
  end
end
