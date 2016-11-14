// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $("form[action*='questions']").on('ajax:send', function() {
    $(this).children('div').children('fieldset').attr('class', 'form-group');
    $(this).children('div').children('fieldset').children('div').remove();
    $("#question_alert").remove();
    $('input').attr('disabled', true);
  });
  $("form[action*='questions']").on('ajax:success', function(event, data, status, xhr) {
    if($(this).hasClass("button_to")) {
      setTimeout (window.location.href = window.location.href, 500);
    }
    $('input').attr('disabled', false);
    $("#questionBody").append("<div class='card'><div class='card-header'>" + event.currentTarget[4].value.capitalizeFirstLetter().replace("_", " ") + "</div><div class='card-block'><p class='card-text'>" + event.currentTarget[2].value + "</p></div></div>");
    $("#newQuestion").modal('hide');
    $("#question_text").val("");
  });
  $("form[action*='questions']").on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\" id=\"question_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (let form in errors) {
        var fieldSet = $(this).find("#question_" + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (let key of errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append("<div><small class=\"text-danger\">" + error + "</small></div>");
        }
      }
    } else {
      if (data.readyState == 0) {
        $("#question_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
      }
    }
  });
});
