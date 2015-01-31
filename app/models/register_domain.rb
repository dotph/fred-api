class RegisterDomain
  include ActiveModel::Model

  attr_accessor :partner, :domain, :period, :registrant_handle

  alias_attribute :handle,      :domain
  alias_attribute :registrant,  :registrant_handle

  def self.all since:, up_to:
    RequestQuery.run(since: since, up_to: up_to).collect do |row|
      self.new row.keep_if { |key| self.instance_methods.include? "#{key}=".to_sym }
    end
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncRegisterDomainJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      partner: self.partner,
      currency_code: 'USD',
      order_details: [
        {
          type: 'domain_create',
          domain: self.domain,
          period: self.period,
          registrant_handle: self.registrant_handle
        }
      ]
    }
  end

  def period= period
    @period = period.to_i
  end
end
