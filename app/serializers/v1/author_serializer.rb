module V1
  class AuthorSerializer < JsonApiServer::ResourceSerializer
    resource_type 'authors'

    include V1::SerializerFactory::Book

    def links
      { self: File.join(base_url, "/api/v1/authors/#{@object.id}") }
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
        .add_multi(@object, 'first_name', 'middle_name', 'last_name', 'year_of_birth')
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        if relationship?('books')
          rb.relate_each('books', @object.books) { |b| book_serializer(b) }
        elsif relationship?('books.include')
          rb.include_each('books', @object.books, relate: {include: [:relationship_data]}) { |b| book_serializer(b) }
        end
        rb
      end
    end
  end

end
