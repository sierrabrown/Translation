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
		this.model.set({target_text: params["target_text"], completed: true})
		this.model.save({}, {
			success: function() {
				alert("Task saved.");
				updateParent();
				alert("Parent updated.");
				that.render()
			}
		})
	},
	
	updateParent: function(id) {
		var parent_id = this.model.job_id
		var parentJob = Job.getOrFetch(parent_id)
		if (parentJob.finished()) {
		   parentJob.completed = true
		   alert("set in action chain of events to notify customer job is completed. action mailer?")
		}
	},
	
	render: function() {
		var content = this.template( { task: this.model } );
		this.$el.html(content);
		return this;
	}
})