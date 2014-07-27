TR.Views.JobsIndex = Backbone.View.extend({
	template: JST['jobs/index'],
	
	initialize: function() {
		this.listenTo(this.collection, 'sync', this.render)
		this.listenTo(this.model, 'sync', this.render)
	},
	
	events: {
		"submit form": "submit",
	},
	
	render: function() {
		var content = this.template( {jobs: this.collection, tasks: this.collection2, currentUser: this.model} );
		this.$el.html(content);
		return this;
	},
	
	submit: function(event){
		event.preventDefault();
		event.stopPropagation();
		var that = this
		var params = $(event.target).serializeJSON()
		var params = params["user"]
		// Parde int and then move on
		this.model.set({target_text: params["target_text"], status: 'completed', translator_id: TR.currentUser.id})
	
		this.model.save({}, {
			success: function() {
				TR.tasks.fetch({
					data: {source_lang: that.model.source_lang, target_lang: that.model.target_lang, status: 'in progress'},
					success: function() { 
						if (TR.tasks.length == 0) {
							alert('You finished all the tasks available for this language pair.')
						} else {
						that.render()
						} 
					}
				})
			}
		})
	},
})