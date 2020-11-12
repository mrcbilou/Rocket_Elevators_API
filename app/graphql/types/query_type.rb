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

    # /interventions
    field :interventions, [Types::FactInterventionType], null: true

    def interventions
      FactIntervention.all
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
