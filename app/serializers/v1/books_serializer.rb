module V1
  class BooksSerializer < SimpleJsonApi::ResourcesSerializer
    serializer V1::BookSerializer
  end
end
