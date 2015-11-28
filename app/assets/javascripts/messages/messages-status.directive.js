app.directive('emailStatus', function($compile){
  var linker = function(scope, element, attrs) {
    scope.getTemplateUrl = function() {
      switch(scope.status) {
        case 'pending':
          return 'emails/status/_pending.html';
        case 'success':
          return 'emails/status/_success.html';
        default:
          return 'emails/status/_error.html';
       };
    };

    scope.$watch('status', function (){
      element.html('<div><ng-include src="getTemplateUrl()"/></div>');
      $compile(element.contents())(scope);
    });
  };

  return {
    restrict: 'E',
    scope: false,
    replace: true,
    link: linker
  };
});
