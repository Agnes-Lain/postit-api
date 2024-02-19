class Api::V1::PostsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_post, only: [ :show, :update ]

  def index
    # @posts = Post.where(user: current_user)
    # authorize @posts
    @posts = policy_scope(Post)
  end

  def show
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
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