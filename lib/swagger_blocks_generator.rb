class SwaggerBlocksGenerator
  TAB = 2

  def generate_swagger_shema_create data, space = 0
    [
      "#{ front_space(space) }swagger_schema :Input#{ data[:name].capitalize }Create do",
      generate_model(data, space + TAB),
      "#{ front_space(space) }end"
    ].join("\n")
  end

  def generate_swagger_shema_update data, space = 0
    [
      "#{ front_space(space) }swagger_schema :Input#{ data[:name].capitalize }Update do",
      generate_model(data, space + TAB),
      "#{ front_space(space) }end"
    ].join("\n")
  end

  def generate_swagger_shema_output data, space = 0
    [
      "#{ front_space(space) }swagger_schema :Output#{ data[:name].capitalize } do",
      generate_model(data, space + TAB),
      "#{ front_space(space) }end"
    ].join("\n")
  end

  def generate_model data, space = 0
    [
      "#{ front_space(space) }key :required, #{ data[:required].to_s }",
      "#{ front_space(space) }key :type, :object",
      "#{ front_space(space) }property :#{ data[:name] } do",
      generate_properties(data[:attributes], space + TAB),
      "#{ front_space(space) }end"
    ].join("\n")
  end

  def generate_properties data, space = 0
    data.map { |key, value| render_property(key, value, space) }.join("\n")
  end

  private
  def front_space space = 0
    ' ' * space
  end

  def render_property key, value, space = 0
    [
      "#{ front_space(space) }property :#{ key } do",
      render_attribute(key, value, space),
      "#{ front_space(space) }end"
    ].join("\n")
  end

  def render_attribute key, value, space = 0
    if value.is_a? String
      render_attribute_string key, value, space
    elsif value.is_a? Integer
      render_attribute_integer key, value, space
    elsif value.is_a? Float
      render_attribute_float key, value, space
    elsif value.is_a? Hash
      render_attribute_hash key, value, space
    elsif value.is_a? TrueClass
      render_attribute_boolean key, value, space
    elsif value.is_a? FalseClass
      render_attribute_boolean key, value, space
    elsif value.is_a? DateTime
      render_attribute_date_time key, value, space
    elsif value.is_a? Array
      render_attribute_array key, value, space
    elsif value.is_a? Class
      render_attribute_class key, value, space
    else
      "#{ key } #{ value }"
    end
  end

  def render_attribute_string key, value, space = 0
    [

      "#{ front_space(space + TAB) }key :type, :string",
      "#{ front_space(space + TAB) }key :example, '#{ value }'",

    ].join("\n")
  end

  def render_attribute_integer key, value, space = 0
    [
      "#{ front_space(space + TAB) }key :type, :integer",
      "#{ front_space(space + TAB) }key :format, :int64",
      "#{ front_space(space + TAB) }key :example, #{ value }",
    ].join("\n")
  end

  def render_attribute_float key, value, space = 0
    [
      "#{ front_space(space + TAB) }key :type, :float",
      "#{ front_space(space + TAB) }key :example, #{ value }",
    ].join("\n")
  end

  def render_attribute_boolean key, value, space = 0
    [
      "#{ front_space(space + TAB) }key :type, :boolean",
      "#{ front_space(space + TAB) }key :example, #{ value }",
    ].join("\n")
  end

  def render_attribute_date_time key, value, space = 0
    [
      "#{ front_space(space + TAB) }key :type, :'date-time'",
      "#{ front_space(space + TAB) }key :example, '#{ value.iso8601 }'",
    ].join("\n")
  end

  def render_attribute_array key, value, space = 0
    [
      "#{ front_space(space + TAB) }key :type, :array",
      "#{ front_space(space + TAB) }items do",
      value.first.map { |k, v| render_property(k, v, space + TAB * 2) }.join("\n"),
      "#{ front_space(space + TAB) }end",
    ].join("\n")
  end

  def render_attribute_class key, value, space = 0
    [
      "#{ front_space(space + 0) }property :#{ key } do",
      "#{ front_space(space + TAB) }key :type, :object",
      "#{ front_space(space + TAB) }key :'$ref', :Output#{ value.to_s }",
      "#{ front_space(space + 0) }end",
    ].join("\n")
  end

  def render_attribute_hash key, value, space = 0
    [
      "#{ front_space(space + 0) }property :#{ key } do",
      "#{ front_space(space + TAB) }key :type, :object",
      value.map { |key, value| render_property(key, value, TAB) }.join("\n"),
      "#{ front_space(space + 0) }end",
    ].join("\n")
  end
end
