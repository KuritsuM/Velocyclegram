class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  #before_action :authenticate_user!
  #before_action :check_authorization #, only: %i[ new edit create update destroy ]
  #before_action :check_post_creator, only: [:update, :destroy]

  # GET /posts/1
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
        format.html { redirect_to profile_path(@post.user.id), notice: "Post was successfully created." }
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
      if @post.update(update_post_params)
        format.html { redirect_to profile_path(@post.user.id), notice: "Post was successfully updated." }
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
      format.html { redirect_to profile_path(@post.user.id), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.includes(:commentary).where(id: params[:id]).first
  end

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end

  def update_post_params
    params.require(:post).permit(:title, :image)
  end
end
