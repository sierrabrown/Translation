TR.Views.JobsIndex = Backbone.View.extend({
	template: JST['jobs/index'],
	modal: JST['jobs/modal3'],
	
	initialize: function() {
		this.listenTo(this.collection, 'sync', this.render)
		this.listenTo(this.model, 'sync', this.render)
	},
	
	events: {
		"submit form": "submit",
		"click #closeButton": "closeModal"
	},
	
	closeModal: function() {
		this.$el.find('#submitModal').modal('hide')
		$('.modal-backdrop').remove();
	},
	
	render: function() {
		var content = this.template( {jobs: this.collection, tasks: this.collection2, currentUser: this.model} );
		this.$el.html(content);
		var modal = this.modal()
		this.$el.find('#modalSpace').html(modal);
		return this;
	},
	
	stripeResponseHandler: function(status, response) {
	  var $form = $('#payment-form');
	  if (response.error) {
	    // Show the errors on the form
	    $form.find('.payment-errors').text(response.error.message);
	    $form.find('button').prop('disabled', false);
	  } else {
	    // response contains id and card, which contains additional card details
	    var token = response.id;
	    // Insert the token into the form so it gets submitted to the server
	    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
	    // and submit
			formData = $form.serializeJSON()
	    $.ajax({
	    	data: formData,
				url: "/api/users/charge",
				method: "POST",
				dataType: "JSON",
				success: this.notifyUser
	    })
	  }
	},
	
	notifyUser: function() {
		//this.$el.find('#transactionModal').modal('show')
		// This modal still not working
	},
	
	submit: function(event){
		event.preventDefault();
		event.stopPropagation();
		cost = $(event.currentTarget).serializeJSON()
		TR.currentUser.set({funds: parseInt(TR.currentUser.escape('funds')) + parseInt(cost["amount"]) * 100 })
		TR.currentUser.save()
		this.notifyUser()
		//Disabled Stripe for the purpose of demos.
				//
		// 	  var $form = $(event.currentTarget);
		// 	     // Disable the submit button to prevent repeated clicks
		// 	  $form.find('button').prop('disabled', true);
		// Stripe.setPublishableKey('pk_test_4Twzx8W4JDyBDVQROR7RDHKn')
		// 	  Stripe.card.createToken($form, this.stripeResponseHandler);
	},
})