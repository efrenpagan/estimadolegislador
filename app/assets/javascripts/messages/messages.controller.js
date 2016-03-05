(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .controller('MessagesController', MessagesController)

  function MessagesController(messages, contacts) {
    var vm = this
    vm.message_service = messages
    vm.message = messages.message
    vm.messages = messages.messages
    vm.contacts = contacts.contacts

    vm.tinymceOptions = {
      menubar: false,
      height: 300,
      toolbar: 'undo redo | bold italic | bullist numlist outdent indent',
      statusbar: false
    }

    vm.sendMessage = function() {
      vm.message.contact_ids = contacts.recipient_ids
      messages.sendMessage()
		}
	}
})()
