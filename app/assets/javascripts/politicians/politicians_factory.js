app.factory('politiciansFactory', ['$http', '$q', '$upload', '$filter', 'PoliticiansService', 'recipientsFactory', function($http, $q, $upload, $filter, PoliticiansService, recipientsFactory){

	var o = {
		politicians: recipientsFactory.non_recipients,
		politician: {},
		search_results: []
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
		var filtered_ids = recipientsFactory.recipients_ids
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

	o.addRecipient = function(recipient){
		recipientsFactory.add(recipient);
	};

	o.removeRecipient = function(recipient){
		recipientsFactory.remove(recipient);
	};

	return o;
}]);
