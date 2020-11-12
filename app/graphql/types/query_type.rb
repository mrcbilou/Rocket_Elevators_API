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


    ## EXAMPLE : for custom query, this wont work it is just an example
    #
    # !!! are optional, only use if searching for a particular "thing"
    #
    # name of the query that will be perform (this is customisable)
    # /customQuery
    # field :<customQueryName>(!!!<thing>:!!!), <the type of data that the query will return (a string should be good)>, null: <<true> || <false> (not sure but, i think this is if you want to make optional the possibility of returning something 'null')> !!!do!!!
    #   !!!argument :<thing>, <the type of the "thing">, required: <<true> || <false>>
    # end
    #
    # the method where the query take place :
    # def <customQueryName>
    #   <SqlTableName (refer to the name in the './app/models/example.rb' at first line)>.where(<see the documentation in 'notes-et-ressources' on discord for more info>)
    # end
    ##
  end
end
