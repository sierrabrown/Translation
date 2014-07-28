TR.Views.JobShow = Backbone.View.extend({
	template: JST['jobs/show'],
	
	initialize: function() {
		this.listenTo(this.model, 'sync', this.render)
	},
	
	render: function() {
		var content = this.template({job: this.model});
		this.$el.html(content);
		return this;
	}
})