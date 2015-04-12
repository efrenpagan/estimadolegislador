app.factory('emailsFactory', ['$http', '$q', 'LegislatorsService', function($http, $q, LegislatorsService){
	var o = {
		email: {},
		legislator: {}
	};

	o.newEmail = function(legislator_id){
		var deferred = $q.defer();
		LegislatorsService.find(legislator_id).
		then(function(data){
			angular.copy(data, o.legislator);
	    deferred.resolve(data);
		}).
		catch(function(data){
			deferred.reject();
		});
		return deferred.promise;
	};

	o.sendEmail = function(email){
		var deferred = $q.defer();
		$http.post('/emails.json', { email: email }).
	  success(function(data, status, headers, config) {
	  	console.log(data);
	    deferred.resolve(data);
	  }).
	  error(function(data, status, headers, config) {
	  	console.log(data);
	    deferred.reject();
	  });
		return deferred.promise;
	};

	return o;
}]);