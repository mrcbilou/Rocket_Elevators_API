class WatsonController < ApplicationController
    require "ibm_watson/authenticators"
    require "ibm_watson/text_to_speech_v1"
    include IBMWatson
    
    def greeting    
        authenticator = Authenticators::IamAuthenticator.new(
        apikey: ENV['TEXT_TO_SPEECH_IAM_APIKEY']
        )
        text_to_speech = TextToSpeechV1.new(
        authenticator: authenticator
        )
        text_to_speech.service_url = "https://api.us-east.text-to-speech.watson.cloud.ibm.com/instances/ab3558eb-6b00-40ff-a647-bdafd0e455a5"

        total_elevators = Elevator.count
        total_buildings = Building.count
        
        
        File.open("app/assets/audio/greeting.wav", "wb") do |audio|
            response = text_to_speech.synthesize(
              text: "Hello world",
              accept: "audio/wav",
              voice: "en-US_AllisonV3Voice"
            )
            audio_file.write(response.result)
        end
    end
end
