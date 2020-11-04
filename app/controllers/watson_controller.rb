class WatsonController < ApplicationController
    require "ibm_watson/authenticators"
    require "ibm_watson/text_to_speech_v1"
    include IBMWatson
    
    def greeting   
        authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
        apikey: ENV['IBM_KEY']
        )
        text_to_speech = TextToSpeechV1.new(
        authenticator: authenticator
        )
        text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com/instances/ab3558eb-6b00-40ff-a647-bdafd0e455a5"
        
        elevators = Elevator.count
        buildings = Building.count
        customers = Customer.count
        not_active_elevators = Elevator.where.not(elevator_status:'ACTIVE').count
        quotes = Quote.count
        leads = Lead.count
        batteries = Battery.count
        cities = Address.count(:city)

   
        File.open("app/assets/audio/greeting.wav", "wb") do |audio_file|
            response = text_to_speech.synthesize(          
                text: "Greetings.",
                accept: "audio/wav",
                voice: "en-US_AllisonV3Voice"
            )
            audio_file.write(response.result)
            redirect_back(fallback_location:"/")
        end
    end
end
