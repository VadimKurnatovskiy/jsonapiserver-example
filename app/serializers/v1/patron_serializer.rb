module V1
  class PatronSerializer < JsonApiServer::ResourceSerializer
    resource_type 'patrons'

    include V1::SerializerFactory::Comment
    include V1::SerializerFactory::Checkout

    def links
      { self: File.join(base_url, "/api/v1/patrons/#{@object.id}") }
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
        .add_multi(@object, 'first_name', 'last_name', 'city')
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        if relationship?('patron.comments')
          rb.relate_each('comments', @object.comments){ |c| comment_serializer(c) }
        end
        if relationship?('patron.checkouts')
          rb.relate_each('checkouts', @object.checkouts){ |c| checkout_serializer(c) }
        end
        rb
      end
    end
  end
end
