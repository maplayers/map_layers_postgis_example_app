# kml builder
xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.kml(:xmlns=>"http://earth.google.com/kml/2.2") do
  xml.Document do
    xml.name "#{@stop_areas.class.to_s}_collection"

    # styles examples
    xml.StyleMap :id => "sunny_icon_pair" do
      xml.Pair do
        xml.key "normal"
        xml.styleUrl "#sunny_icon_normal"
      end
      xml.Pair do
        xml.key "highlight"
        xml.styleUrl "#sunny_icon_highlight"
      end
    end

    xml.Style :id => "sunny_icon_normal" do
      xml.IconStyle do
        xml.scale "1.2"
        xml.Icon do
          xml.href "http://maps.google.com/mapfiles/kml/shapes/sunny.png"
        end
        xml.hotSpot :x => "0.5", :y => "0.5", :xunits => "fraction", :yunits => "fraction"
      end
      xml.LabelStyle do
        xml.color "ff00aaff"
      end
    end

    xml.Style :id => "sunny_icon_highlight" do
      xml.IconStyle do
        xml.scale "1.4"
        xml.Icon do
          xml.href "http://maps.google.com/mapfiles/kml/shapes/sunny.png"
        end
        xml.hotSpot :x => "0.5", :y => "0.5", :xunits => "fraction", :yunits => "fraction"
      end
      xml.LabelStyle do
        xml.color "ff00aaff"
      end
    end

    #xml.Style ... your styles here

    xml.Folder do
      xml.name @folder_name

      @stop_areas.each do |stop_area|
        unless stop_area.geom.nil? || stop_area.geom.y.nil? || stop_area.geom.x.nil?
          xml.Placemark do
            # id
            xml.id "#{dom_id(stop_area)}"

            # place name
            name = stop_area.respond_to?('name') ? stop_area.name : "#{dom_id(stop_area)}"
            xml.name "#{name}"

            # place description
            # xml.description do
            #  xml.cdata! "#{stop_area.description}"
            # end

            # popup url
            xml.popup_content_url polymorphic_path([:popup_content, stop_area]) rescue nil

            xml.styleUrl "#sunny_icon_pair"
            #xml.styleUrl "##{stop_area.map_layers_marker}" if stop_area.respond_to?('map_layers_marker')

            # place link
            #xml.link browse_path(stop_area.url)

            # place geoloc
            altitude = stop_area.respond_to?('altitude') ? stop_area.altitude : 0
            xml.Point do
              xml.coordinates "#{stop_area.geom.x.to_f},#{stop_area.geom.y.to_f},#{altitude}"
            end
          end
        end
      end

    end


  end
end

