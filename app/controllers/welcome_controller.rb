class WelcomeController < InheritedResources::Base

  def index
    @map = map
  end
  
  private
  
  def map
    MapLayers::JsExtension::MapBuilder.new("map") do |builder, page|
      # OpenStreetMap layer
      page << builder.map.add_layer(MapLayers::OpenLayers::OSM_MAPNIK)

      # Add a button to hide/show layers
      page << builder.map.add_control(MapLayers::OpenLayers::Control::LayerSwitcher.new)

      # Add mouse coordinates
      page << builder.map.add_control(MapLayers::OpenLayers::Control::MousePosition.new)

      # Add a vector layer to read from kml url
      page << builder.add_vector_layer('stop_areas', "/stop_areas.kml", :format => :kml)
      
      # Initialize select, point, path, polygon and drag control for features
      # you may want to handle event on only one layer
      #page << builder.map_handler.initialize_controls('map_controls', 'pikts')
      # if you need to handle events on multiple layers, add all theses layers to the initializer
      # drag events and draw (point, path, polygon) events only works on the first layer, in this case 'pikts'
      page << builder.map_handler.initialize_controls('map_controls', ['stop_areas'])

      # Switch control mode, 'select' display popup on feature
      # available mode are :
      #   - select, to display popup
      #   - point, to create points on map
      #   - path, to draw path on map
      #   - polygon, to draw polygons on map
      #   - drag, to move features
      #   - none, to disable all controls
      page << builder.map_handler.toggle_control('map_controls', 'select')

      page << builder.map.zoom_to_max_extent()
    end

  end
  
end
