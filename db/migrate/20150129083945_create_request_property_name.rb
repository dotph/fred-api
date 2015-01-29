class CreateRequestPropertyName < ActiveRecord::Migration
  def change
    create_table :request_property_name do |t|
      t.string  :name,  null: false
    end
  end
end
