var app = angular.module('estimadoLegislador', ['ui.router', 'templates', 'angularFileUpload', 'ngQuill', 'ngSanitize', 'angularMoment', 'ui.bootstrap'])

app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
	function($stateProvider, $urlRouterProvider, $locationProvider){
		$locationProvider.html5Mode(true);
		$stateProvider
			.state('legislators', {
				abstract: true,
				url: '/legislators',
				template: '<ui-view/>',
				controller: 'LegislatorsController'
			})
			.state('legislators.index', {
				url: '',
				templateUrl: 'legislators/_index.html',
				resolve: {
					init: ['legislatorsFactory', function(legislatorsFactory){
						return legislatorsFactory.index();
					}]
				}
			})
			.state('legislators.new', {
				url: '/new',
				templateUrl: 'legislators/_new.html',
				resolve: {
					init: ['legislatorsFactory', function(legislatorsFactory){
						return legislatorsFactory.reset();
					}]
				}
			})
			.state('legislators.edit', {
				url: '/:id/edit',
				templateUrl: 'legislators/_edit.html',
				resolve: {
					init: ['$stateParams', 'legislatorsFactory', function($stateParams, legislatorsFactory){
						return legislatorsFactory.find($stateParams.id);
					}]
				}
			})
			.state('legislators.new_email', {
				url: '/:legislator_id/new_email',
				templateUrl: 'emails/_new.html',
				controller: 'EmailsController',
				resolve: {
					init: ['$stateParams', 'emailsFactory', function($stateParams, emailsFactory){
						return emailsFactory.newEmail($stateParams.legislator_id);
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
		$urlRouterProvider.otherwise('legislators');	
	}
]);

// Change angularMoment locale to spanish
app.run(function(amMoment) {
	amMoment.changeLocale('es');
});