module V1
  module SerializerFactory
    module Author
      def author_serializer(author, as_json_options=nil)
        V1::AuthorSerializer.new(author, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
