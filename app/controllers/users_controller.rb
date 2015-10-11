class UsersController < ApplicationController
  def update
    @user = user
    user.update(access_token: code)
    respond_with(@user, location: -> { root_path } )
  end
end
