class Configurer

  def initialize
    path = File.expand_path('../../config/services.yml', __FILE__)
    config = YAML.load_file(path)
    @services = HashWithIndifferentAccess.new(config)[Rails.env]
  end

  def google_api_key
    @services[:api_key]
  end

end

config = Configurer.new

# initialize googlemaps API key
API_KEY = config.google_api_key
