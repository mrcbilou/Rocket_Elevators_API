require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson

class WatsonController < ActionController::Base
  after_update :greeting
    def greeting
  
        authenticator = Authenticators::IamAuthenticator.new(
            apikey: ENV["IBM_KEY"]
        )
        text_to_speech = TextToSpeechV1.new(
            authenticator: authenticator
        )
        text_to_speech.service_url = ENV["IBM_URL"]
        
        elevators = Elevator.count
        buildings = Building.count
        customers = Customer.count
        not_active_elevators = Elevator.where.not(elevator_status:'active').count
        quotes = Quote.count
        leads = Lead.count
        batteries = Battery.count
        cities = Address.count(:city)        
        #"Greetings. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{not_active_elevators} are not in 
        #Running Status and are being serviced. You currently have #{quotes} quotes awaiting processing. You currently have #{leads} leads in your contact requests. #{batteries} Batteries are deployed across #{cities} cities",
        response = text_to_speech.synthesize(
            text: "banane",
            accept: "audio/mp3",
            voice: "en-GB_KateV3Voice"
        ).result

        File.open("app/assets/audios/outputs.mp3", "wb") do |audio_file|
                        audio_file.write(response)
                    end
        

        soundFile = File.open("app/assets/audios/outputs.mp3", "r")
        binary = soundFile.read

        send_data binary, filename: 'outputs.mp3', type: 'audio/mp3', disposition: 'inline'


        
    end
  
end