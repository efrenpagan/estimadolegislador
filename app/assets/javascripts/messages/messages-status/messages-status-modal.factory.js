(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .factory('messageStatus', messageStatus)

	function messageStatus($uibModal) {
    var service = {
			open: open
    }

    return service

    function open(message) {
      return $uibModal.open({
        animation: true,
        template: '<message-status/>',
        controller: function($scope, $uibModalInstance) {
          $scope.message = message
          $scope.close = function() {
            $uibModalInstance.close()
          }
        }
      })
    }
	}
})()
