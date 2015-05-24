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

		$scope.onSelect = function(item, model, label){
			var selection = $filter('getByProperty')('id', item.id, $scope.politicians)
			if (selection) $scope.addRecipient(selection);
		};

		$scope.preview_image = function(file){
			if (!file.length) return;
			$scope.politician.image_preview = URL.createObjectURL(file[0]);
   	};
   	
   	$scope.searchFilter = function(q){
   		var filtered_ids = $filter('getIds')($scope.recipients)
   		return politiciansFactory.search(q, filtered_ids).then(function(data){
   			console.log(data);
	      return data;
	    });
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

app.filter('getIds', function(){
	return function(collection){
		var result = [];
		collection.forEach(function(item){
			result.push(item.id)
		});
		return result;
	};
});