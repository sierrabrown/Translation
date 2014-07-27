TR.Views.JobNew = Backbone.View.extend({
	template: JST['jobs/new'],
	
	events: {
		"submit form": "submit",
		"keyup #textArea": "updateCost"
	},
	
	updateCost: function(event) {
		var len = $(event.currentTarget).val().length
		var cost = (len * 0.0022).toFixed(2);
		$("#cost").html("<h5>Total Cost: $" + cost + "</h5>")
	},
	
	submit: function(event){
		event.preventDefault();
		var that = this
		var params = $(event.currentTarget).serializeJSON();
		params["job"]["price"] = (params["job"]["source_text"].length * 0.0022).toFixed(2);
		
		if (TR.currentUser.get('funds') < params["job"]["price"]) {
			alert("bro you have no more money")
		} else {
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
		}
	},
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		return this;
	}
})