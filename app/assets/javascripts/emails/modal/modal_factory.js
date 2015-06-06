app.factory('modalFactory', ['$modal', '$modalStack', function($modal, $modalStack) {
  return {
    open: function(scope) {
      $modal.open({
        animation: true,
	      template: '<email-status/>',
				scope: scope,
        controller: function($scope, $modalInstance) {
          $scope.close = function() {
            $modalInstance.close();
          };
        }
      });
    },
    close: function(reason) {
      $modalStack.dismissAll(reason);
    }
  };
}]);
