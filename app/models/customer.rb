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

    maybe = false

    for folder in folder_list.entries do
      if folder.name == user.first_name
        maybe = true
      end
    end

    if !maybe
      client.create_folder "/#{user.first_name}"
    end

    for l in customer_leads do
      if !l.attachment.file.nil?
        file_content = IO.read "#{l.attachment.current_path}"

        client.upload "/#{user.first_name}/#{l.attachment_identifier}", file_content, :mode => :add
      end
    end
  end
end