require("bundler")
Bundler.require()

account_sid = ENV["TWILIO_ACCOUNT_SID"]
auth_token = ENV["TWILIO_AUTH_TOKEN"]

@client = Twilio::REST::Client.new(account_sid, auth_token)

@client.messages.create(
    to: ENV["RECIPIENT_PHONE_NUMBER"],
    from: '+12058929412',
    body: "Hi this is a message from Rocket Elevators, telling you that a lead has been created!"
)