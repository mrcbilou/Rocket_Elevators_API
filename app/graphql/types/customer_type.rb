module Types
  class CustomerType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :company_name, String, null: true
    field :company_contact_full_name, String, null: true
    field :company_contact_phone, String, null: true
    field :company_contact_email, String, null: true
    field :company_description, String, null: true
    field :technical_authority_full_name, String, null: true
    field :technical_authority_phone_number, String, null: true
    field :technical_manager_email_service, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :address_id, Integer, null: true

    ## MMMMM those are some goooooood comments you got there boiii !!! #

    # Description #
    #
    # <Example> reference the name of the Class in the './app/models/exemple.rb' file ;
    # <Example>.all will resorte by giving you an array of object of all the row of the table related to this './app/models/exemple.rb' model ;
    # <Example>.where() .where documentation { https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where } really nice examples over there ;
    # <Example>.where() and the .where return an array ;
    # <Example>.where() .where has no problem with a bad response like the (err) => {...} but this one does ↓↓↓↓↓↓↓↓↓↓↓ ;
    # <Example>.find() you also have some other option for finding a other type by its id .find ;
    # <Example>.find() Cons:
    # <Example>.find() the request return an (err) if not capable of finding the id provided ;
    # <Example>.find() Pros:
    # <Example>.find() does not return an array and only return one object ;
    #
    # <example> can be a custom name but normaly you keep it the same but lower case and if you return more than one object you make it plural ;
    # <exemple> will be the name you'll see in the GraphiQL interface on the http://localhost:3000/graphiql/ ;
    #
    # Description #



    # # EXAMPLE START #
    #
    # field :<example>, Types::<ExampleType>, null: true
    #
    # def <exemple> # same as field name ;
    #   <Example>.find()  
    # end
    #
    # field :<exemple<plural version>>, [Types::<ExempleType>], null: true # null: <<true> || <false>   not sure but, i think this is if you want to make optional the possibility of returning something 'null'
    #
    # def <example<plural version>>
    #   <Example>.all();
    # #      OR
    #   <Example>.where( <columnName>: object.<valueVar> ); # more at :  https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where
    # end
    #
    # # EXAMPLE END #

    # /user
    field :user, Types::UserType, null: true

    def user
      User.where(id: object.user_id)[0]
    end
  end
end
