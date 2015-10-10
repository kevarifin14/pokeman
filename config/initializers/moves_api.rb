MOVES_CLIENT_ID = ENV["MOVES_CLIENT_ID"]
MOVES_SECRET_ID = ENV["MOVES_SECRET_ID"]

def client
  OAuth2::Client.new(
    MOVES_CLIENT_ID,
    MOVES_SECRET_ID,
    site: 'https://api.moves-app.com/',
    authorize_url: '/oauth/v1/authorize'
  )
end
