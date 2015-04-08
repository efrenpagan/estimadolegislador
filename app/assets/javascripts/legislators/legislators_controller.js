app.controller('LegislatorsController', ['$scope', '$state', 'legislatorsFactory',
	function($scope, $state, legislatorsFactory) {
		$scope.legislators = legislatorsFactory.legislators;
		$scope.legislator = legislatorsFactory.legislator;
		$scope.image_preview = $scope.legislator.image;

		$scope.updateLegislator = function(params){
			legislatorsFactory.update(params).
			then(function(data){
				console.log(data);
			}).
			catch(function(data){
				console.error(data);
			});
		};

		$scope.preview_image = function(file) {
			if (!file.length) return;
			$scope.image_preview = URL.createObjectURL(file[0]);
   	};

}]);