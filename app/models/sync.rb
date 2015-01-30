class Sync
  def self.run
    since = SyncLog.last_run
    up_to = Request.latest_time

    SyncLog.create since: since, up_to: up_to

    CreateContact.sync  since: since, up_to: up_to
  end
end
