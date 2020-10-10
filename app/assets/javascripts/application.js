// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#imageResult')
        .attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$(function () {
  $('#upload').on('change', function () {
    readURL(input);
  });
});

$(document).on('turbolinks:load', function() {
  function initializeAutocomplete(id) {
       var element = document.getElementById(id);
       if (element) {
         var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'], componentRestrictions: {country: ['us', 'ru']} });
         google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
         }
  }

  function onPlaceChanged() {
       var place = this.getPlace();

       // console.log(place);  // Uncomment this line to view the full object returned by Google API.

  for (var i in place.address_components) {
   var component = place.address_components[i];
   for (var j in component.types) {  // Some types are ["country", "political"]
    var type_element = document.getElementById(component.types[j]);
    if (type_element) {
     type_element.value = component.long_name;
     }
    }
   }
  }
  google.maps.event.addDomListener(window, 'turbolinks:load', function() {
   initializeAutocomplete('autocomplete_address');
   });
  });