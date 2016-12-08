// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

String.prototype.capitalizeFirstLetter = function () {
  return this.charAt(0).toUpperCase() + this.slice(1);
}

function addMultipleChoiceOption(parentHTML, optionJSON, token, loadingPage = false) {
  //Set Up
  var item = $('#option-item-base').clone();
  var itemID = 'option-' + optionJSON.id;
  item.appendTo(parentHTML);
  item.attr('id', itemID);

  //Delete Button Routing
  item.children('form').attr('action', '/tests/' + $('#questionBody').attr('test-id') + '/questions/' + optionJSON.question_id + '/multiple_choice_options/' + optionJSON.id);
  item.children('form').children('input[name="authenticity_token"]').attr('value', token);

  //Edit Button
  item.children('button').on('click', function() {
    //Set Up
    var option = $(this).parent();
    var currentText = option.children('p').text();
    option.children('p').empty();
    option.children('form').attr('hidden', true);
    option.children('button').attr('hidden', true);
    var optionEditForm = $('#editOptionLineBase').clone();
    optionEditForm.removeAttr('id');
    optionEditForm.appendTo(option);
    optionEditForm.attr('action', '/tests/' + $('#questionBody').attr('test-id') + '/questions/' + optionJSON.question_id + '/multiple_choice_options/' + optionJSON.id);

    //Redefine Form Text
    optionEditForm.children('fieldset').children('input[name="multiple_choice_option[text]"]').val(currentText);
    optionEditForm.children('fieldset').children('input[name="multiple_choice_option[correct]"]').prop('checked', optionJSON.correct);

    optionEditForm.removeAttr('hidden');

    //Save Button
    optionEditForm.children('input').removeAttr('hidden');
    optionEditForm.children('input').hide();
    optionEditForm.children('input').show('slide', { direction: 'right' }, 300);
  });

  //Text
  item.children('p').append(optionJSON.text);
  if (optionJSON.correct) {
    $('#option-' + optionJSON.id).addClass('text-success');
  }
  item.removeAttr('hidden');
  if (!loadingPage) {
    item.hide();
    item.slideDown();
  }
}

function addMatchingPair(tableBody, json, token, loadingPage = false) {
  var pair = $('#baseMatchingPairRow').clone();
  var pairID = 'pair-' + json.id;
  pair.appendTo(tableBody);
  pair.attr('id', pairID);

  //Text
  var item1 = pair.children('td[name="item1"]');
  var item2 = pair.children('td[name="item2"]');
  item1.html(json.item1);
  item2.html(json.item2);

  //Delete Button
  pair.children('td').children('form[method="post"]').attr('action', '/tests/' + $('#questionBody').attr('test-id') + '/questions/' + json.question_id + '/matching_pairs/' + json.id);

  //Edit Button
  pair.children('td').children('button').on('click', function() {
    var currentItem1 = item1.html();
    var currentItem2 = item2.html();

    item1.hide();
    item2.hide();

    pair.children('td[name="edit_and_delete"]').hide();

    var formCell = pair.children('td[name="edit-pair"]');
    var form = formCell.children('form');
    form.attr('action', '/tests/' + $('#questionBody').attr('test-id') + '/questions/' + json.question_id + '/matching_pairs/' + json.id);
    form.children('fieldset').children('input[name="matching_pair[item1]"]').val(currentItem1);
    form.children('fieldset').children('input[name="matching_pair[item2]"]').val(currentItem2);
    formCell.removeAttr('hidden');
    pair.addClass('table-active');
  });

  pair.removeAttr('hidden');
  if (!loadingPage) {
    pair.hide();
    pair.fadeIn();
  }
}

function makeCard(data, token, loadingPage = false) {
  //Card
  var card = $('#base-card').clone();
  var cardID = 'question-' + data.id;
  card.appendTo('#questionBody');
  card.attr('id', cardID);

  //Delete Button
  var deleteButton = card.children('.card-header').children('form[name="delete-button"]');
  deleteButton.attr('action', '/tests/' + data.test_id + '/questions/' + data.id);
  deleteButton.children('input[name="authenticity_token"]').attr('value', token);

  //Card Text
  card.children('.card-block').children('blockquote[name="question-text"]').html(data.text);

  switch(data.question_type) {
    case 'multiple_choice':
      var list = $('#baseMultipleChoiceList').clone();
      list.attr('id', 'option-list-' + data.id);
      list.appendTo(card.children('.card-block').children('.card-text'));
      list.removeAttr('hidden');

      for(var i in data.multiple_choice_options) {
        addMultipleChoiceOption(list.children('ul'), data.multiple_choice_options[i], token, true);
      }

      //Form
      var form = $('#baseMultipleChoice').clone();
      form.appendTo(card.children('.card-block'));
      form.attr('id', 'create-multiple-choice-' + data.id);
      form.removeAttr('hidden');

      //Form Route
      form.children('form').attr('action', '/tests/' + data.test_id + '/questions/' + data.id + '/multiple_choice_options');
      break;
    case 'matching':
      var table = $('#baseMatchingList').clone();
      table.attr('id', 'pair-table-' + data.id);
      table.appendTo(card.children('.card-block').children('.card-text'));
      table.removeAttr('hidden');

      for(var i in data.matching_pairs) {
        addMatchingPair(table.children('table').children('tbody'), data.matching_pairs[i], token, true);
      }

      //Form Route
      table.children('form').attr('action', table.children('form').attr('action') + '/' + data.id + '/matching_pairs');
      break;
    default:
      break;
  }
  card.removeAttr('hidden');
  if (!loadingPage) {
    card.hide();
    card.slideDown();
  }
}

function setUpEditModal(questionID) {
  $('#editQuestionText').val($('#' + questionID).children('.card-block').children('blockquote').text());
  $('#editQuestion').attr('action', '/tests/' + $('#questionBody').attr('test-id') + '/questions/' + questionID.substr(questionID.lastIndexOf('-') + 1))
}

$(document).on('turbolinks:load', function() {
  if ($('#questionBody').length != 0) {
    var token = $('#questionBody').attr('data-token');
    var existingCards = JSON.parse($('#questionBody').attr('data-questions'));
    for(var i in existingCards) {
     makeCard(existingCards[i], token, true);
    }
    $('.container').on('click', 'button[data-target="#editQuestionModal"]', function() {
      setUpEditModal($(this).parent().parent().attr('id'));
    });
  }
  $('.container').on('ajax:send', 'form[action*="questions"]', function() {
    $(this).children('div').children('fieldset').attr('class', 'form-group');
    $(this).children('div').children('fieldset').children('div').remove();
    $('#questionAlert').remove();
    $('input').attr('disabled', true);
  });
  $('.container').on('ajax:success', 'form[action*="questions"]', function(event, data, status, xhr) {
    // Delete Buttons
    if ($(this).hasClass('button_to')) {
      if ($(this).hasClass('form-inline')) {
        $(this).parent().slideUp();
      } else {
        $(this).parent().parent().slideUp();
      }
    }
    // Edit Buttons
    if ($(this).hasClass('edit_option')) {
      var newText = event.currentTarget[3].value;
      var newChecked = $(this).children('fieldset').children('.form-check-inline').is(':checked');
      $(this).parent().children('p').text(newText);
      if (newChecked) {
        $(this).parent().attr('class', 'my-1 text-success');
      } else {
        $(this).parent().attr('class', 'my-1');
      }

      $(this).parent().children('form[name="delete-option"]').removeAttr('hidden');
      $(this).parent().children('button').removeAttr('hidden');
      $(this).remove();

    }
    // Adding Multiple Choice Options
    if ($(this).hasClass('add_option')) {
      var json = {
        "id" : xhr.getResponseHeader('Location').substr(xhr.getResponseHeader('Location').lastIndexOf('/') + 1),
        "question_id" : xhr.getResponseHeader('Location').split('/')[4],
        "text" : event.currentTarget[2].value,
        "correct" : $(this).children('fieldset').children('#multiple_choice_option_correct').is(':checked')
      };
      addMultipleChoiceOption($("#option-list-" + xhr.getResponseHeader('Location').split('/')[4]).children('ul'), json, token);
      $(this).children('fieldset').children('input[name="multiple_choice_option[text]"]').val('');
    }
    // Adding Matching Pair
    if ($(this).hasClass('add_pair')) {
      var json = {
        "id" : xhr.getResponseHeader('Location').substr(xhr.getResponseHeader('Location').lastIndexOf('/') + 1),
        "question_id" : xhr.getResponseHeader('Location').split('/')[4],
        "item1" : event.currentTarget[2].value,
        "item2" : event.currentTarget[4].value
      };
      addMatchingPair($("#pair-table-" + xhr.getResponseHeader('Location').split('/')[4]).children('table').children('tbody'), json, token, false);
      $(this).children('fieldset').children('input[name="matching_pair[item1]"]').val('');
      $(this).children('fieldset').children('input[name="matching_pair[item2]"]').val('');
    }
    // Edit Matching Pair
    if($(this).hasClass('edit_pair')) {
      var newItem1 = event.currentTarget[3].value;
      var newItem2 = event.currentTarget[5].value;
      $(this).parent().parent().children('td[name="item1"]').html(newItem1);
      $(this).parent().parent().children('td[name="item2"]').html(newItem2);

      $(this).parent().attr('hidden', true);
      $(this).parent().parent().removeClass('table-active');
      $(this).parent().parent().children('td[name="item1"]').show();
      $(this).parent().parent().children('td[name="item2"]').show();
      $(this).parent().parent().children('td[name="edit_and_delete"]').show();
    }
    // Edit Question from Modal
    if ($(this).hasClass('edit-question')) {
      var newQuestionText = event.currentTarget[3].value;
      var questionID = event.target.action.substr(event.target.action.lastIndexOf('/') + 1);
      $('#question-' + questionID).children('.card-block').children('blockquote').text(newQuestionText);
    }
    // New Question from Modal
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
    $("#editQuestionModal").modal('hide');
    $("#question_text").val("");
  });
  $('.container').on('ajax:error', 'form[action*="questions"]', function(event, data, status, xhr) {
    $('input').attr('disabled', false);
    $('h2').before('<div class="alert alert-danger alert-dismissible fade in" role="alert" id="questionAlert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>An error has occured while trying to submit your information.</div>');
    if (data.responseJSON !== undefined) {
      var errors = data.responseJSON.error;
      for (let form in errors) {
        var fieldSet = $(this).find('#question_' + form).parent();
        fieldSet.addClass('form-group has-danger');
        for (let key of errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + key;
          fieldSet.append('<div><small class="text-danger">' + error + '</small></div>');
        }
      }
    } else {
      if (data.readyState == 0) {
        $('#question_alert').append('<br><small>A network error occured, please check your internet connection.</small>');
      }
    }
  });
});
