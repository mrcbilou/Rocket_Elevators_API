require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

class WatsonController < ActionController::Base
  
    def speak
  
        authenticator = Authenticators::IamAuthenticator.new(
            apikey: 
        )
        text_to_speech = TextToSpeechV1.new(
            authenticator: authenticator
        )
            
        text_to_speech.service_url =
        
        elevators = Elevator.count
        buildings = Building.count
        customers = Customer.count
        not_active_elevators = Elevator.where.not(elevator_status:'ACTIVE').count
        quotes = Quote.count
        leads = Lead.count
        batteries = Battery.count
        cities = Address.count(:city)

        response = text_to_speech.synthesize(
            text: "Greetings. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers.",
            accept: "audio/mp3",
            voice: "en-GB_KateV3Voice"
        ).result

        File.open("#{Rails.root}/public/outputs.mp3", "wb") do |audio_file|
                        audio_file.write(response)
        end    
    end
  
end