// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $("form[class*='group'], form[action*='reset_tokens']").on('ajax:send', function() {
    $(this).children('fieldset').attr('class', 'form-group');
    $(this).children('fieldset').children('div').remove();
    $("#group_alert").remove();
    $('input').attr('disabled', true);
  });
  $("form[class*='group'], form[action*='reset_tokens']").on('ajax:success', function(event, data, status, xhr) {
    $(this).children('fieldset').addClass('form-group has-success');
    if ($(this).hasClass('new_group')) {
      setTimeout (window.location.href = xhr.getResponseHeader('Location'), 500);
    } else {
      setTimeout (window.location.href = "./", 500);
    }
  });
  $("form[class*='group'], form[action*='reset_tokens']").on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\" id=\"group_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (let form in errors) {
        var fieldSet = $(this).find("#group_" + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (let key of errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append("<div><small class=\"text-danger\">" + error + "</small></div>");
        }
      }
    } else {
      if (data.readyState == 0) {
        $("#group_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
      }
    }
  });
});
