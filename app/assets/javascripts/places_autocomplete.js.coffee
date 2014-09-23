jQuery ->
  $input = $('input#user_city')
  autocomplete = new google.maps.places.Autocomplete($input)
  # $input.on 'input', (e) ->
  #   console.log($(this).val())

  # Add listener to detect autocomplete selection
  # google.maps.event.addListener(autocomplete, 'place_changed', () ->
  #   place = autocomplete.getPlace()
  #   console.log(place)

  $input.on 'input', (e) ->
    console.log x
    # console.log autocomplete.getPlace()