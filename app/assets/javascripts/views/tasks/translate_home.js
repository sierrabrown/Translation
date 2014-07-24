TR.Views.TranslateHome = Backbone.View.extend({
	template: JST['tasks/home'],
	
	
	render: function() {
		var content = this.template();
		this.$el.html(content);
		return this;
	},
	
	events: {
		"submit form": "submit"
	},
	
	submit: function(event){
		event.preventDefault();
		var params = $(event.currentTarget).serializeJSON()
		var params = params["choice"]
		TR.tasks.fetch({ 
			data: {source_lang: params["from"], target_lang: params["to"]},
			success: function(){ console.log(TR.tasks)}
		})
		
	}
	
	
})