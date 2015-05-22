app.factory('emailsFactory', ['$http', '$q', 'PoliticiansService', function($http, $q, PoliticiansService){
	var o = {
		email: {
			politician: {}
		},
		emails: []
	};

	o.index = function(){
		var deferred = $q.defer();
		$http.get('/api/emails.json').
		success(function(data){
			angular.copy(data, o.emails);
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.newEmail = function(politician_id){
		var deferred = $q.defer();
		PoliticiansService.find(politician_id).
		then(function(data){
			angular.copy(data, o.email.politician);
			o.email.politician_id = data.id;
	    deferred.resolve(data);
		}).
		catch(function(data){
			deferred.reject();
		});
		return deferred.promise;
	};

	o.sendEmail = function(email){
		var deferred = $q.defer();
		$http.post('/api/emails.json', { email: email }).
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
		$http.get('/api/emails/'+id+'.json').
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