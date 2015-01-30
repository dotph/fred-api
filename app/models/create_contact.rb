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
    RequestQuery.run.collect do |row|
      self.new row.keep_if { |key| self.instance_methods.include? "#{key}=".to_sym }
    end
  end
end
