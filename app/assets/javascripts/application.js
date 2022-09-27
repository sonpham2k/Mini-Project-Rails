//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require toastr
//= require chartkick
//= require Chart.bundle

var main = function () {
    $('#user_avatar').on('change', function (event) {
      var output = document.getElementById('target');
      output.src = URL.createObjectURL(event.target.files[0]);
      output.onload = function () {
        URL.revokeObjectURL(output.src)
      }
    });
  }
  $(document).ready(main)
