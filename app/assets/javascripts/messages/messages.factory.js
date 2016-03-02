(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .factory('messages', messages)

	function messages($http, $q, $timeout, $location, $state, messageStatus) {
    var service = {
			message: {
        status: 'pending'
      },
      messages: [],
      fetch: fetch,
      find: find,
			sendMessage: sendMessage,
      shareFacebook: shareFacebook,
      shareTwitter: shareTwitter
    }

    return service

    function sendMessage() {
      service.message.status = 'pending'
      var modal = messageStatus.open(service)
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
      return $http.post('/api/messages.json', { message: service.message }).then(success, error).then(function(message) {
        $state.go('messages.show', { id: message.id })
      })
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

    function shareFacebook() {
      FB.ui({
        method: 'share',
        href: messageUrl()
      }, function(response){})
    }

    function shareTwitter() {
      var share = {
        url: "https://twitter.com/intent/tweet",
        params: [
          { text: encodeURIComponent("Envié este mensaje a través de atentamente: ") + service.message.short_url },
          { original_referer: messageUrl() },
          { via: "atentamente_org" }
        ]
      }
      window.open(share['url'] + urlParams(share['params']), "Compartir en Twitter", "width=350,height=250")
    }

    function messageUrl() {
      return $location.protocol()+'://'+$location.host()+'/messages/'+service.message.id
    }

    function urlParams(params) {
      var result = []
      params.forEach(function(param) {
        var key = Object.keys(param)[0]
        result.push(key + "=" + param[key])
      })
      return "?" + result.join('&')
    }
	}
})()
