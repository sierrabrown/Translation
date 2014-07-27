TR.Models.User = Backbone.Model.extend({
	urlRoot: function () {
		if (this.isNew() && this.get('currentUser')) {
			return '/current_user'
		} else {
			return '/users'
		}
	}
})