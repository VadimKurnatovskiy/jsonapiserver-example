module V1
  class AuthorsSerializer < SimpleJsonApi::ResourcesSerializer
    serializer V1::AuthorSerializer
  end
end
