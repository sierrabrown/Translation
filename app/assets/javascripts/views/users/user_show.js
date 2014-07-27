TR.Views.UserShow = Backbone.View.extend({
	template: JST['users/show'],
	
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		
		var indexView = new TR.Views.JobsIndex({collection: this.collection})
		var content = indexView.render().$el
		this.$("#jobsIndex").html(content)
		return this;
	},
	
})