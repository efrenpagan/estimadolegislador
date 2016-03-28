(function() {
  'use strict';

  angular
	  .module('atentamente')
	  .controller('TopNavController', TopNavController);

  function TopNavController($scope, Auth, authModal) {
    var vm = this
    vm.signedIn = Auth.isAuthenticated
    vm.logout = Auth.logout

    vm.openRegister = function() {
      authModal.openRegister()
    }

    vm.openLogin = function() {
      authModal.openLogin()
    }

    Auth.currentUser().then(function (user){
      vm.user = user
    })

    $scope.$on('devise:login', function (e, user){
      vm.user = user
    })

    $scope.$on('devise:logout', function (e, user){
      vm.user = {}
    })
  }
})();
