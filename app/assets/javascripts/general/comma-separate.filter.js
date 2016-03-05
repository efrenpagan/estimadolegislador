// Join item names with comma separator ","
(function() {
  'use strict'

  angular
	  .module('atentamente')
	  .filter('commaSeparateFilter', commaSeparateFilter)

	function commaSeparateFilter() {
    return function (collection, field) {
      var result = []
      angular.forEach(collection, function(item) {
        result.push(item[field])
      })
      return result.join(', ')
    }
	}
})()
