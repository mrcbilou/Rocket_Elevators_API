require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson
RailsAdmin.config do |config|
  config.authorize_with :cancancan

  config.model 'User' do
    object_label_method do
    :custom_label_method
    end
    exclude_fields :id
  end

  config.model 'Employee' do
    object_label_method do
    :custom_label_method
    end
    exclude_fields :id
  end

  config.model 'Address' do
    object_label_method do
    :custom_label_method
    end
    exclude_fields :id
  end

  config.model 'Building' do
    exclude_fields :id, :address_id, :building_detail_id
  end

  config.model 'Battery' do
    exclude_fields :id
  end

  config.model 'Column' do
    exclude_fields :id
  end

  config.model 'Elevator' do
    exclude_fields :id
  end

  config.model 'BuildingDetail' do
    object_label_method do
    :custom_label_method
    end
    exclude_fields :id
  end

  config.model 'Customer' do
    object_label_method do
    :custom_label_method
    end
    exclude_fields :id
  end


  ### Popular gems integration
  def greeting
    authenticator = Authenticators::IamAuthenticator.new(
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
          text: "Test.",
          accept: "audio/wav",
          voice: "en-US_AllisonV3Voice"
        )
        audio_file.write(response).result
      end
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
    greeting
  end
  
  config.current_user_method(&:current_user)

  config.main_app_name = ["Rocket Elevators", "BackOffice"]

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
