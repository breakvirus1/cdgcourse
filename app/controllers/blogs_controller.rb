class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, except: [:index, :show, :get_comments]
  attr_accessor :likes_count

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params.merge(user_id: current_user.id))
    @blog.image.attach(params[:micropost][:image])
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_comments
    comments = @blog.comments.select("comments.*, users.name").joins(:user).by_created_at
    render json: { comments: comments }
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def like
    @like = current_user.likes.find_by(blog_id: @blog.id)
    if @like
      # If the like exists, remove it
      @like.destroy
    else
      # Otherwise, create a new like
      @blog.likes.create(user_id: current_user.id)
    end
    respond_to do |format|
      format.js
    end
  end

  def unlike
    @like = current_user.likes.find_by(blog_id: @blog.id)
    # If the like exists, remove it
    @like.destroy if @like
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :body, :image)
    end
end
