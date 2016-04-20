(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .factory('contacts', contacts)

	function contacts($http, $sessionStorage) {
    var service = {
      contacts: [],
      fetch: fetch,
      addRecipient: addRecipient,
      removeRecipient: removeRecipient,
      search: search,
      recipient_ids: []
    }

    initialize()

    return service

    function fetch() {
      var success = function (resp) {
        angular.copy(resp.data, service.contacts)
        return resp.data
      }
      var error = function(err) { console.log(err) }
      return $http.get('/api/contacts.json').then(success, error)
    }

    function addRecipient(contact) {
      service.recipient_ids.indexOf(contact.id) < 0 ?
        service.recipient_ids.push(contact.id) : console.error(contact.name + ' ya está incluido como recipiente')
  	}

    function removeRecipient(contact) {
      var index = service.recipient_ids.indexOf(contact.id)
      index >= 0 ?
        service.recipient_ids.splice(index, 1) : console.error(contact.name + ' no está incluido como recipiente')
  	}

    function search(query) {
      var success = function(resp) { return resp.data }
      var error = function(err) { console.log(err) }
      return $http.get(
        '/api/contacts/search.json', {
          params: {
            query: query,
            filtered_ids: JSON.stringify(service.recipient_ids)
          }
        }).then(success, error)
    }

    function initialize() {
      $sessionStorage.recipient_ids = $sessionStorage.recipient_ids || []
      service.recipient_ids = $sessionStorage.recipient_ids
    }
	}
})()
