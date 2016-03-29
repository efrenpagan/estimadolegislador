(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .controller('AuthController', AuthController)

  function AuthController($state, authModal, Auth) {
    var vm = this
    vm.login = function() {
      var success = function(resp) {
        authModal.close()
        $state.go('messages.index')
      }
      var error = function(err) {
        if (typeof vm.user == "undefined") {
          vm.user = {}
        }
        vm.user.error = "Email o Contraseña inválidos"
      }
      Auth.login(vm.user).then(success, error)
    }

    vm.register = function() {
      var success = function(resp) {
        authModal.close()
        $state.go('messages.index')
      }
      var error = function(err) {
        if (typeof vm.user == "undefined") {
          vm.user = {}
        }
        vm.user.errors = err.data.errors
      }

      Auth.register(vm.user).then(success, error)
    }

    vm.openRegister = function() {
      authModal.openRegister()
    }
	}
})();
