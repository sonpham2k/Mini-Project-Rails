//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap

//Add comment
var main = function () {
  var removePostIds = [];
  $('#add').click(function () {
    var newDiv = $(`
        <div class="form-group row">
          <label class="col-md-4 col-form-label text-md-right text-white" for="post_title">Title</label>
          <div class="col-md-6">
            <input class="form-control add-posts" post_id="" type="text" value="" name="content[]" required=true>
          </div>
        </div>`);
    $('#main').append(newDiv);
  });

  $('.trigger-delete-post').on('click', function(e) {
    removePostIds.push($(this).closest("li").find('input').attr('post_id'));
    $(this).closest("li").remove();
  });

  $('#submit').on('click', function (e) {
    var post_remove_ids = $(`
      <input type="hidden" name="post_remove_ids" value=` + removePostIds +`>
      `);
    $('#answer').append(post_remove_ids);
  });
}
$(document).ready(main)
