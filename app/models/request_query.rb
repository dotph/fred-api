class RequestQuery
  def self.run since:, up_to:, type:
    group(query(since: since, up_to: up_to, type: type).to_hash)
  end

  private

  def self.query since:, up_to:, type:
    request         = Arel::Table.new('request')
    request_type    = Arel::Table.new('request_type')
    property_name   = Arel::Table.new('request_property_name')
    property_value  = Arel::Table.new('request_property_value')

    query = request.project(request[:id].as('id'),
                            request[:time_end].as('timestamp'),
                            request[:user_name].as('partner'),
                            request_type[:name].as('type'),
                            property_name[:name].as('name'),
                            property_value[:value].as('value'))
      .join(request_type).on(request[:request_type_id].eq(request_type[:id]))
      .join(property_value).on(request[:id].eq(property_value[:request_id]))
      .join(property_name).on(property_value[:property_name_id].eq(property_name[:id]))
      .where(request_type[:name].eq(type))
      .where(request[:time_begin].gt(since))
      .where(request[:time_end].lteq(up_to))

    Request.connection.select_all query.to_sql
  end

  def self.group records
    groups = {}

    records.each do |record|
      id      = record['id']
      name    = record['name']
      value   = record['value']
      partner = record['partner']

      unless groups.include? id
        groups[id] = {}
      end

      converted_name = name.sub('.', '_').downcase

      group = groups[id]
      group[converted_name] = value

      group['partner'] = partner unless group.include? 'partner'
    end

    groups.values
  end
end
