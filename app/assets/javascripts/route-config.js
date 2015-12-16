(function() {
  'use strict'

	angular
    .module('atentamente')
    .config(config)

	function config($stateProvider, $urlRouterProvider, $locationProvider) {
		$locationProvider.html5Mode(true)
		$stateProvider
			.state('contacts', {
				abstract: true,
				url: '/contacts',
				template: '<ui-view/>',
				controller: 'ContactsController',
        controllerAs: 'vm'
			})
			.state('contacts.index', {
				url: '',
				templateUrl: 'contacts/contacts-index.html',
				resolve: {
          contactsPrep: contactsPrep
				}
			})
			.state('messages', {
				abstract: true,
				url: '/messages',
				template: '<ui-view/>',
				controller: 'MessagesController',
        controllerAs: 'vm'
			})
      .state('messages.index', {
      	url: '',
      	templateUrl: 'messages/messages-index.html',
        resolve: {
      		messagesPrep: messagesPrep
      	}
      })
      .state('messages.new', {
      	url: '/new',
      	templateUrl: 'messages/messages-new.html',
      	resolve: {
      		contactsPrep: contactsPrep
      	}
      })
      .state('messages.show', {
				url: '/:id',
				templateUrl: 'messages/messages-show.html',
				resolve: {
          findMessage: findMessage
				}
			})
		$urlRouterProvider.otherwise('contacts')
	}

  function contactsPrep(contacts) {
    return contacts.fetch()
  }

  function messagesPrep(messages) {
    return messages.fetch()
  }

  function findMessage($stateParams, messages) {
    return messages.find($stateParams.id)
  }
})()

// // Change angularMoment locale to spanish
// app.run(function(amMoment) {
// 	amMoment.changeLocale('es');
// });
