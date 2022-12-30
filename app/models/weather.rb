class Weather < OpenStruct
  def self.rendered_fields
    [:temperature, :wind_speed, :wind_dir]
  end
end
