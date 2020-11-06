require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

class WatsonController < ActionController::Base
    def speak
        authenticator = Authenticators::IamAuthenticator.new(
            apikey: ENV['IBM_KEY']
        )
        text_to_speech = TextToSpeechV1.new(
            authenticator: authenticator
        )
            
        text_to_speech.service_url = ENV['IBM_URL']

        first_name = current_user.first_name
        last_name = current_user.last_name
        elevators = Elevator.count
        buildings = Building.count
        customers = Customer.count
        not_active_elevators = Elevator.where.not(elevator_status:'ACTIVE').count
        quotes = Quote.count
        leads = Lead.count
        batteries = Battery.count
        cities = Address.distinct.count(:city)

        response = text_to_speech.synthesize(
            text: "Greetings #{first_name} #{last_name}. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{not_active_elevators} elevators are not in Running Status and are being serviced. You currently have #{quotes} quotes awaiting processing. You currently have #{leads} leads in your contact requests. #{batteries} Batteries are deployed across #{cities} cities",
            accept: "audio/mp3",
            voice: "en-GB_KateV3Voice"
        ).result

        File.open("#{Rails.root}/public/outputs.mp3", "wb") do |audio_file|
                        audio_file.write(response)
        end    
    end
end