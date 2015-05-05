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
		$http.get('/api/legislators/'+legislator_id+'.json').
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  };

  this.search = function(query){
  	var deferred = $q.defer();
  	var url = '/api/legislators/search.json';
  	$http({url: url, method: "GET", params: {query: query}}).then(function(resp) {
    	deferred.resolve(resp.data);
    });
    return deferred.promise;
  };

}]);