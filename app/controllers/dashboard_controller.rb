require 'oauth2'
require 'net/https'
require 'open-uri'
require './lib/upload_past_activity'
require './lib/update_activity'

class DashboardController < ApplicationController
  # REDIRECT_URI = 'http://pokeman.herokuapp.com/'
  REDIRECT_URI = 'http://localhost:3000/'
  def index
    has_redirect = false
    flag = 0
    if !code and !current_user.access_token
      redirect
      has_redirect = true
      flag = -1
    elsif code and !current_user.access_token
      response = redirect_access_token
      current_user.update(access_token: response.token)
      UploadPastActivity.call(client: moves_client, user: current_user)
    end
    if current_user.access_token
      update_activities
    end
    if !current_user.avatar and not has_redirect
      redirect_to quiz_index_path
    end

    @client = client
  end

  private

  def client
    MovesApi::CLIENT
  end

  def update_activities
    UpdateActivity.call(client: moves_client, user: current_user)
  end

  def moves_client
    Moves::Client.new(current_user.access_token)
  end

  def redirect
    redirect_to client.auth_code.authorize_url(
      redirect_uri: REDIRECT_URI,
      scope: 'activity',
    )
  end

  def redirect_access_token
    client.auth_code.get_token(
      code,
      redirect_uri: REDIRECT_URI,
      headers: { grant_type: 'authorization_code' }
    )
  end

  def code
    params[:code]
  end
end
