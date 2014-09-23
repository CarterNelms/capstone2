jQuery ->
  # Autocomplete variables
  input = $('input#user_city')[0]
  searchform = $('form#form1')[0]
  place = null
  autocomplete = new google.maps.places.Autocomplete(input)

  # Google Map variables
  map = null
  marker = null

  # Add listener to detect autocomplete selection
  google.maps.event.addListener autocomplete, 'place_changed', () ->
    place = autocomplete.getPlace()

  # Add listener to search
  searchform.addEventListener "submit", () ->
    newlatlong = new google.maps.LatLng(place.geometry.location.lat(),place.geometry.location.lng())
    map.setCenter(newlatlong)
    marker.setPosition(newlatlong)
    map.setZoom(12)
   
  # Reset the input box on click
  input.addEventListener 'click', () ->
    input.value = ""



  initialize = () ->
    myLatlng = new google.maps.LatLng(51.517503,-0.133896)
    mapOptions = {zoom: 1, center: myLatlng}

    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

    marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: 'Main map'
    })

  google.maps.event.addDomListener(window, 'load', initialize)