app.service('PoliticiansService', ['$http', '$q', function ($http, $q) {
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

  this.find = function(politician_id){
  	var deferred = $q.defer();
		$http.get('/api/politicians/'+politician_id+'.json').
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  };

  this.find_recipients = function(ids){
  	var deferred = $q.defer();
		$http({
			url: '/api/politicians.json',
			method: 'GET',
  		params: {ids: JSON.stringify(ids)}
		}).
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  };

  this.search = function(query, filtered_ids){
  	var deferred = $q.defer();
  	$http({
  		url: '/api/politicians/search.json',
  		method: 'GET',
  		params: {query: query, filtered_ids: JSON.stringify(filtered_ids)}
  	}).
  	then(function(resp) {
    	deferred.resolve(resp.data);
    });
    return deferred.promise;
  };

}]);