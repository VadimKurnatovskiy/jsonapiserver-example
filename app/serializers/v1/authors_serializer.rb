module V1
  class AuthorsSerializer < JsonApiServer::ResourcesSerializer
    serializer V1::AuthorSerializer
  end
end
