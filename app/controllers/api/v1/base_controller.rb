class Api::V1::BaseController < ActionController::API
  include Pundit::Authorization

  # This commande is to remind that on homepage, no need of authentification so anyone can see the home page
  # skip_before_action :authenticate_user!, only: [:home]

  after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index
  # before_action :authenticate_user!, except: :index
  before_action :authenticate_devise_api_token!
  skip_before_action :verify_authenticity_token, raise: false
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  protected
  def configure_permitted_parameters
    attributes = [:email, :password, user_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end


end
