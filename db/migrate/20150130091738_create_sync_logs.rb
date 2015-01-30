class CreateSyncLogs < ActiveRecord::Migration
  def change
    create_table :sync_logs do |t|
      t.timestamp :since, null: false
      t.timestamp :until, null: false

      t.timestamps null: false
    end
  end
end
