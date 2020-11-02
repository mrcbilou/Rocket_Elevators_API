class Elevator < ApplicationRecord
  belongs_to :column

  after_update do |elev|
    puts ""
  end
=begin 
  require("bundler")
  Bundler.require()

  account_sid = 'ACab428b7e54e6aa4f3ffd74b2b92d5f08'
  auth_token = '3dd8a31b56f9ff6cd5e61be216546a99'
      
  @client = Twilio::REST::Client.new(account_sid, auth_token)

  @client.messages.create(
      to: '+18198171295',
      from: '+12058929412',
      body: "Hi this is a message from Rocket Elevators, telling you that a lead has been created!"
  )
=end
end
