TR.Views.JobNew = Backbone.View.extend({
	template: JST['jobs/new'],
	
	events: {
		"submit form": "submit"
	},
	
	submit: function(event){
		event.preventDefault();
		var that = this
		var params = $(event.currentTarget).serializeJSON()
		var newJob = new TR.Models.Job(params["job"])
		newJob.save({}, {
			success: function() {
				TR.jobs.add(newJob);
				alert("Job sent out!");
				that.render()
			}
		})
		var form = document.getElementById("translateForm")
		form.reset();
	},
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		return this;
	}
})