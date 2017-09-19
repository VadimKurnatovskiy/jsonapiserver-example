module V1
  module SerializerFactory
    module Comment
      def comment_serializer(comment, as_json_options=nil)
        V1::CommentSerializer.new(comment, includes: includes, fields: fields,
          as_json_options: as_json_options || {include: [:data]})
      end
    end
  end
end
