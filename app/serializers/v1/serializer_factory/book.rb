module V1
  module SerializerFactory
    module Book
      def book_serializer(book, as_json_options=nil)
        V1::BookSerializer.new(book, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
