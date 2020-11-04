class Quote < ApplicationRecord
  belongs_to :user, optional: true
  
  after_create :new_quote_ticket

    def new_quote_ticket
      client = ZendeskAPI::Client.new do |config|
        config.url = 'https://teamloic.zendesk.com/api/v2'
        config.username = ''
        config.token = ''
      end

      user = User.find(self.user_id)

      lead = nil

      begin
        lead = Lead.find(user.id)
      rescue => exception
        puts "User does not have a business name yet!!"
      end

      ZendeskAPI::Ticket.create!(client,
      :subject => "#{user.first_name} #{user.last_name} from #{lead.business_name}",
      :comment => {
          :value => "The contact #{user.first_name} #{user.last_name} from company #{lead.business_name} can be reached at email  #{user.email} and at phone number #{lead.phone}.\n#{lead.department} has a project named #{lead.project_name} which would require contribution from Rocket Elevators.\nThe client named #{user.first_name} has made a new quote request.He/She needs a total of #{self.elevator_number} elevators, for a total price of #{self.total_price} "
      },
      :requester => {
        "name": "#{user.first_name} #{user.last_name}",
        "email": user.email
      },
      :priority => "Normal",
      :type => "Task"
      )
    end
end