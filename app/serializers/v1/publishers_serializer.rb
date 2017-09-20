module V1
  class PublishersSerializer < JsonApiServer::ResourcesSerializer
    serializer V1::PublisherSerializer
  end
end
