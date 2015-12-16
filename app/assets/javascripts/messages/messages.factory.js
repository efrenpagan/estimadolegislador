(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .factory('messages', messages)

	function messages($http, $q, $timeout, messageStatus) {
    var service = {
			message: {
        status: 'pending'
      },
      messages: [],
      fetch: fetch,
      find: find,
			sendMessage: sendMessage
    }

    return service

    function sendMessage() {
      service.message.status = 'pending'
      var modal = messageStatus.open(service.message)
      var success = function(resp) {
        return monitorStatus(resp.data.task_key).then(function (message) {
          angular.copy(message, service.message)
          return message
        })
      }
      var error = function(err) {
        setError(err.data.errors)
        $timeout(modal.close, 3000)
        console.error(err)
      }
      return $http.post('/api/messages.json', { message: service.message }).then(success, error)
    }

    function monitorStatus(task_key) {
      var deferred = $q.defer()
      var pollStatus = function() {
        var success = function (resp) {
          switch(resp.data.status) {
            case 'success':
              deferred.resolve(resp.data.result)
              break
            case 'error':
              deferred.reject(resp)
              break
          }
        }
        var error = function (resp) {
          deferred.reject(resp)
        }
        $http.get('/api/workers/'+task_key+'.json').then(success, error)
      }
      $timeout(pollStatus, 3000)
      return deferred.promise
    }

    function fetch() {
      var success = function (resp) {
        angular.copy(resp.data, service.messages)
        return resp.data
      }
      var error = function(err) { console.log(err) }
      return $http.get('/api/messages.json').then(success, error)
    }

    function find(id) {
      var success = function(resp) {
        console.log(resp.data)
        angular.copy(resp.data, service.message)
        return resp.data
      }
      var error = function(err) { console.log(err) }
      return $http.get('/api/messages/'+id+'.json').then(success, error)
    }

    function setError(errors) {
      angular.forEach(errors, function(value, key) {
        errors[key] = value.toString()
      })
      service.message.status = 'error'
      service.message.errors = errors
    }
	}
})()
