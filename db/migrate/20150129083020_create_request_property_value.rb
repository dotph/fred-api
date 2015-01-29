class CreateRequestPropertyValue < ActiveRecord::Migration
  def change
    create_table :request_property_value do |t|
      t.timestamp :request_time_begin,  null: false
      t.integer   :request_service_id,  null: false
      t.boolean   :request_monitoring,  null: false
      t.integer   :request_id,          null: false
      t.integer   :property_name_id,    null: false
      t.text      :value,               null: false
      t.boolean   :output,              default: false
      t.integer   :parent_id
    end
  end
end
