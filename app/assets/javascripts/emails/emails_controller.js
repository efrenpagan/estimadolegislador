app.controller('EmailsController', ['$scope', '$state', '$timeout', '$modal', 'emailsFactory',
	function($scope, $state, $timeout, $modal, emailsFactory) {
		$scope.emails = emailsFactory.emails;
		$scope.email = emailsFactory.email;

		$scope.sendEmail = function(email){
			$scope.status = 'pending';
			open();
			emailsFactory.sendEmail(email).
			then(function(data){
				getStatus(data.task_key);
			}).
			catch(function(data){
				$scope.status = 'error';
				console.error(data);
			});
		};

		open = function(){
	    var modalInstance = $modal.open({
	      animation: true,
	      template: '<email-status/>',
				scope: $scope,
				controller: function ($scope) {
          $scope.ok = function(){
            console.log('ok');
          };
        }
	    });
	  };

		getStatus = function(task_key){
			emailsFactory.getStatus(task_key).
			then(function(data){
				if(data.status == 'pending'){
					$timeout(function(){ getStatus(task_key) } , 3000);
				}
				else {
					if(data.status == 'success'){
						$scope.email = data.result;
						console.log('Success');
					}
					else if(data.status == 'error'){
						console.log('Error');
					}
					else {
						console.log('Troleo full');
					}
					$scope.status = data.status;
				}
			});
		};

}]);
