//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require toastr

//Add comment
var main = function () {
  var removePostIds = [];
  var checkPostIds = [];
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

  $('.trigger-delete-post').on('click', function (e) {
    removePostIds.push($(this).closest("li").find('input').attr('post_id'));
    $(this).closest("li").remove();
  });

  $('.vote-checkbox').on('click', function (e) {
    var check = $(this).closest("li").find('input').attr('post_content_id')
    let count = 0;
    let index = 0;
    for (let i = 0; i <= checkPostIds.length; i++) {
      if (checkPostIds[i] === check) {
        count++;
        index = i;
        break
      }
    }
    if (count > 0) {
      a1 = checkPostIds.slice(0, index);
      a2 = checkPostIds.slice(index + 1, checkPostIds.length);
      checkPostIds = a1.concat(a2);
    } else {
      checkPostIds.push(check);
    }
  });

  $('#submit').on('click', function (e) {
    var post_remove_ids = $(`
      <input type="hidden" name="post_remove_ids" value=` + removePostIds + `>
      `);
    $('#answer').append(post_remove_ids);
  });

  $('#submitVote').on('click', function (e) {
    e.preventDefault();
    var check_post_vote_ids = $(`
      <input type="hidden" name="post_vote_ids" value=` + checkPostIds + `>
      `);
    $('#answerVote').append(check_post_vote_ids);
    $('#vote').submit();
  });

  $('#user_avatar').on('change', function (event) {
    var output = document.getElementById('target');
    output.src = URL.createObjectURL(event.target.files[0]);
    output.onload = function () {
      URL.revokeObjectURL(output.src)
    }
  });
}
$(document).ready(main)

function openModelEditComment(message, actionUrl) {
  $('#edit_content_comment').val(message);
  $('#comment').attr('action', actionUrl);
  $('#modal-edit-comment').modal('show');
}
