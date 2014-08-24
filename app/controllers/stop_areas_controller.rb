class StopAreasController < InheritedResources::Base
	actions :index, :show

  respond_to :kml, :only => [:index]

  def index
    super do |format|      
      # add this line to respond to format kml using your renderer
      format.kml {
        render 'map_layers/stop_areas'
      }
    end
  end
  
end
