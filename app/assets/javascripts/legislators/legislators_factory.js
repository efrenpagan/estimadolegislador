app.factory('legislatorsFactory', ['$http', '$q', '$upload', 'LegislatorsService', function($http, $q, $upload, LegislatorsService){
	var o = {
		legislators: [],
		legislator: {}
	};

	o.index = function(){
		var deferred = $q.defer();
		$http.get('/legislators.json').
		success(function(data){
			angular.copy(data, o.legislators);
	    deferred.resolve();
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.find = function(id){
		var deferred = $q.defer();
		$http.get('/legislators/'+id+'.json').
		success(function(data){
			angular.copy(data, o.legislator);
	    deferred.resolve();
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.update = function(params){
		var deferred = $q.defer();
		$upload.upload({
      url: '/legislators/'+params.id+'.json',
      method: 'PUT',
      fields: LegislatorsService.params('legislator', params),
      file: params.image,
      fileFormDataName: 'legislator[image]'
    }).
    success(function (data, status, headers, config) {
    	angular.copy(data, o.legislator);
      deferred.resolve(data);
    })
    .error(function (data, status, headers, config) {
			deferred.reject(status);
		})
    return deferred.promise;
	};

	return o;
}]);