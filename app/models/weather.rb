class Weather < OpenStruct
  def self.rendered_fields
    [:temperature, :icon_urls, :wind_speed, :wind_dir]
  end
end
