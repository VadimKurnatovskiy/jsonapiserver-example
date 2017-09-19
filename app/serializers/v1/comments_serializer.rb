module V1
  class CommentsSerializer < SimpleJsonApi::ResourcesSerializer
    serializer V1::CommentSerializer
  end
end
