class Api::V1::PingController < Api::V1::BaseController
  skip_before_action :authenticate_devise_api_token!
  skip_after_action :verify_policy_scoped, :raise => false

  def index
    render json: {message: "pong"}
  end
end
