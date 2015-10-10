class UsersController < ApplicationController
  def update
    @user = user
    user.update(access_token: code)
    respond_with(@user, location: -> { root_path } )
  end

  private

  def user
    User.find(params.require(:id))
  end

  def code
    params.require(:code)
  end
end
