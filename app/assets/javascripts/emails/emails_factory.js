app.factory('emailsFactory', ['$http', '$q', 'LegislatorsService', function($http, $q, LegislatorsService){
	var o = {
		email: {
			legislator: {}
		},
		emails: []
	};

	o.index = function(){
		var deferred = $q.defer();
		$http.get('/emails.json').
		success(function(data){
			angular.copy(data, o.emails);
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.newEmail = function(legislator_id){
		var deferred = $q.defer();
		LegislatorsService.find(legislator_id).
		then(function(data){
			angular.copy(data, o.email.legislator);
			o.email.legislator_id = data.id;
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

	o.find = function(id){
		var deferred = $q.defer();
		$http.get('/emails/'+id+'.json').
		success(function(data){
			console.log(data)
			angular.copy(data, o.email);
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	return o;
}]);