app.service('RecipientsService', ['$http', '$q', '$sessionStorage', function ($http, $q, $sessionStorage) {
  // Keep ids of recipients in session to make them available if the user refresh or change page
	$sessionStorage.recipients_ids = $sessionStorage.recipients_ids || [];

	this.recipients_ids = $sessionStorage.recipients_ids;

  this.getRecipients = function(){
  	var deferred = $q.defer();
		$http({
			url: '/api/politicians.json',
			method: 'GET',
  		params: {ids: JSON.stringify($sessionStorage.recipients_ids), include_ids: true}
		}).
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  };

	this.getNonRecipients = function(){
  	var deferred = $q.defer();
		$http({
			url: '/api/politicians.json',
			method: 'GET',
  		params: {ids: JSON.stringify($sessionStorage.recipients_ids), include_ids: false}
		}).
		success(function(data){
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
  };

	this.add = function(recipient){
		$sessionStorage.recipients_ids.push(recipient.id);
	};

	this.remove = function(recipient){
		$sessionStorage.recipients_ids.splice($sessionStorage.recipients_ids.indexOf(recipient.id), 1)
	};

	this.search = function(query){
		var deferred = $q.defer();
		$http({
			url: '/api/politicians/search.json',
			method: 'GET',
			params: {query: query, filtered_ids: JSON.stringify(this.recipients_ids)}
		}).
		then(function(resp) {
			deferred.resolve(resp.data);
		});
		return deferred.promise;
	};

}]);
