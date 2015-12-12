(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .filter('recipientsFilter', recipientsFilter)

  function recipientsFilter(contacts) {
    return function (contactsList) {
      var result = []
      angular.forEach(contactsList, function(contact) {
        if (contacts.recipient_ids.indexOf(contact.id) >= 0) result.push(contact)
      })
      return result
    }
	}
})()
