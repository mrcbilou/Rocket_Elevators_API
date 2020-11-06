require 'dropbox_sdk'

class LeadsController < ApplicationController
    def user_leads
        @leads = Lead.where(:user_id => current_user.id)
    end

    def create
        @lead = Lead.new(lead_params)
        if user_signed_in?
            @lead.user_id = current_user.id
        end

        @lead.save

        # sendMail

        respond_to do |format|
            if @lead.save && user_signed_in?
                format.html { redirect_to my_leads_path, notice: 'Your lead as been successfully registered !' }
            elsif @lead.save && !user_signed_in?
                format.html { redirect_to root_path, notice: 'Your lead as been successfully registered !' }
            else
                format.html { render :new }
            end
        end
    end

    def sendMail
        email = @lead.email
        full_name = @lead.full_name
        project_name = @lead.project_name
        phone = @lead.phone

        mail = SendGrid::Mail.new
        mail.from = SendGrid::Email.new(email: "rocketelevatorswk7@gmail.com")

        personalization = SendGrid::Personalization.new
        personalization.add_to(SendGrid::Email.new(email: email))
        personalization.add_dynamic_template_data({
            "full_name" => full_name,
            "project_name" => project_name,
            "phone" => phone
        })

        mail.add_personalization(personalization)
        mail.template_id = 'd-15d6bef02786488fa205bd75c1fa8f51'

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        
        response = sg.client.mail._('send').post(request_body: mail.to_json)
    end

    def edit
        @lead = Lead.edit
    end

    def new
        @lead = Lead.new
    end

    private
    def lead_params
        params.require(:lead).permit(:attachment, :full_name, :email, :phone, :business_name, :project_name, :department, :project_description, :message, :user_id)
    end
end
