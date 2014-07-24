TR.Views.JobsIndex = Backbone.View.extend({
	template: JST['jobs/index'],
	
	initialize: function() {
		this.listenTo(this.collection, 'sync', this.render)
	},
	
	render: function() {
		var content = this.template( {jobs: this.collection} );
		this.$el.html(content);
		return this;
	}
})