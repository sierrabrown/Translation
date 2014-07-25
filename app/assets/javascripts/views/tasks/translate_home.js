TR.Views.TranslateHome = Backbone.View.extend({
	template: JST['tasks/home'],
	
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		return this;
	},
	
	renderWorkspace: function() {
		var content = this.workspace();
		this.$el.html(content)
		return this;
	},
	
	events: {
		"submit form": "submit",
	},
	
	submit: function(event){
		event.preventDefault();
		var params = $(event.currentTarget).serializeJSON()
		var params = params["choice"]
		var that = this;
		TR.tasks.fetch({ 
			data: {source_lang: params["from"], target_lang: params["to"]},
			success: function() { that.edit() }
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