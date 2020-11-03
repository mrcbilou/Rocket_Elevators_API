require 'twilio-ruby'
require 'slack-notifier'

class Elevator < ApplicationRecord
  belongs_to :column

  old_status =""

  before_save do |elev|
    old_status = elev.elevator_status
    puts "11111!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{old_status}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

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
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "The Elevator ##{elev.id} with Serial Number #{elev.serial_number} changed status from #{self.elevator_status_was} to #{elev.elevator_status}"
  end
end
