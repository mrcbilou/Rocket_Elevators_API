module Dwh
  class Sync

    def self.sync_fact_quotes
      for q in Quote.all do
        # gets the user from the quote in order to find the email associated with it
        user = User.find(q.user_id)
        # gets the customer from the quote to find it's company name

        if Customer.where(user_id: user.id).length > 0
          customer = Customer.where(user_id: user.id)[0]
          FactQuote.create!({
            quote_id: q.id,
            quote_created_at: q.created_at,
            company_name: customer.company_name,
            email: user.email,
            elevator_number: q.elevator_number
          })
        end
      end
    end


    def self.sync_dim_customers
      for c in Customer.all do
        # variable that counts the total number of elevator for the customer
        elevator_number = 0
        customer_buildings = Building.where(customer_id: c.id).to_a
        for building in customer_buildings do
          # goes through all the batteries linked to the building to eventually reach every elevator in every column and adds them to the elevator_number variable
          batteries = Battery.where(building_id: building.id).to_a
          for battery in batteries do
            columns = Column.where(battery_id: battery.id).to_a
            for column in columns do
              elevators = Elevator.where(column_id: column.id).to_a
              elevator_number += elevators.size
            end
          end
        end
        if Address.where(customer_id: c.address_id).length > 0
          city = Address.where(customer_id: c.address_id)[0].city

          DimCustomer.create!({
            customer_creation_date: c.created_at,
            company_name: c.company_name,
            company_contact_full_name: c.company_contact_full_name,
            company_contact_email: c.company_contact_email,
            elevator_number: elevator_number,
            customer_city: city
          })
        end
      end
    end


    def self.sync_fact_elevators
      for e in Elevator.all do
        # drilling down all the way to the address and customer table to get the relevant info for each elevator
        column = Column.find(e.column_id)
        battery = Battery.find(column.battery_id)
        building = Building.find(battery.building_id)
        
        if Customer.where(id: building.customer_id).length > 0 && Address.where(building_id: building.address_id).length > 0
          customer = Customer.find(building.customer_id)
          address = Address.find(building.address_id)
      
          FactElevator.create!({
            serial_number: e.serial_number,
            date_of_commissioning: e.date_of_commissioning,
            building_id: building.id,
            customer_id: customer.id,
            building_city: address.city
          })
        end
      end
    end


    def self.sync_fact_contacts 
      for u in User.all do

        if Customer.where(user_id: u.id).length > 0 && Lead.where(user_id: u.id).length > 0
          customer = Customer.where(user_id: u.id)[0]
          lead = Lead.where(user_id: u.id)[0]

          FactContact.create!({ 
            contact_id: u.id,
            creation_date: u.created_at,
            company_name: customer.company_name,
            email: u.email,
            project_name: lead.project_name
          })
        end
      end
    end


    def self.sync_fact_interventions
      for elev in Elevator.all do
        if elev.elevator_status == 'Intervention'
          col = Column.find(elev.column_id)
          bat = Battery.find(col.battery_id)
          build = Building.find(bat.building_id)
          employee = Employee.find(build.technical_contact_id)

          start = elev.date_of_commissioning
          stop = ["", Faker::Date.between(from: elev.date_of_commissioning, to: '2020-12-10')].sample

          if stop != ''
            result = 'Success'
            status = 'Complete'
          else
            result = ['Incomplete', 'Failure'].sample
            status = ['Pending', 'InProgress', 'Interrupted', 'Resumed'].sample
          end


          FactIntervention.create!({ 
            employee_id: employee.id,
            building_id: build.id,
            battery_id: bat.id,
            column_id: col.id,
            elevator_id: elev.id,
            start_intervention: start,
            end_intervention: stop,
            result: result,
            status: status,
            report: Faker::Lorem.sentence(word_count: rand(3..12).floor)
          })
        end
      end
    end
  end
end
