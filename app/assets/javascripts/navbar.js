// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $("#navbar_add_group").on('ajax:send', function() {
    $(this).children('fieldset').attr('class', 'form-group');
    $(this).children('fieldset').children('div').remove();
    $("#group_alert").remove();
    $(this).children('input').attr('disabled', true);
  });
  $("#navbar_add_group").on('ajax:success', function(event, data, status, xhr) {
    $(this).children('fieldset').addClass('form-group has-success');
    setTimeout (window.location.href = xhr.getResponseHeader('Location'), 500);
  });
  $("#navbar_add_group").on('ajax:error', function(event, data, status, xhr) {
    $(this).children('input').attr('disabled', false);
    if (data.readyState == 4) {
        var fieldSet = $(this).children("fieldset");
        fieldSet.addClass('form-group has-danger');
        fieldSet.append("<div><small class=\"text-danger\">This token does not exist for a group with your role.</small></div>");
    } else if (data.readyState == 0) {
      $('#navbar_add_group_title').before("<small id='group-alert'>A network error occured, please check your internet connection.</small>");
    }
  });
});
