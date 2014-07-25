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
				that.updateParent(that.model.id);
				TR.tasks.fetch({
					data: {source_lang: 'en', target_lang: 'es', completed: false},
					success: function() { console.log(TR.tasks); that.render() }
				})
			}
		})
	},
	
	// Done server side?
	updateParent: function(id) {
		var parent_id = this.model.get('job_id')
		var parentJob = TR.jobs.getOrFetch(parent_id)
		if (this.completion(parent_id)) {
		   parentJob.completed = true
			 parentJob.save()
		}
	},

	completion: function(id) {
		var tests = TR.tasks
		var tests = tests.where({job_id: id})
		tests.forEach( function(task) {
			if (task.completed == false) {
				return false
			}
		})
		return true;
	},
	
	
	render: function() {
		this.model = TR.tasks.models[0]
		var content = this.template( { task: this.model } );
		this.$el.html(content);
		return this;
	}
})