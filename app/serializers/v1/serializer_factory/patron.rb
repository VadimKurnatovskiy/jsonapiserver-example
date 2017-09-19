module V1
  module SerializerFactory
    module Patron
      def patron_serializer(patron, as_json_options=nil)
        V1::PatronSerializer.new(patron, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
