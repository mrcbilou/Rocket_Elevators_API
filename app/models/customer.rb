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
    pp folder_list
    # pp client
    maybe = false

    user = User.find(self.user_id)

    for folder in folder_list.entries do
      if folder.name == user.first_name
        maybe = true
      end
    end

    if !maybe
      client.create_folder "/#{user.first_name}"
    end

    for l in customer_leads do
      if l.attachment == ""
        pp l.attachment.current_path
      end

      # pp "The customer ##{self.id} has the lead ##{l.id} and the lead has the attachment named #{}"

      # lead_attachment_list = client.list_folder('', :recursive => false)

      # client.upload "/create_folder/test.txt", "new folder/file", :mode => :add
    end
  end
end