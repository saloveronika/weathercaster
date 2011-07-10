class GoogleMap
  include Mongoid::Document
  include Geokit::Geocoders
  field :lat, :type => Float
  field :lon, :type => Float
  field :zoom, :type => Boolean
end
