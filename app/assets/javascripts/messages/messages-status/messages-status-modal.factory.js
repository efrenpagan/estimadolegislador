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

    function open(message_service) {
      return $uibModal.open({
        animation: true,
        template: '<message-status/>',
        controller: function($scope, $uibModalInstance) {
          $scope.message_service = message_service
          $scope.close = function() {
            $uibModalInstance.close()
          }
        }
      })
    }
	}
})()
