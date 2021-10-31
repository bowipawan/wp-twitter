class PostsController < ApplicationController
  include MainConcern

  skip_before_action :verify_authenticity_token

  before_action :check_login, only: %i[ ]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user_session, only: %i[ post create_post ]

  def liked_user
  end
  
  def post
    @post = Post.new
  end

  def create_post
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

    if @post.save
      redirect_to feed_path, notice: "Posted!."
    else
      render :post, status: :unprocessable_entity
    end
  end

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      # params.require(:post).permit(:msg, :user_id)
      params.require(:post).permit(:msg)
    end
end
