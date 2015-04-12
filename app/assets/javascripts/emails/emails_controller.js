app.controller('EmailsController', ['$scope', '$state', 'emailsFactory',
	function($scope, $state, emailsFactory) {
		$scope.legislator = emailsFactory.legislator;
		$scope.email = {
			legislator_id: emailsFactory.legislator.id
		};

		$scope.sendEmail = function(email){
			emailsFactory.sendEmail(email)
		};

}]);