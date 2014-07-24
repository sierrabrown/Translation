TR.Views.JobNew = Backbone.View.extend({
	template: JST['jobs/new'],
	
	events: {
		"submit form": "submit"
	},
	
	submit: function(event){
		event.preventDefault();
		var params = $(event.currentTarget).serializeJSON()
		var newJob = new TR.Models.Job(params["job"])
		newJob.save({}, {
			success: function() {
				TR.jobs.add(newJob);
				debugger;
				newJob.delay.printOut() //Arguments come rigth after.
				alert("Job sent out!");
				this.render()
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