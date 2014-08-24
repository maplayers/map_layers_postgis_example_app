class StopArea < ActiveRecord::Base
  include RgeoExt
  set_rgeo_factory_for_column(:geom, @@geos_factory)
  
end
