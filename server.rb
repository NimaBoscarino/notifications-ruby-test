require 'exponent-server-sdk'
require 'sinatra'
require 'sinatra/cross_origin'


users = []

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

post '/push-token' do
    p 'hahaa'
    @json = JSON.parse(request.body.read)
    p @json['token']['value']
    p @json['user']['username']

    users.push({ "token" => @json['token']['value'], "username" => @json['user']['username']})
    puts users
end

options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

client = Exponent::Push::Client.new

messages = [{
  to: "ExponentPushToken[cmPLA8PkabwX2T9LkauEI1]",
  sound: "default",
  body: "Hello world!"
}]

client.publish messages


set :bind, '0.0.0.0'


# client = Exponent::Push::Client.new

# messages = [{
#   to: "ExponentPushToken[xxxxxxxxxxxxxxxxxxxxxx]",
#   sound: "default",
#   body: "Hello world!"
# }, {
#   to: "ExponentPushToken[yyyyyyyyyyyyyyyyyyyyyy]",
#   badge: 1,
#   body: "You've got mail"
# }]

# client.publish messages

