class SyncCreateContactJob < ActiveJob::Base
  include SyncJob

  PATH = Rails.configuration.x.registry_url + '/contacts'

  queue_as :sync_records

  def perform record
    execute :post, path: PATH, body: record
  end
end
