module V1
  class CommentsSerializer < JsonApiServer::ResourcesSerializer
    serializer V1::CommentSerializer
  end
end
