// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

function makeCard(data, token) {
  //Card
  var card = $("#base-card").clone();
  var cardID = 'question-' + data.id;
  card.appendTo("#questionBody");
  card.attr('id', cardID);
  card.removeAttr('hidden');

  //Delete Button
  card.children('.card-header').children("form[name='delete-button']").attr('action', '/tests/' + data.test_id + '/questions/' + data.id);
  card.children('.card-header').children("form[name='delete-button']").children("input[name='authenticity_token']").attr('value', token);

  //Card Text
  card.children('.card-header').append(data.question_type.capitalizeFirstLetter().replace("_", " "));
  card.children('.card-block').children('blockquote[name="question-text"]').html(data.text);

  //Multiple Choice
  if (data.question_type == 'multiple_choice') {
    //Form
    var form = $("#base-multiple-choice").clone();
    form.appendTo(card.children('.card-block'));
    form.attr('id', 'create-multiple-choice-' + data.id);
    form.removeAttr('hidden');

    //Form Route
    form.children('form').attr('action', '/tests/' + data.test_id + '/questions/' + data.id + '/multiple_choice_options');
  }
}

$(document).on('turbolinks:load', function() {
  var token = $('#questionBody').attr('data-token');
  var existingCards = JSON.parse($("#questionBody").attr('data-questions'));
  for(var i in existingCards) {
   makeCard(existingCards[i], token);
  }
  $("form[action*='questions']").on('ajax:send', function() {
    $(this).children('div').children('fieldset').attr('class', 'form-group');
    $(this).children('div').children('fieldset').children('div').remove();
    $("#question_alert").remove();
    $('input').attr('disabled', true);
  });
  $("form[action*='questions']").on('ajax:success', function(event, data, status, xhr) {
    if ($(this).hasClass("button_to")) {
      $(this).parent().parent().fadeOut();
    }
    if ($(this).attr('id') == 'new_question') {
      var json = {
        "id" : xhr.getResponseHeader('Location').substr(xhr.getResponseHeader('Location').lastIndexOf('/') + 1),
        "test_id" : $("#questionBody").attr('test-id'),
        "question_type" : event.currentTarget[4].value,
        "text" : event.currentTarget[2].value,
      };
      makeCard(json, token);
    }
    $('input').attr('disabled', false);
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
