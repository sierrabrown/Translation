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

	notifyUser: function() {
		this.$el.find('#transactionModal').modal('show')
		// This modal still not working
	},
	
	submit: function(event){
		event.preventDefault();
		event.stopPropagation();
		cost = $(event.currentTarget).serializeJSON()
		TR.currentUser.set({funds: parseInt(TR.currentUser.escape('funds')) + parseInt(cost["amount"]) * 100 })
		TR.currentUser.save()
	},
})
