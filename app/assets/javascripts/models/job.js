TR.Models.Job = Backbone.Model.extend({
	urlRoot: '/api/jobs',
	
	printOut: function() {
		console.log('delayed job call worked')
	}
})