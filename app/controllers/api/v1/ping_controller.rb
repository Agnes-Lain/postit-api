class Api::V1::PingController < Api::V1::BaseController
  # skip_before_action :authenticate_user!
  skip_after_action :verify_policy_scoped

  def index
    render json: {message: "pong"}
  end
end
