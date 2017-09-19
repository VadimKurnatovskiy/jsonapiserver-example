module V1
  class CheckoutsSerializer < SimpleJsonApi::ResourcesSerializer
    serializer V1::CheckoutSerializer
  end
end
