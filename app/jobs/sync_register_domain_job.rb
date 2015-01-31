class SyncRegisterDomainJob < ActiveJob::Base
  include SyncJob

  PATH = Rails.configuration.x.registry_url + '/orders'

  queue_as :sync_fred_records

  def perform record
    execute :post, path: PATH, body: record
  end
end
