app.controller('AuthController', ['$scope', '$state', 'Auth',
	function($scope, $state, Auth) {
    $scope.login = function() {
      Auth.login($scope.user).then(function(){
        $state.go('politicians.index');
      });
    };

    $scope.register = function() {
      Auth.register($scope.user).then(function(){
        $state.go('politicians.index');
      });
    };

}]);
