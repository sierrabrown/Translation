TR.Views.JobNew = Backbone.View.extend({
	template: JST['jobs/new'],
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		return this;
	}
})