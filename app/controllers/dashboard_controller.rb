require 'oauth2'

class DashboardController < ApplicationController
  def index
    @client = client
    params
  end

  private


end
