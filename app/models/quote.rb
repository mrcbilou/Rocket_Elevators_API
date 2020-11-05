class Quote < ApplicationRecord
  belongs_to :user, optional: true

  after_create :new_quote_ticket

  def new_quote_ticket
    client = ZendeskAPI::Client.new do |config|
      config.url = 'https://teamloic.zendesk.com/api/v2'
      config.username = ENV['zendesk_email']
      config.token = ENV['zendesk_token']
    end

    user = User.find(self.user_id)

    lead = nil

    begin
      lead = Lead.find(user.id)
    rescue => exception
      puts "User does not have a business name yet!!"
    end

    ZendeskAPI::Ticket.create!(client,
    :subject => "New quote request from #{user.first_name}",
    :comment => {
      :value => "The contact #{user.first_name} can be reached at email  #{user.email}.\nThe client named #{user.first_name} has made a new quote request.\nHe/She needs a total of #{self.elevator_number} elevators for a building type of #{self.building_type} that has #{self.floors} floors.He/She also selected a product from the #{self.product_line} product line, for a total price of #{number_to_currency(self.total_price, :unit => "$")} and a total installation fee of #{number_to_currency(self.install_fee, :unit => "$")}."
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