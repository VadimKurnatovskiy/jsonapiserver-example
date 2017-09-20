class ApplicationController < ActionController::API
  include JsonApiServer::Controller::ErrorHandling
end
