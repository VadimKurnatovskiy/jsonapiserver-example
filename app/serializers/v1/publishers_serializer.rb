module V1
  class PublishersSerializer < SimpleJsonApi::ResourcesSerializer
    serializer V1::PublisherSerializer
  end
end
