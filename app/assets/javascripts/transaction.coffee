# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

balance = ->
  dom = $('#from_score option:selected')

  if dom.length == 0
    return

  score = dom.text()
  score
  $.ajax({
    type: "GET",
    url: "/wallet/" + score + "/balance",
    success: (data, textStatus, jqXHR) ->
      console.log data['balance']
      $('#label_balance').text(data['currency_sym'] + ' ' + data['balance'] + ' Balance')
    error: (jqXHR, textStatus, errorThrown) ->
      console.log jqXHR
  })

$(document).on 'turbolinks:load', ->
  balance()
  $('#from_score').on 'change', ->
    balance()


$(document).ready ->
  balance()
  $('#from_score').on 'change', ->
    balance()

