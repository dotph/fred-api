class CreateContact
  include ActiveModel::Model

  attr_accessor :partner, :handle, :name, :organization,
                :street, :city, :state, :postal_code, :country_code, :phone, :email

  alias_attribute :pi_name,         :name
  alias_attribute :pi_street,       :street
  alias_attribute :pi_city,         :city
  alias_attribute :pi_postalcode,   :postal_code
  alias_attribute :pi_countrycode,  :country_code

  def self.all
    RequestQuery.run.collect { |row| self.new row }
  end
end
