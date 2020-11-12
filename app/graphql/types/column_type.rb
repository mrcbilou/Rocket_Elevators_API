module Types
  class ColumnType < Types::BaseObject
    field :id, ID, null: false
    field :battery_id, Integer, null: true
    field :column_type, String, null: true
    field :column_status, String, null: true
    field :number_of_floors_served, Integer, null: true
    field :information, String, null: true
    field :notes, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    #/battery
    field :battery, Types::BatteryType, null: true

    def battery
      Battery.where(id: object.battery_id)[0]
    end
  end
end
