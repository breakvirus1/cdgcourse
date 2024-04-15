class LikesController < ApplicationController

    before_action :set_blog

    def create
      @like = @blog.likes.new
      if @like.save
        redirect_to @blog, notice: 'Liked!'
      else
        redirect_to @blog, alert: 'Error liking post!'
      end
    end
  
    def destroy
      @like = @blog.likes.find(params[:id])
      @like.destroy
      redirect_to @blog, notice: 'Unliked!'
    end
  
    # Добавлено действие index для просмотра всех лайков для определенного блога
    def index
      @likes = @blog.likes
    end
  
    private
  
    def set_blog
      @blog = Blog.find(params[:blog_id])
    end
end
