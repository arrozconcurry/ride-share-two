require 'csv'
# require 'trip'

module RideShare
  class Rider
    attr_reader :rider_id, :name, :phone_num
    def initialize(rider_info)
      # have an ID, name and phone number
      @rider_id = rider_info[:rider_id]
      @name = rider_info[:name]
      @phone_num = rider_info[:phone_num]
    end

    def self.create_all_riders
      # retrieve all riders from the CSV file
      CSV.read(
      "support/riders.csv",
      headers: true,
      header_converters: :symbol,
      converters: :all
      ).map { |line| line.to_h }
    end

    def self.find(rider_id)
      # find a specific rider using their numeric ID
      id_find = self.create_all_riders
      id_find.each do |i|
        if i[:rider_id] == rider_id
          return i
        end
      end
    end

    def trips
      # retrieve the list of trip instances that only this rider has taken
      @all_trips = RideShare::Trip.rider_trips(@rider_id)
      return @all_trips
    end

    def unique_drivers
      trips
      # retrieve the list of all previous driver instances (through the trips functionality built above)
      unique = @all_trips.uniq { |i| i[:driver_id] }
      return unique
    end

  end
end
