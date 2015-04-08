var app = angular.module('estimadoLegislador', ['ui.router', 'templates', 'angularFileUpload'])

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
			.state('legislators.edit', {
				url: '/:id/edit',
				templateUrl: 'legislators/_edit.html',
				resolve: {
					init: ['$stateParams', 'legislatorsFactory', function($stateParams, legislatorsFactory){
						return legislatorsFactory.find($stateParams.id);
					}]
				}
			});
		$urlRouterProvider.otherwise('legislators');	
	}
]);