require 'twilio-ruby'

class Elevator < ApplicationRecord
  belongs_to :column

  after_update do |elev|
    if elev.elevator_status == "Intervention"
      require("bundler")
      Bundler.require()

      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']

      @client = Twilio::REST::Client.new(account_sid, auth_token)

      @client.messages.create(
          to: ENV['RECIPIENT_PHONE_NUMBER'],
          from: '+12058929412',
          body: "Hi this is a message from Rocket Elevators. Elevator ##{elev.id} now has the status of #{elev.elevator_status}"
      )
    end
  end
end
