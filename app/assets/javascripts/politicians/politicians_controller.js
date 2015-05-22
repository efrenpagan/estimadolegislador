app.controller('PoliticiansController', ['$scope', '$state', 'politiciansFactory',
	function($scope, $state, politiciansFactory) {
		$scope.politicians = politiciansFactory.politicians;
		$scope.politician = politiciansFactory.politician;

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

		$scope.preview_image = function(file){
			if (!file.length) return;
			$scope.politician.image_preview = URL.createObjectURL(file[0]);
   	};

   	
   	$scope.searchFilter = function(q){
   		return politiciansFactory.search(q).then(function(data){
   			console.log(data);
	      return data;
	    });
  	};

}]);