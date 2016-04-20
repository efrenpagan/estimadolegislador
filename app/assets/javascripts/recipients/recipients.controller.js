(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .controller('RecipientsController', RecipientsController)

  function RecipientsController(contacts) {
    var vm = this
    vm.contacts = contacts.contacts

		vm.addRecipient = function(contact) {
			contacts.addRecipient(contact)
		}

    vm.removeRecipient = function(contact) {
			contacts.removeRecipient(contact)
		}

		vm.searchFilter = function(query) {
      return contacts.search(query)
		}

		vm.onSelect = function(contact){
      contacts.addRecipient(contact)
      vm.searchBox = ''
		}
	}
})()
