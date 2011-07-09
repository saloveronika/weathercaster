class GoogleMap
  include Mongoid::Document
  field :lat, :type => Float
  field :lon, :type => Float
  field :zoom, :type => Boolean
end
