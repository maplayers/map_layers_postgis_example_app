class StopArea < ActiveRecord::Migration
  def change
    create_table :stop_areas do |t|
      t.string :name, limit: 255, null: false
      t.spatial  "geom", :limit => {:srid=>4326, :type=>"point", :geographic=>false}
    end
  end
end
