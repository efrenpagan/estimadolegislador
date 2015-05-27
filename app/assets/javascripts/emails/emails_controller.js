app.controller('EmailsController', ['$scope', '$state', 'emailsFactory',
	function($scope, $state, emailsFactory) {
		$scope.emails = emailsFactory.emails;
		$scope.email = emailsFactory.email;
		$scope.recipients = emailsFactory.email.recipients;

		$scope.sendEmail = function(email){
			emailsFactory.sendEmail(email)
		};

}]);