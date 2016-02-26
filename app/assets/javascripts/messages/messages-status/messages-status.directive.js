(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .directive('messageStatus', messageStatus)

	function messageStatus($compile) {
    var directive = {
      restrict: 'E',
      scope: false,
      replace: true,
      link: linker
    }

    return directive

    function linker(scope, element, attrs) {
      scope.getTemplateUrl = function() {
        switch(scope.message_service.message.status) {
          case 'success':
            return 'messages/messages-status/messages-status-success.html'
          case 'error':
            return 'messages/messages-status/messages-status-error.html'
          default:
            return 'messages/messages-status/messages-status-pending.html'
         }
      }
      scope.$watch('message_service.message.status', function (){
        element.html('<div><ng-include src="getTemplateUrl()"/></div>')
        $compile(element.contents())(scope)
      })
    }
	}
})()
