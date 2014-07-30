TR.Views.JobNew = Backbone.View.extend({
	template: JST['jobs/new'],
	modal: JST['jobs/modal'],
	modal2: JST['jobs/modal2'],
	
	events: {
		"submit form": "submit",
		"keyup #textArea": "updateCost",
		"click #closeButton": "closeModal"
	},
	
	closeModal: function() {
		this.$el.find('#submitModal').modal('hide')
		$('.modal-backdrop').remove();
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
			that.$el.find('#bankModal').modal('show')
		} else {
		var newJob = new TR.Models.Job(params["job"])
		newJob.save({}, {
			success: function() {
				TR.jobs.add(newJob);
				// that.render()
				that.$el.find('#submitModal').modal('show')
			}
		})
		var form = document.getElementById("translateForm")
		form.reset();
		}
	},
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		var modal = this.modal()
		this.$el.find('#modalSpace').html(modal);
		var modal2 = this.modal2()
		this.$el.find('#modalSpace2').html(modal2);
		return this;
	}
})