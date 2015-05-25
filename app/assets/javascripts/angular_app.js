var app = angular.module('atentamente', ['ui.router', 'templates', 'angularFileUpload', 'ngQuill', 'ngSanitize', 'angularMoment', 'ui.bootstrap', 'ngStorage'])

app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
	function($stateProvider, $urlRouterProvider, $locationProvider){
		$locationProvider.html5Mode(true);
		$stateProvider
			.state('politicians', {
				abstract: true,
				url: '/politicians',
				template: '<ui-view/>',
				controller: 'PoliticiansController'
			})
			.state('politicians.index', {
				url: '',
				templateUrl: 'politicians/_index.html',
				resolve: {
					init: ['politiciansFactory', function(politiciansFactory){
						return politiciansFactory.index();
					}]
				}
			})
			.state('politicians.new', {
				url: '/new',
				templateUrl: 'politicians/_new.html',
				resolve: {
					init: ['politiciansFactory', function(politiciansFactory){
						return politiciansFactory.reset();
					}]
				}
			})
			.state('politicians.edit', {
				url: '/:id/edit',
				templateUrl: 'politicians/_edit.html',
				resolve: {
					init: ['$stateParams', 'politiciansFactory', function($stateParams, politiciansFactory){
						return politiciansFactory.find($stateParams.id);
					}]
				}
			})
			.state('politicians.new_email', {
				url: '/:politician_id/new_email',
				templateUrl: 'emails/_new.html',
				controller: 'EmailsController',
				resolve: {
					init: ['$stateParams', 'emailsFactory', function($stateParams, emailsFactory){
						return emailsFactory.newEmail($stateParams.politician_id);
					}]
				}
			})
			.state('emails', {
				abstract: true,
				url: '/emails',
				template: '<ui-view/>',
				controller: 'EmailsController'
			})
			.state('emails.index', {
				url: '',
				templateUrl: 'emails/_index.html',
				resolve: {
					init: ['emailsFactory', function(emailsFactory){
						return emailsFactory.index();
					}]
				}
			})
			.state('emails.show', {
				url: '/:id',
				templateUrl: 'emails/_show.html',
				resolve: {
					init: ['$stateParams', 'emailsFactory', function($stateParams, emailsFactory){
						return emailsFactory.find($stateParams.id);
					}]
				}
			});
		$urlRouterProvider.otherwise('politicians');	
	}
]);

// Change angularMoment locale to spanish
app.run(function(amMoment) {
	amMoment.changeLocale('es');
});