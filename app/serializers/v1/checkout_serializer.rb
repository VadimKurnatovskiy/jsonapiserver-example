module V1
  class CheckoutSerializer < JsonApiServer::ResourceSerializer
    resource_type 'checkouts'

    include V1::SerializerFactory::Book
    include V1::SerializerFactory::Patron

    def links
      { self: File.join(base_url, "/api/v1/checkouts/#{@object.id}") }
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
        .add_multi(@object, 'book_id', 'patron_id')
        .add('checkout_date', @object.checkout_date.to_s)
        .add('created', @object.created_at.try(:iso8601, 0))
        .add('updated', @object.updated_at.try(:iso8601, 0))
        .attributes
    end

    def inclusions
      @inclusions ||= begin
        rb.relate('book', book_serializer(@object.book)) if
          relationship?('checkout.book')
        rb.relate('patron', patron_serializer(@object.patron)) if
          relationship?('checkout.patron')
        rb
      end
    end
  end
end
