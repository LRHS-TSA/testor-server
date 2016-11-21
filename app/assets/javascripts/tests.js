// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $("form[id*='test']").on('ajax:send', function() {
    $(this).children('fieldset').attr('class', 'form-group');
    $(this).children('fieldset').children('div').remove();
    $("#test_alert").remove();
    $('input').attr('disabled', true);
  });
  $("form[id*='test']").on('ajax:success', function(event, data, status, xhr) {
    $(this).children('fieldset').addClass('form-group has-success');
    if ($(this).hasClass('new_test')) {
      setTimeout (window.location.href = xhr.getResponseHeader('Location'), 500);
    } else {
      setTimeout (window.location.href = "./", 500);
    }
  });
  $("form[id*='test']").on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade in\" role=\"alert\" id=\"test_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (let form in errors) {
        var fieldSet = $(this).find("#test_" + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (let key of errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append("<div><small class=\"text-danger\">" + error + "</small></div>");
        }
      }
    } else {
      if (data.readyState == 0) {
        $("#test_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
      }
    }
  });
});
