require 'dropbox_sdk'

class LeadsController < ApplicationController
    def user_leads
        @leads = Lead.where(:user_id => current_user.id)
    end
    
    def dropbox_callback
        dbsession = DropboxSession.deserialize(session[:dropbox_session])
        dbsession.get_access_token #we've been authorized, so now request an access_token
        session[:dropbox_session] = dbsession.serialize
        current_user.update_attributes(:dropbox_session => session[:dropbox_session])
        session.delete :dropbox_session
        flash[:success] = "You have successfully authorized with dropbox."
            
        redirect_to root_path
    end

    def authorize
        dbsession = DropboxSession.new('jn6w9hunmjoz9wz', '471ypoftfnv8irv')
        #serialize and save this DropboxSession
        session[:dropbox_session] = dbsession.serialize
        #pass to get_authorize_url a callback url that will return the user here
        redirect_to dbsession.get_authorize_url url_for(:action => 'dropbox_callback')
    end

    def create
        @lead = Lead.new(lead_params)
        if user_signed_in?
        @lead.user_id = current_user.id
        end

        #upload (lead.new(lead_attachment))

        @lead.save

        authorize

        # dbsession = DropboxSession.deserialize(current_user.dropbox_session)
        # # create the dropbox client object
        # client = DropboxClient.new(dbsession, DROPBOX_APP_MODE)
        # data = File.read("/app/assets/images/noYou/image.png")
        # client.put_file("image.png",data)

        respond_to do |format|
            if @lead.save && user_signed_in?
                format.html { redirect_to my_leads_path, notice: 'Your lead as been successfully register !' }

            elsif @lead.save && !user_signed_in?
                format.html { redirect_to root_path, notice: 'Your lead as been successfully register !' }
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
    
    # def authorize
    #     if params[:oauth_token] then
    #       dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
    #       dropbox_session.authorize(params)
    #       session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session       
    
    #       redirect_to :action => 'upload'
    #     else
    #       dropbox_session = Dropbox::Session.new('sfsjsyd7bh1wuu0_skjrprw2zx7rvhv')
    #       session[:dropbox_session] = dropbox_session.serialize
    #       redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:action => 'authorize'))
    #     end
    # end
    
    # def upload
    #     return redirect_to(:action => 'authorize') unless session[:dropbox_session]
    #     dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
    #     return redirect_to(:action => 'authorize') unless dropbox_session.authorized?
    
    #     if request.method == 'POST' then
    #       dropbox_session.mode = :dropbox
    #       File.copy("/" + params[:file].tempfile.path, '~/Documents/dropbox/' + params[:file].original_filename)
    #       params[:file].tempfile.unlink
    #       dropbox_session.upload '~/Documents/dropbox/' + params[:file].original_filename, 'RCase'
    #       render :text => 'Uploaded OK'
    #     else
    #       redirect_to(:action => 'index', :notice => 'Upload Fail')
    #     end
    #   end
    # end


    private
        def lead_params
            params.require(:lead).permit(:attachment, :full_name, :email, :phone, :business_name, :project_name, :department, :project_description, :message, :user_id)
        end

        # def lead_attachment
        #     params.require(:lead).permit(:attachment)
        # end
end
