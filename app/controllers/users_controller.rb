class UsersController < ApplicationController
  include MainConcern

  before_action :set_user_old, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ profile feed follow unfollow ]
  before_action :set_user_session, only: %i[ profile feed follow unfollow following ]
  before_action :sef_profile, only: %i[ profile follow unfollow following ]

  def profile
    @profile = User.find_by(name: params[:name])
    @user = User.find(session[:user_id])
    @is_follow = Follow.find_by(follower_id:@user.id,followee_id:@profile.id)
    @all_post = @profile.posts
    @all_post = @all_post.sort_by{ |obj| obj.created_at }.reverse!
  end

  def feed
    @all_followee = @user.follower.map{ |follow| follow.followee_id }
    @all_post = Post.where(user_id:@all_followee)
    @all_post = @all_post.sort_by{ |obj| obj.created_at }.reverse!
  end

  def following
    if(params[:commit]=='Follow')
      Follow.create(follower:@user,followee:@profile).save
      respond_to do |format|
        format.html { redirect_to feed_path, notice: "Follow "+@profile.name+" successfully" }
      end
    elsif(params[:commit]=='Unfollow')
      Follow.find_by(follower:@user,followee:@profile).destroy
      respond_to do |format|
        format.html { redirect_to feed_path, notice: "Unfollow "+@profile.name+" successfully" }
      end
    end
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def sef_profile
      @profile = User.find_by(name: params[:name])
    end

    def is_follow
      return (@user!=@profile) && (Follow.find_by(follower_id:@user.id,followee_id:@profile.id)!=nil)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user_old
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password_digest)
    end
end
