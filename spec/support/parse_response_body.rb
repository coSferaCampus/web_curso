def response_body_json
  JSON.parse( response.body )
end

def to_string_classes
  [ Symbol, Date, DateTime, BSON::ObjectId ]
end

def to_representation_value( value )
  case value.class.to_s
  when 'Date', 'DateTime'
    value.strftime( "%Y-%m-%d" )
  when 'Symbol', 'BSON::ObjectId'
    value.to_s
  else
    value
  end
end
