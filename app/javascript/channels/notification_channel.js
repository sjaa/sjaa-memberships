import consumer from "channels/consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to NotificationChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from NotificationChannel")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    alert(data.message)

    // Update notifications partial
    // Submit an async form to update the notifications via turbostreams
  }
});