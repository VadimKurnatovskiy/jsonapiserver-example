module V1
  module SerializerFactory
    module Publisher
      def publisher_serializer(publisher, as_json_options=nil)
        V1::PublisherSerializer.new(publisher, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
