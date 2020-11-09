class CreateDimCustomer < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      
      t.date :customer_creation_date
      t.string :company_name #customer table
      t.string :company_contact_full_name #customer table
      t.string :company_contact_email #customer table
      t.integer :elevator_number # customer > quote > elevator_number
      t.string :customer_city #customer table

      t.timestamps
    end

    create_table :fact_interventions do |t|
      t.integer :employee_id
      t.integer :building_id
      t.integer :battery_id
      t.integer :column_id
      t.integer :elevator_id
      t.date :start_intervention
      t.date :end_intervention
      t.string :result
      t.string :report
      t.string :status
      t.timestamps
    end
  end
end
