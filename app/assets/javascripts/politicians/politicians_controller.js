app.controller('PoliticiansController', ['$scope', '$state', '$filter', 'politiciansFactory',
	function($scope, $state, $filter, politiciansFactory) {
		$scope.politicians = politiciansFactory.politicians;
		$scope.politician = politiciansFactory.politician;
		$scope.recipients = politiciansFactory.recipients;

		$scope.updatePolitician = function(params){
			politiciansFactory.update(params).
			then(function(data){
				console.log(data);
			}).
			catch(function(data){
				console.error(data);
			});
		};

		$scope.createPolitician = function(params){
			politiciansFactory.create(params).
			then(function(data){
				console.log(data);
			}).
			catch(function(data){
				console.error(data);
			});
		};

		$scope.addRecipient = function(politician){
			politiciansFactory.addRecipient(politician);
		};

		$scope.removeRecipient = function(politician){
			politiciansFactory.removeRecipient(politician);
		};

		$scope.preview_image = function(file){
			if (!file.length) return;
			$scope.politician.image_preview = URL.createObjectURL(file[0]);
   	};

}]);

app.filter('getIds', function(){
	return function(collection){
		var result = [];
		collection.forEach(function(item){
			result.push(item.id)
		});
		return result;
	};
});
