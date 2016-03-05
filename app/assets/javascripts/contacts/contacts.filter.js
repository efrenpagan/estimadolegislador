// Filter contacts that have been included in a new message
(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .filter('contactFilter', contactFilter)

	function contactFilter(contacts) {
    return function (contactsList) {
      var result = []
      angular.forEach(contactsList, function(contact) {
        if (contacts.recipient_ids.indexOf(contact.id) < 0) result.push(contact)
      })
      return result
    }
	}
})()
