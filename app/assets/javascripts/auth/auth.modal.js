(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .factory('authModal', authModal)

	function authModal($uibModal, Auth) {
    var service = {
			openRegister: openRegister,
      openLogin: openLogin,
      close: close
    }
    var currentModal

    return service

    function openRegister() {
      close()
      currentModal = $uibModal.open({
        animation: true,
        templateUrl: 'auth/auth-register.html',
        controllerAs: 'vm',
        controller: 'AuthController'
      })
      return currentModal
    }

    function openLogin() {
      close()
      currentModal = $uibModal.open({
        animation: true,
        templateUrl: 'auth/auth-login.html',
        controllerAs: 'vm',
        controller: 'AuthController'
      })
      return currentModal
    }

    function close() {
      if (currentModal) {
        currentModal.close()
      }
    }
	}
})()
