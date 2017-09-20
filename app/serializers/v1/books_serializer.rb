module V1
  class BooksSerializer < JsonApiServer::ResourcesSerializer
    serializer V1::BookSerializer
  end
end
