TR.Views.TaskEdit = Backbone.View.extend({
	template: JST['tasks/edit'],
	
	events: {
		"submit #edit": "submit"
	},
	
	submit: function(event){
		event.preventDefault();
		event.stopPropagation();
		var that = this
		var params = $(event.target).serializeJSON()
		var params = params["task"]
		debugger
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
	
	
	render: function() {
		this.model = TR.tasks.models[0]
		var content = this.template( { task: this.model } );
		this.$el.html(content);
		return this;
	}
})