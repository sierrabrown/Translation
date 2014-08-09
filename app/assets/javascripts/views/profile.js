TR.Views.Profile = Backbone.View.extend({
	template: JST['profile'],
	
	render: function() {
		var content = this.template({
			jobs: this.jobs, tasks: this.tasks, currentUser: this.currentUser
		});
		this.$el.html(content);
		return this;
	},
	

})