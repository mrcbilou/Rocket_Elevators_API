module Types
  class QueryType < Types::BaseObject

    # /users => select all user
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    # /user(id: <id_number>) => select a specific user by id
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    # /employees
    field :employees, [Types::EmployeeType], null: true
    
    def employees
      Employee.all
    end

    field :employee, Types::EmployeeType, null: false do
      argument :id, ID, required: true
    end

    def employee(id:)
      Employee.find(id)
    end

    # /interventions
    field :interventions, [Types::FactInterventionType], null: true

    def interventions
      FactIntervention.all
    end

    field :intervention, Types::FactInterventionType, null: false do
      argument :id, ID, required: true
    end

    def intervention(id:)
      FactIntervention.find(id)
    end

    #/ buildings

    field :buildings, [Types::BuildingType], null: true

    def buildings
      Building.all
    end

    field :building, Types::BuildingType, null: false do
      argument :id, ID, required: true
    end

    def building(id:)
      Building.find(id)
    end

    
    #/ customers

    field :customers, [Types::CustomerType], null: true

    def customers
      Customer.all
    end

    field :customer, Types::CustomerType, null: false do
      argument :id, ID, required: true
    end

    def customer(id:)
      Customer.find(id)
    end

    #/ Adresses

    field :addresses, [Types::AddressType], null: true

    def addresses
      Address.all
    end

    field :address, Types::AddressType, null: false do
      argument :id, ID, required: true
    end

    def address(id:)
      Address.find(id)
    end


    # EXAMPLE START #

    # /users
    # field :users, [Types::UserType], null: false
    # 
    # def users
    #   User.all
    # end
    
    # /user(id:)
    # field :user, Types::UserType, null: false do
    #   argument :id, ID, required: true
    # end
    # 
    # def user(id:)
    #   User.find(id)
    # end
    
    # EXAMPLE END #
  end
end
