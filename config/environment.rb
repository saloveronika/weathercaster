# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Wheathercaster::Application.initialize!

require File.expand_path('../../lib/configurer', __FILE__)
