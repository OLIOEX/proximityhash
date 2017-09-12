require 'haversine'
require 'pr_geohash'

class ProximityHash

  MIN_PRECISION = 1
  MAX_PRECISION = 12

  EARTH_RADIUS = 6371000

  def initialize(latitude, longitude, radius, precision)
    @centre = [ latitude, longitude ]
    @radius = radius
    @precision = precision
    if ((precision > MAX_PRECISION) or (precision < MIN_PRECISION))
      raise 'Precision out bounds'
    end
  end

  def calculate
    x = 0.0
    y = 0.0

    points = []
    geohashes = {}

    grid_width = [ 5009400.0, 1252300.0, 156500.0, 39100.0, 4900.0, 1200.0, 152.9, 38.2, 4.8, 1.2, 0.149, 0.0370 ]
    grid_height = [ 4992600.0, 624100.0, 156000.0, 19500.0, 4900.0, 609.4, 152.4, 19.0, 4.8, 0.595, 0.149, 0.0199 ]

    height = (grid_height[@precision - 1]) / 2.0
    width = (grid_width[@precision - 1]) / 2.0

    latitude = @centre[0]
    longitude = @centre[1]

    lat_moves = (@radius / height).ceil
    lon_moves = (@radius / width).ceil

    (0 .. lat_moves).each do |i|

      temp_lat = y + (height * i)

      (0..lon_moves).each do |j|

        temp_lon = x + (width * j)

        if within_radius(temp_lat, temp_lon, y, x) == true

          x_cen, y_cen = get_centre(temp_lat, temp_lon, height, width)
          lat, lon = convert_to_latlon(y_cen, x_cen, latitude, longitude)
          points += [[lat, lon]]
          lat, lon = convert_to_latlon(-y_cen, x_cen, latitude, longitude)
          points += [[lat, lon]]
          lat, lon = convert_to_latlon(y_cen, -x_cen, latitude, longitude)
          points += [[lat, lon]]
          lat, lon = convert_to_latlon(-y_cen, -x_cen, latitude, longitude)
          points += [[lat, lon]]
        end

      end

    end

    points.each do |point|
      geohash = GeoHash.encode(point[0], point[1], @precision)
      geohashes[geohash] = Haversine.distance(point, @centre).to_meters
    end

    geohashes.sort_by { |key, value| value }.to_h
  end

  private

  def within_radius(latitude, longitude, centre_lat, centre_lon)

    x_diff = longitude - centre_lon
    y_diff = latitude - centre_lat

    return (((x_diff ** 2) + (y_diff ** 2)) <= (@radius ** 2))
  end

  def get_centre(latitude, longitude, height, width)

    y_cen = latitude + (height / 2.0)
    x_cen = longitude + (width / 2.0)

    return x_cen, y_cen
  end

  def convert_to_latlon(y, x, latitude, longitude)
     lat_diff = (y / EARTH_RADIUS) * (180.0 / Math::PI)
    lon_diff = (x / EARTH_RADIUS) * (180.0 / Math::PI) / Math.cos(latitude * Math::PI/180.0)

    final_lat = latitude + lat_diff
    final_lon = longitude + lon_diff

    return final_lat, final_lon
  end

end
