namespace :demo do
  desc "populate data for bench"
  task :populate  => :environment  do
    
    stop_array = []
    1.upto(100) do |index|
      random = Random.new
      stop_array << {
        name: "STOP #{index}",
        geom: StopArea.geos_factory.point(1.5656 + random.rand(0.05), 48.0909 +  random.rand(0.05)) }
    end
    StopArea.create stop_array
  end
end
