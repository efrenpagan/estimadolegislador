app.factory('politiciansFactory', ['$http', '$q', '$upload', '$filter', '$sessionStorage', 'PoliticiansService', function($http, $q, $upload, $filter, $sessionStorage, PoliticiansService){

	// Keep ids of recipients in session to make them available if the user refresh or change page
	$sessionStorage.recipients_ids = $sessionStorage.recipients_ids || [];

	var o = {
		politicians: [],
		politician: {},
		recipients: [],
		search_results: []
	};

	o.index = function(){
		var deferred = $q.defer();
		$http.get('/api/politicians.json').
		success(function(data){
			// This is a good code candidate for improvement
			if (!o.recipients.length){
				$sessionStorage.recipients_ids.forEach(function(id){
					data.some(function(item, index){
						if (item.id == id){
							o.recipients.push(data.splice(index, 1)[0]);
							return true;
						};
					});
				});
			}
			angular.copy(data, o.politicians);
	    deferred.resolve(data);
		}).
		error(function(data, status, headers, config) {
	    deferred.reject();
	  });
		return deferred.promise;
	};

	o.find = function(id){
		var deferred = $q.defer();
		PoliticiansService.find(id).
		then(function(data){
			data.image_preview = data.image;
			angular.copy(data, o.politician);
	    deferred.resolve(data);
		}).
		catch(function(data){
			deferred.reject();
		});
		return deferred.promise;
	};

	o.update = function(params){
		var deferred = $q.defer();
		$upload.upload({
      url: '/api/politicians/'+params.id+'.json',
      method: 'PUT',
      fields: PoliticiansService.params('politician', params),
      file: params.image,
      fileFormDataName: 'politician[image]'
    }).
    success(function (data, status, headers, config) {
    	angular.copy(data, o.politician);
      deferred.resolve(data);
    })
    .error(function (data, status, headers, config) {
			deferred.reject(status);
		})
    return deferred.promise;
	};

	o.create = function(params){
		var deferred = $q.defer();
		$upload.upload({
      url: '/api/politicians.json',
      method: 'POST',
      fields: PoliticiansService.params('politician', params),
      file: params.image,
      fileFormDataName: 'politician[image]'
    }).
    success(function (data, status, headers, config) {
    	angular.copy(data, o.politician);
      deferred.resolve(data);
    }).
    error(function (data, status, headers, config) {
			deferred.reject(status);
		})
    return deferred.promise;
	};

	o.search = function(query){
		var deferred = $q.defer();
		var filtered_ids = $sessionStorage.recipients_ids
		PoliticiansService.search(query, filtered_ids).then(function(data){
			angular.copy(data, o.search_results);
			deferred.resolve(data);
		});
		return deferred.promise;
	};

	o.reset = function(){
		var deferred = $q.defer();
    angular.copy({}, o.politician);
    deferred.resolve({});
    return deferred.promise;
	};

	o.addRecipient = function(politician){
		o.recipients.push(o.politicians.splice(o.politicians.indexOf(politician), 1)[0]);
		$sessionStorage.recipients_ids.push(politician.id);
	};

	o.removeRecipient = function(politician){
		o.politicians.push(o.recipients.splice(o.recipients.indexOf(politician), 1)[0]);
		$sessionStorage.recipients_ids.splice($sessionStorage.recipients_ids.indexOf(politician.id), 1)
	};

	return o;
}]);