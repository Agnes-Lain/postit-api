class Api::V1::PostsController < Api::V1::BaseController

  # acts_as_token_authentication_handler_for User, except: [:index]

  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!
  # , only: [:restricted]

  # skip_before_action :authenticate_user!, only: :index
  # skip_after_action :verify_authorized, only: :index

  before_action :set_post, only: [ :show, :update, :destroy]

  def index
    @posts = Post.where(user: current_devise_api_user)
    authorize @posts
    # @posts = policy_scope(Post.order(:id))
    # @posts = Post.order(:id)
    # skip_authorization
  end

  # def show
  # end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_devise_api_user
    authorize @post
    if @post.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    devise_api_token = current_devise_api_token
    @post = devise_api_token.resource_owner.posts.find(params[:id])
    authorize @post  # For Pundit
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def render_error
    render json: { errors: @post.errors.full_messages },
      status: :unprocessable_entity
  end

end
