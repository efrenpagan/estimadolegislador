(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .directive('recipientNames', recipientNames)

	function recipientNames() {
    var directive = {
      scope: {
        collection: '='
      },
      template: '{{ vm.names }}',
      controllerAs: 'vm',
      controller: function() {
        this.names = extractValues(this.collection)

        function extractValues(collection) {
          var names = collection.map(function(item) {
            return item.name
          })
          return names.join(', ')
        }
      },
      bindToController: true
    }
    return directive
	}
})()
