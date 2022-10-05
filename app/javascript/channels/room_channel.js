import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Test live')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // $('#message_holder').append('<div class="message">' + data.content + '</div>')
    $('#message_holder').append(data.mod_message)


    //
    // $('#message_holder').append('<div class="message card p-2 mb-2 bg-light text-dark text-end">' + data.content + '</div>')
    // 
    console.log(data.content)
  }
});


var submit_messages;

$(document).on('turbolinks:load', function () {
  submit_messages()
})

submit_messages = function () {
  $('#message_content').on('keydown', function (event) {
    if (event.keyCode === 13) {

      $('input').click()
      event.target.value = ''
      event.preventDefault()
      console.log('yes we hitted enter!')
    }
  })
}