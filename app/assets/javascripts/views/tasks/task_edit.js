TR.Views.TaskEdit = Backbone.View.extend({
	template: JST['tasks/edit'],
	
	events: {
		"submit": "submit"
	},
	
	submit: function(event){
		event.preventDefault();
		var that = this
		var params = $(event.currentTarget).serializeJSON()
		var params = params["translation"]
		this.model.set({target_text: params["text"], completed: true})
		this.model.save({}, {
			success: function() {
				// Have to find corresponding job and check if it's been completed.
				alert("Task saved.");
				that.render()
			}
		})
	},
	
	render: function() {
		var content = this.template( { task: this.model } );
		this.$el.html(content);
		return this;
	}
})