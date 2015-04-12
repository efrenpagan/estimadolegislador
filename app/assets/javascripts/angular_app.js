var app = angular.module('estimadoLegislador', ['ui.router', 'templates', 'angularFileUpload', 'ngQuill'])

app.config([
	'$stateProvider',
	'$urlRouterProvider',
	function($stateProvider, $urlRouterProvider){
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
				url: '/:id/new_email',
				templateUrl: 'emails/_new_email.html',
				controller: 'EmailsController',
				resolve: {
					init: ['$stateParams', 'emailsFactory', function($stateParams, emailsFactory){
						return emailsFactory.newEmail($stateParams.id);
					}]
				}
			});
		$urlRouterProvider.otherwise('legislators');	
	}
]);