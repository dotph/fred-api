class CreateRequest < ActiveRecord::Migration
  def change
    create_table :request do |t|
      t.timestamp :time_begin,      null: false
      t.timestamp :time_end
      t.string    :source_ip
      t.integer   :service_id,      null: false
      t.integer   :request_type_id, default: 1000
      t.integer   :session_id
      t.string    :user_name
      t.boolean   :is_monitoring,   null: false,  default: false
      t.integer   :result_code_id
      t.integer   :user_id
    end
  end
end
