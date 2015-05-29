app.factory('recipientsFactory', ['$http', '$q', 'RecipientsService', function($http, $q, RecipientsService){

  var o = {
	   recipients: [],
     non_recipients: [],
     recipients_ids: RecipientsService.recipients_ids
	};

  o.getRecipients = function(){
    var deferred = $q.defer();
    RecipientsService.getRecipients().
    then(function(data){
      angular.copy(data, o.recipients);
	    deferred.resolve(data);
		}).
		catch(function(data){
			deferred.reject();
		});
    return deferred.promise;
  };

  o.getNonRecipients = function(){
    var deferred = $q.defer();
    RecipientsService.getNonRecipients().
    then(function(data){
      angular.copy(data, o.non_recipients);
	    deferred.resolve(data);
		}).
		catch(function(data){
			deferred.reject();
		});
    return deferred.promise;
  };

  o.add = function(recipient){
    o.recipients.push(o.non_recipients.splice(o.non_recipients.indexOf(recipient), 1)[0]);
    RecipientsService.add(recipient);
  };

  o.remove = function(recipient){
    o.non_recipients.push(o.recipients.splice(o.recipients.indexOf(recipient), 1)[0]);
    RecipientsService.remove(recipient);
  };

	return o;
}]);
