class Customer < ApplicationRecord
  has_many :buildings
  has_one :address, :dependent => :delete
  belongs_to :user, optional: true
  
  def custom_label_method
    "#{User.find(user_id).first_name} #{User.find(user_id).last_name}"
  end

  belongs_to :lead, optional: true
  after_save :verify_lead

  # After save on a customer, verify if there is a lead (for dropbox)
  def verify_lead
    puts "in verify lead"
    # verify if there is a lead
    if self.lead
      puts "____________THERE IS A LEAD__________________"      

        # if the lead has no attachment, print to console
        if self.lead.file_attachment == nil
          puts "__________There's no attachment in the lead_____________"
        else 
          self.lead.add_file_to_dropbox
        end        
    else
      puts "____________THERE IS NO LEAD__________________"
    end 

  end

end