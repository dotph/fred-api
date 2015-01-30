class CreateContact
  include ActiveModel::Model

  attr_accessor :partner, :handle, :name, :organization,
                :street, :city, :state, :postal_code, :country_code, :phone, :email

  alias_attribute :pi_name,         :name
  alias_attribute :pi_street,       :street
  alias_attribute :pi_city,         :city
  alias_attribute :pi_postalcode,   :postal_code
  alias_attribute :pi_countrycode,  :country_code

  def self.all since:, up_to:
    RequestQuery.run.collect do |row|
      self.new row.keep_if { |key| self.instance_methods.include? "#{key}=".to_sym }
    end
  end

  def self.sync since:, up_to:
    all(since: since, up_to: up_to).each do |record|
      SyncCreateContactJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      partner:      self.partner,
      handle:       self.handle,
      name:         self.name,
      organization: self.organization,
      street:       self.street,
      city:         self.city,
      state:        self.state,
      postal_code:  self.postal_code,
      country_code: self.country_code,
      phone:        self.phone,
      email:        self.email
    }
  end
end
