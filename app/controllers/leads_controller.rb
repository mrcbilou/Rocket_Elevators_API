require 'dropbox_sdk'

class LeadsController < ApplicationController
    def user_leads
        @leads = Lead.where(:user_id => current_user.id)
    end
    
    # def dropbox_callback
    #     dbsession = DropboxSession.deserialize(session[:dropbox_session])
    #     dbsession.get_access_token #we've been authorized, so now request an access_token
    #     session[:dropbox_session] = dbsession.serialize
    #     current_user.update_attributes(:dropbox_session => session[:dropbox_session])
    #     session.delete :dropbox_session
    #     flash[:success] = "You have successfully authorized with dropbox."
            
    #     redirect_to root_path
    # end

    # def authorize
    #     dbsession = DropboxSession.new('jn6w9hunmjoz9wz', '471ypoftfnv8irv')
    #     #serialize and save this DropboxSession
    #     session[:dropbox_session] = dbsession.serialize
    #     #pass to get_authorize_url a callback url that will return the user here
    #     redirect_to dbsession.get_authorize_url url_for(:action => 'dropbox_callback')
    # end

    def create
        @lead = Lead.new(lead_params)
        if user_signed_in?
        @lead.user_id = current_user.id
        end
        @lead.save

        # authorize

        # dbsession = DropboxSession.deserialize(current_user.dropbox_session)
        # # create the dropbox client object
        # client = DropboxClient.new(dbsession, DROPBOX_APP_MODE)
        # data = File.read("/app/assets/images/noYou/image.png")
        # client.put_file("image.png",data)

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
