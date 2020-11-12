module Types
  class BuildingDetailType < Types::BaseObject
    field :id, ID, null: false
    field :building_id, Integer, null: true
    field :information_key, String, null: true
    field :value, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
