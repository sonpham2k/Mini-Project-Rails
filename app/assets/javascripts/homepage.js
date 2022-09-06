//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap

// //comment
// var main = function () {
//   $('.btn').click(function () {
//     var post = $('.status-box').val();
//     $('<li>').text(post).prependTo('.posts');
//     $('.status-box').val('');
//     $('.counter').text('250');
//     $('.btn').addClass('disabled');
//   });
//   $('.status-box').keyup(function () {
//     var postLength = $(this).val().length;
//     var charactersLeft = 250 - postLength;
//     $('.counter').text(charactersLeft);
//     if (charactersLeft < 0) {
//       $('.btn').addClass('disabled');
//     } else if (charactersLeft === 250) {
//       $('.btn').addClass('disabled');
//     } else {
//       $('.btn').removeClass('disabled');
//     }
//   });
// }
// $('.btn').addClass('disabled');
// $(document).ready(main);

var main = function () {
  $('#add').click(function () {
    var newDiv = $(`
        <div class="form-group row">
          <label class="col-md-4 col-form-label text-md-right text-white" for="post_title">Title</label>
          <div class="col-md-6">
            <input class="form-control add-posts" type="text" value="" name="content[]" required=true>
          </div>
        </div>`);
    $('#main').append(newDiv);
  });

  $('.edit').click(function () {
      document.getElementById("name").value = ;
      document.getElementById("email").value = ;
      document.getElementById("role").value = ;
  });
}
$(document).ready(main)
