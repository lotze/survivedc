class MapController < ApplicationController
  
  def index
    @friend_locations = []
    @map_load = <<-DUPONT
    var start = new google.maps.Marker({
              icon: new google.maps.MarkerImage('//www.google.com/mapfiles/dd-start.png',
                                                              new google.maps.Size(20,34)),
              shadow: null,
              zIndex: 999,
              map: map
          });
    start.setPosition(dupont);
    var infowindow = new google.maps.InfoWindow({content:"More will be revealed Saturday evening..."});
    google.maps.event.addListener(start, 'click', function() {
      infowindow.open(map,start);
    });
    DUPONT
    if map_on
      @map_load = <<-MAP
      var surviveDCLayer = new google.maps.KmlLayer("http://www.google.com/maps/ms?authuser=0&vps=3&ie=UTF8&msa=0&output=kml&msid=217892725029110178762.0004bdcec3bc0e0f8c64a");
      surviveDCLayer.setMap(map);
      MAP
    end
    
    if game_on
      @friend_locations = {}
      friend_updates = LocationUpdate.find_by_sql ['select location_updates.* from location_updates join friend_requests on friend_requests.target_id=location_updates.user_id where friend_requests.approved=1 and friend_requests.requesting_id = ? and location_updates.created_at > NOW() - INTERVAL 30 MINUTE order by location_updates.created_at desc', current_user.id]
      friend_updates.each do |f|
        unless @friend_locations.has_key?(f.user_id)
          @friend_locations[f.user_id] = f
        end
      end
      @friend_locations = @friend_locations.values
    end
  end
end
