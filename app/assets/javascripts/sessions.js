// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

$(document).on('turbolinks:load', function() {
  $('form[id*="approve_"').on('ajax:send', function() {
    $(this).children('fieldset').attr('class', 'form-group');
    $(this).children('fieldset').children('div').remove();
    $("#assignment_alert").remove();
    $('input').attr('disabled', true);
  });
  $('form[id*="approve_"').on('ajax:success', function(event, data, status, xhr) {
    $(this).parent().parent().children('td[name="status"]').text('Approved');
    $(this).remove();

  });
  $('form[id*="approve_"').on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" id=\"session_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (var form in errors) {
        var fieldSet = $(this).find("#assignment_" + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (var key in errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append("<div><small class=\"text-danger\">" + error + "</small></div>");
        }
      }
    } else {
      if (data.readyState == 0) {
        $("#session_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
      }
    }
  });

  $("form[id*='edit_score']").on('ajax:send', function() {
    $(this).children('fieldset').attr('class', 'form-group');
    $(this).children('fieldset').children('div').remove();
    $("#test_alert").remove();
    $('input').attr('disabled', true);
  });
  $("form[id*='edit_score']").on('ajax:success', function(event, data, status, xhr) {
    $(this).children('fieldset').addClass('form-group has-success');
    setTimeout (window.location.href = window.location.href, 200);
  });
  $("form[id*='edit_score']").on('ajax:error', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before("<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\" id=\"session_alert\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>An error has occured while trying to submit your information.</div>");
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (var form in errors) {
        var fieldSet = $(this).find("#form_" + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (var key in errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append("<div><small class=\"text-danger\">" + error + "</small></div>");
        }
      }
    } else {
      if (data.readyState == 0) {
        $("#session_alert").append("<br><small>A network error occured, please check your internet connection.</small>");
      }
    }
  });
});
