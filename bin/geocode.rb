require 'geocoder/us'
require 'json'

db = Geocoder::US::Database.new("/opt/geocoder.db")

out = db.geocode(ARGV[0])
puts out.to_json
