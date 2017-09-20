module V1
  class CheckoutsSerializer < JsonApiServer::ResourcesSerializer
    serializer V1::CheckoutSerializer
  end
end
