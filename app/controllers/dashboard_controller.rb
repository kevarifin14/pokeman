require 'oauth2'

class DashboardController < ApplicationController
  def index
    @client = client
    params
  end

  private

  def client
    OAuth2::Client.new(
      'nItFH0bEpvjZ941CM6JQqRrXmC69hpPi',
      'rll2y6Fz8CAInSV4JL5PDRo1FsKaZF5UQ6j_NG2pSASn86YtPj5Dr1HtSQ_9Mu8x',
      site: 'https://api.moves-app.com/',
      authorize_url: '/oauth/v1/authorize'
    )
  end
end
