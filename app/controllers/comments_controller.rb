class CommentsController < ApplicationController
#       before_action :set_comment, only: [:destroy]
#       before_action :authenticate_user!
#   def create
#     @blog = Blog.find(params[:blog_id])
#     comment= @blog.comments.new(comment_params)

#     # respond_to do |format|
#     #   if comment.save
#     #     format.html { redirect_to @blog, notice: "created." }
#     #     format.json { render :show, status: :created, location: @blog }
#     #   else
#     #     format.html { redirect_to @blog, status: :unprocessable_entity }
#     #     format.json { render json: @blog.errors, status: :unprocessable_entity }
#     #   end
#     # end
# end



#   def destroy
#     if @comment.destroy
#       head :no_content
#     else
#       render json: { error: @comment.errors.message }, status: 422
#     end
#   end

#   private

#   def set_comment
#     @comment = Comment.find(params[:id])
#   end

#   def comment_params
#     params.require(:comment).permit(:content, :blog_id)
#   end



before_action :authenticate_user! # Обеспечиваем аутентификацию пользователя через Devise
  
def create
  @blog = Blog.find(params[:blog_id]) # Находим блог, к которому будет привязан комментарий
  @comment = @blog.comments.build(comment_params) # Создаем новый комментарий для этого блога
  
  @comment.user = current_user # Привязываем текущего пользователя к комментарию
  
  if @comment.save
    redirect_to @blog, notice: 'Comment was successfully created.' # Перенаправляем на страницу блога с сообщением об успешном создании комментария
  else
    redirect_to @blog, alert: 'Failed to create comment.' # Перенаправляем на страницу блога с сообщением о неудаче создания комментария
  end
end

private

def comment_params
  params.require(:comment).permit(:content)
end
end