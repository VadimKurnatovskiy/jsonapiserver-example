module V1
  module SerializerFactory
    module Checkout
      def checkout_serializer(checkout, as_json_options=nil)
        V1::CheckoutSerializer.new(checkout, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
