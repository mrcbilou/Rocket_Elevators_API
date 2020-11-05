class Customer < ApplicationRecord
  has_many :buildings
  has_many :leads
  has_one :address, :dependent => :delete
  belongs_to :user

  after_update :dropbox

  def dropbox
    customer_leads = Lead.where(customer_id: self.id)
    client = DropboxApi::Client.new ENV["dropbox_token"]
    folder_list = client.list_folder('', :recursive => false)
    user = User.find(self.user_id)
    
    maybe_folder = false
    maybe_file = false
    
    for folder in folder_list.entries do
      if folder.name == user.first_name
        maybe_folder = true
      end
    end
    
    if !maybe_folder
      client.create_folder "/#{user.first_name}"
    end
    
    customer_files_list = client.list_folder("/#{user.first_name}", :recursive => false)

    for l in customer_leads do
      if !l.attachment.file.nil?
        # for customer_files in customer_files_list.entries do
        #   if customer_files.name == l.attachment_identifier
        #     maybe_file = true
        #   end
        # end

        # if !maybe_file
          file_content = IO.read "#{l.attachment.current_path}"
          client.upload "/#{user.first_name}/#{l.attachment_identifier}", file_content, :mode => :add
        # end
      end
    end
  end
end