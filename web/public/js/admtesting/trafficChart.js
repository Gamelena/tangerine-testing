dojo.declare('admtesting.trafficChart', null, {
	store : null,
	show : function(data) {
		console.log(data);
		var url = base_url + 'crud-request?model&format=json&p=';
		var self = this;
		dojo.require(['dojox/data/QueryReadStore'], function(QueryReadStore){
			self.store = new QueryReadStore({url: url});
		});
	}
});