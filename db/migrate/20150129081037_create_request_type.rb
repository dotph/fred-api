class CreateRequestType < ActiveRecord::Migration
  def change
    create_table :request_type do |t|
      t.string  :name,        null: false
      t.integer :service_id,  null: false
    end
  end
end
