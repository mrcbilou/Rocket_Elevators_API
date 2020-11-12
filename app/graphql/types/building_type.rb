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

    # /admin_contact
    field :admin_contact, Types::EmployeeType, null: true

    def admin_contact
      Employee.where(id: object.admin_contact_id)[0]
    end

    # /technical_contact
    field :technical_contact, Types::EmployeeType, null: true

    def technical_contact
      Employee.where(id: object.technical_contact_id)[0]
    end

    # /address
    field :address, Types::AddressType, null: true

    def address
      Address.where(id: object.address_id)[0]
    end

    # /customer
    field :customer, Types::CustomerType, null: true

    def customer
      Customer.where(id: object.customer_id)[0]
    end

    # /buildingDetail
    field :building_detail, Types::BuildingDetailType, null: true

    def building_detail
      BuildingDetail.where(id: object.building_detail_id)[0]
    end
  end
end
