class ShelfFinder::Result
  attr_reader :locations

  def initialize(segments)
    @locations = []

    segments.each do |segment|
      location = @locations.find{|_| _.identifier == segment.shelf.location.identifier} || begin
        new_location = LocationResult.new(segment.shelf.location)
        @locations << new_location
        new_location
      end

      shelf = location.shelves.find{|_| _.identifier == segment.shelf.identifier} || begin
        new_shelf = ShelfResult.new(segment.shelf)
        location.add_shelf(new_shelf)
        new_shelf
      end

      shelf.add_segment(SegmentResult.new(segment))
    end
  end

  def present?
    @locations.present?
  end

end
