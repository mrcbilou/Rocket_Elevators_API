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

    # /user
    field :user, Types::UserType, null: true

    def user
      User.where(id: object.user_id)[0]
    end
  end
end
