json.array!(@lightning) do |lightning|
  json.extract! lightning, :id, :flash_lat, :flash_lon, :year, :month, :day, :hour, :minute, :second, :decimal_number, :flash_time, :date_time
end
