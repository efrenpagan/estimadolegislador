app.service('LegislatorsService', ['$http', '$q', function ($http, $q) {
  this.params = function (obj, params) {
		var newParams = {};
		for (var key in params) {
		  if (params.hasOwnProperty(key) && params[key] !== null  && key != 'id' && key != 'image_preview') {
		  	var newKey = obj+'['+key+']';
		  	newParams[newKey] = params[key];
		  }
		}
		return newParams;		
  };

  this.find = function(legislator_id){
  	var deferred = $q.defer();
		$http.get('/legislators/'+legislator_id+'.json').
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  }
}]);