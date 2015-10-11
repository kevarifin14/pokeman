require 'oauth2'
require 'net/https'
require 'open-uri'

class DashboardController < ApplicationController
  REDIRECT_URI = 'http://localhost:3000/'
  def index
    if code == 0
      redirect
    elsif code and !current_user.access_token
      response = redirect_access_token
      current_user.update(access_token: response.token)
      UploadPastActivity.call(client: moves_client, user: current_user)
    end
    @client = client
  end

  private

  def client
    MovesApi::CLIENT
  end

  def moves_client
    Moves::Client.new(current_user.access_token)
  end

  def redirect
    redirect_to client.auth_code.authorize_url(
      redirect_uri: REDIRECT_URI,
      scope: 'activity',
    )
    # response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
    # response.class.name
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
