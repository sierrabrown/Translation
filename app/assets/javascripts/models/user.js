TR.Models.User = Backbone.Model.extend({
	urlRoot: function () {
		debugger
		if (model.currentUser) {
			return '/current_user'
		} else {
			return '/users'
		}
	},
	
	intialize: function (options) { 
		debugger
	}
})