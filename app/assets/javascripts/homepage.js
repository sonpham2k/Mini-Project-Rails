//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap


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
}
$(document).ready(main)
