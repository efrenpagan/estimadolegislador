(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .controller('ContactsController', ContactsController)

  function ContactsController($state, contacts) {
    var vm = this
    vm.contacts = contacts.contacts

		vm.addRecipient = function(contact) {
			contacts.addRecipient(contact)
		}

    vm.removeRecipient = function(contact) {
			contacts.removeRecipient(contact)
		}
	}
})();
