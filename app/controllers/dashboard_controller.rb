require 'oauth2'
require 'net/https'
require 'open-uri'
require './lib/upload_past_activity'

class DashboardController < ApplicationController
  REDIRECT_URI = 'http://localhost:3000/'
  def index
    if code == 0 and !current_user.access_token
      redirect
    elsif code and !current_user.access_token
      response = redirect_access_token
      current_user.update(access_token: response.token)
      UploadPastActivity.call(client: moves_client, user: current_user)
    end

    update_activities
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
      redirect_uri: 'http://localhost:3000/',
      headers: { grant_type: 'authorization_code' }
    )
  end

  def code
    params.fetch(:code, 0)
  end
end
