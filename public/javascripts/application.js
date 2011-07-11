function initialize_maps(){
  if (GBrowserIsCompatible())
    {
        // create map and add controls
        var map = new GMap2(document.getElementById("map"));

        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
        // add Hybrid View property
        map.setMapType(G_HYBRID_MAP);
        // set centre point of map
        var centrePoint = new GLatLng('49.83771950848911', '24.008442163467407');
        map.setCenter(centrePoint, 14);

        // add a draggable marker
        var marker = new GMarker(centrePoint, {draggable: true});
        map.addOverlay(marker);

        //enable zoom changing by mouse wheel
        map.enableScrollWheelZoom();

        cursor = marker.getPoint();
        coordContainer = {lat: cursor.lat(), lng: cursor.lng()}
        // add a drag listener to the map
        GEvent.addListener(marker, "dragend", function() {
                point = marker.getPoint();
                map.panTo(point);
                // TODO use lat and long properties if needed
                document.getElementById("latitude").value = point.lat();
                document.getElementById("longitude").value = point.lng();
                coordContainer = {lat: point.lat(), lng: point.lng()}
        });
    }
}

// handle binde ajax events
jQuery(function($) {
  // create a convenient toggleLoading function
  var toggleLoading = function() { $("#loader").toggle() };
  var beforeLoad = function(){
      $("#weather").hide();
      toggleLoading();};
  var afterLoad = function(){
      toggleLoading();
      $("#weather").show();};

  $("#post-form")
    .bind("ajax:before",  beforeLoad)
    .bind("ajax:complete", afterLoad)
    .bind("ajax:success", function(event, data, status, xhr) {
      $("#weather").html(data);
    });
});