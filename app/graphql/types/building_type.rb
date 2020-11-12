module Types
  class BuildingType < Types::BaseObject
    field :id, ID, null: false
    field :customer_id, Integer, null: true
    field :admin_contact_id, Integer, null: true
    field :technical_contact_id, Integer, null: true
    field :administrator_full_name, String, null: true
    field :administrator_email, String, null: true
    field :administrator_phone_number, String, null: true
    field :technical_contact_full_name, String, null: true
    field :technical_contact_email, String, null: true
    field :technical_contact_phone, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :building_detail_id, Integer, null: true
    field :address_id, Integer, null: true
  end
end
