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
