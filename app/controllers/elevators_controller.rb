class ElevatorsController < ApplicationController

    def edit
      @elevator = Elevator.edit

      @elevator = Elevator.find(params[:status])
      puts "here is something !!!!!!!!!!!!!!!!!!!!!!"
    
      old_status = @elevator.status
    
      if @elevator.update(elevator_params)
        send_sms old_status
        redirect_to elevator_path(@elevator.id)
      else
        render :edit
      end
    end
    
    private
  
    def elevator_params
      params.require(:elevator).permit(:status)
    end
  
    def send_sms(old_status)
      puts "SENDDDDDIIIIIINNNNNGGGGGG"

      # require("bundler")
      # Bundler.require()
      
      # account_sid = ENV["TWILIO_ACCOUNT_SID"]
      # auth_token = ENV["TWILIO_AUTH_TOKEN"]
      
      # @client = Twilio::REST::Client.new(account_sid, auth_token)
      
      # @client.messages.create(
      #     to: '+18198171295',
      #     from: '+12058929412',
      #     body: "Hi this is a message from Rocket Elevators, telling you that a lead has been created!"
      # )
    end
end
