// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $("form[action*='members/']").on('ajax:send', function() {
    $("#member_alert").remove();
    $(this).attr('disabled', true);
  });
  $("form[action*='members/']").on('ajax:success', function(event, data, status, xhr) {
    $(this).parent().parent().fadeOut(1000);
  });
  $("form[action*='members/']").on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\" id=\"member_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.readyState == 0) {
      $("#member_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
    }
  });
});
