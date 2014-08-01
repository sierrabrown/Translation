TR.Views.TranslateHome = Backbone.View.extend({
	template: JST['tasks/home'],
	modal: JST['tasks/modal'],
	
	
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		var modal = this.modal()
		this.$el.find('#modalSpace').html(modal);
		return this;
	},
	

	events: {
		"submit #translate-form": "submit",
	},
	
	submit: function(event){
		event.preventDefault();
		var params = $(event.currentTarget).serializeJSON()
		var params = params["choice"]
		var that = this;
		TR.tasks.fetch({ 
			data: {source_lang: params["from"], target_lang: params["to"], status: 'in progress'},
			success: function() { 
				if (TR.tasks.length == 0) {
					that.$el.find('#submitModal').modal('show')
				} else {
					that.edit() 
				}
			}
		})
	},
	edit: function() {
		var model = TR.tasks.models[0]
		if (model != undefined) {
			var view = new TR.Views.TaskEdit({model: model})
			var content = view.render().$el
			this.$("#workspace").html(content)
		}
	}
	
})