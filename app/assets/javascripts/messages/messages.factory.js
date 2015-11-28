app.factory('emailsFactory', ['$http', '$q', '$sessionStorage', 'PoliticiansService', 'recipientsFactory', function($http, $q, $sessionStorage, PoliticiansService, recipientsFactory){

	$sessionStorage.recipients_ids = $sessionStorage.recipients_ids || [];

	var o = {
		email: {
			politician_ids: recipientsFactory.recipients_ids
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

	o.sendEmail = function(email){
		var deferred = $q.defer();
		$http.post('/api/emails.json', { email: email }).
	  success(function(data, status, headers, config) {
	    deferred.resolve(data);
	  }).
	  error(function(data, status, headers, config) {
	    deferred.reject(data);
	  });
		return deferred.promise;
	};

	o.find = function(id){
		var deferred = $q.defer();
		$http.get('/api/emails/'+id+'.json').
		success(function(data){
			angular.copy(data, o.email);
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.getStatus = function(id){
		var deferred = $q.defer();
		$http.get('/api/workers/'+id+'.json').
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	return o;
}]);
