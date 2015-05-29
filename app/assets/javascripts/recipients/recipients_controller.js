app.controller('RecipientsController', ['$scope', '$filter', 'recipientsFactory',
	function($scope, $filter, recipientsFactory) {
		$scope.recipients = recipientsFactory.recipients;

		$scope.add = function(recipient){
			recipientsFactory.add(recipient);
		};

		$scope.remove = function(recipient){
			recipientsFactory.remove(recipient);
		};

		$scope.onSelect = function(item, model, label){
			var selection = $filter('getByProperty')('id', item.id, recipientsFactory.non_recipients)
			if (selection) $scope.add(selection);
		};

}]);
