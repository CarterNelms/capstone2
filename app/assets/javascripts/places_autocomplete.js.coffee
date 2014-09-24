# Autocomplete variables
$input = $('input#user_city')
input = $input[0]
place = null
autocomplete = new google.maps.places.Autocomplete(input)

# Google Map variables
map = null
marker = null

# # The location field should be empty initially
# $input.val('')

initialize = () ->
  myLatlng = new google.maps.LatLng(36.1667,-86.7833)
  mapOptions = {zoom: 2, center: myLatlng}

  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

  updateMap = (targetPlace=null) ->
    # place = if targetPlace then autocomplete.getPlace(targetPlace) else autocomplete.getPlace()
    place = autocomplete.getPlace()
    newlatlong = new google.maps.LatLng(place.geometry.location.lat(),place.geometry.location.lng())
    marker = new google.maps.Marker({ map: map }) if !marker
    marker.setTitle($input.val())
    map.setCenter(newlatlong)
    marker.setPosition(newlatlong)
    map.setZoom(12)

  # updateMap($input.val)

  # Add listener to detect autocomplete selection
  google.maps.event.addListener autocomplete, 'place_changed', updateMap

google.maps.event.addDomListener(window, 'load', initialize)