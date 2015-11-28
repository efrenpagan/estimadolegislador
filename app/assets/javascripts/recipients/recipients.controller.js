app.controller('RecipientsController', ['$scope', '$filter', '$state', 'recipientsFactory',
	function($scope, $filter, $state, recipientsFactory) {
		$scope.$state = $state;
		$scope.recipients = recipientsFactory.recipients;
		$scope.non_recipients = recipientsFactory.non_recipients;

		$scope.add = function(recipient){
			recipientsFactory.add(recipient);
		};

		$scope.remove = function(recipient){
			recipientsFactory.remove(recipient);
		};

		$scope.searchFilter = function(q){
			return recipientsFactory.search(q).then(function(data){
				console.log(data);
				return data;
			});
		};

		$scope.onSelect = function(item, model, label){
			var selection = $filter('getByProperty')('id', item.id, $scope.non_recipients)
			if (selection) $scope.add(selection);
		};

}]);

app.filter('getByProperty', function(){
	return function(property, value, collection){
		var result;
		collection.some(function(item){
			if (item[property] == value){
				result = item;
				return true;
			};
		});
		return result;
	};
});
