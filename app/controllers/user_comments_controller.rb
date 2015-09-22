class UserCommentsController < ApplicationController
  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.user_id = params[:user_id]
    @user_comment.author_id = current_user.id
    if @user_comment.save
      redirect_to user_url(@user_comment.user_id)
    else
      flash[:errors] = @user_comment.errors.full_messages
      redirect_to user_url(params[:user_id])
    end
  end

  def destroy
    @user_comment = UserComment.find(params[:id])
    @user_comment.destroy
    redirect_to user_url(params[:user_id])
  end

  private

  def user_comment_params
    params.require(:user_comments).permit(:body)
  end
end
