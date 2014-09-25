var $input

function loadMap() {

  var input = $input[0]
  var place = null
  var autocomplete = new google.maps.places.Autocomplete(input)

  // Google Map variables
  var map = null
  var marker = null

  function initMap(){
    var myLatlng = new google.maps.LatLng(36.1667,-86.7833)
    var mapOptions = {zoom: 2, center: myLatlng}

    map = new google.maps.Map($map[0], mapOptions)

    function updateMap(coordinates=null){
      // place = if targetPlace then autocomplete.getPlace(targetPlace) else autocomplete.getPlace()
      if(!coordinates){
        place = autocomplete.getPlace()
        coordinates = {
          latitude: place.geometry.location.lat(),
          longitude: place.geometry.location.lng()
        }
      }
      var newlatlong = new google.maps.LatLng(coordinates.latitude, coordinates.longitude)
      if(!marker){marker = new google.maps.Marker({ map: map })}
      marker.setTitle($input.val())
      map.setCenter(newlatlong)
      marker.setPosition(newlatlong)
      map.setZoom(12)
    }

    updateMap(coords)

    // Add listener to detect autocomplete selection
    google.maps.event.addListener(autocomplete, 'place_changed', updateMap)
  }

  initMap()
}

$(function(){

  $input = $('input#user_location')
  $map = $('#map-canvas')

  // The location field should be empty initially
  // $input.val('')

  function loadScript(){
    script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places&callback=loadMap';
    document.body.appendChild(script);
  }

  if(typeof(google) != 'undefined' && $map.length){
    shouldLoadScript = typeof(google.maps) == 'undefined'
    nextStep = shouldLoadScript ? loadScript : loadMap
    $(document).ready(nextStep)
  }
  // $(document).ready(loadScript)
});