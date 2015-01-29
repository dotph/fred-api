class RequestQuery
  def self.run
    group(query.to_hash)
  end

  private

  def self.query
    request = Arel::Table.new('request')
    type = Arel::Table.new('request_type')
    property_name = Arel::Table.new('request_property_name')
    property_value = Arel::Table.new('request_property_value')

    query = request.project(request[:id].as('id'),
                            request[:time_end].as('timestamp'),
                            request[:user_name].as('partner'),
                            type[:name].as('type'),
                            property_name[:name].as('name'),
                            property_value[:value].as('value'))
      .join(type).on(request[:request_type_id].eq(type[:id]))
      .join(property_value).on(request[:id].eq(property_value[:request_id]))
      .join(property_name).on(property_value[:property_name_id].eq(property_name[:id]))

    Request.connection.select_all query.to_sql
  end

  def self.group records
    groups = {}

    records.each do |record|
      id    = record['id']
      name  = record['name']
      value = record['value']

      unless groups.include? id
        groups[id] = {}
      end

      converted_name = name.sub('.', '_').downcase

      group = groups[id]
      group[converted_name] = value
    end

    groups.values
  end
end
