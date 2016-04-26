module Api
  class BaseController < ::ApplicationController
    include Roar::Rails::ControllerAdditions

    skip_before_action :verify_authenticity_token

    respond_to :json
  end
end
