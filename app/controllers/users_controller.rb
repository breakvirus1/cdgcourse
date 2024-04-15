class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow]
  def index; end

  def show
    @user = User.find(params[:id])
end

#Insert the following

def follow
  current_user.follow(@user)
  respond_to do |format|
    format.js
  end
end

# DELETE /users/:id/unfollow
def unfollow
  current_user.unfollow(@user)
  respond_to do |format|
    format.js
  end
end

  def edit; end

  def update; end

  def destroy; end
end
private

def set_user
  @user = User.find(params[:id])
end
