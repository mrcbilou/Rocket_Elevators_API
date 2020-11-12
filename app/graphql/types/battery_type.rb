module Types
  class BatteryType < Types::BaseObject
    field :id, ID, null: false
    field :building_id, Integer, null: true
    field :employee_id, Integer, null: true
    field :battery_type, String, null: true
    field :battery_status, String, null: true
    field :date_of_commissioning, GraphQL::Types::ISO8601Date, null: true
    field :date_of_last_inspection, GraphQL::Types::ISO8601Date, null: true
    field :certificate_of_operations, String, null: true
    field :information, String, null: true
    field :notes, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  
  
    field :building, Types::BuildingType, null: true

    def building
      Building.where(id: object.building_id)[0]
    end
  end
end
