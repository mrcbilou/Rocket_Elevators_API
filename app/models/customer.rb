class Customer < ApplicationRecord
  has_many :buildings
  has_one :address, :dependent => :delete
  belongs_to :user, optional: true
  
  def custom_label_method
    "#{User.find(user_id).first_name} #{User.find(user_id).last_name}"
  end

  belongs_to :lead, optional: true

  after_update :dropbox

  def dropbox
    client = DropboxApi::Client.new "OJer-fIk1egAAAAAAAAAAXwWvxK41QGvguoxxxD8hJoYb_uTdMZhxrKZNcXarM8e"
    client.create_folder "/create_folder"
    pp client
    client.upload "/create_folder/text.txt", "new folder/file", :mode => :add
  end
end