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

    ## EXAMPLE for adding relation to a type
    #
    # field :<the name of the field to be added (this can be anything, make sure to keep it simple)>, <if you want multiple "thing" [Types::<ThingType>] || if you want a single "thing" Types::<ThingType>>, null: <<true> || <false>>
    #
    # The function to get the "thing"
    # def <same as the name of the field previously describe>
    #   Example.where(example: object(this "object" would be the result/return of one of the fields for the type you are in).<field wanted>)!the function return an array be carefull if needed look in the other files for reference! => refer to documentation provided in discord #notes-et-ressources  https://discord.com/channels/772095972218110013/772095972218110016/776349053419520031
    # end

    # /user
    field :user, Types::UserType, null: true

    def user
      User.where(id: object.user_id)[0]
    end
  end
end
