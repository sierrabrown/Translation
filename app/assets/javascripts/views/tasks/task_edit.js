TR.Views.TaskEdit = Backbone.View.extend({
	template: JST['tasks/edit'],
	
	counter: 0,
	
	events: {
		"submit #edit": "submit",
		"click #skip": "skip"
	},
	
	submit: function(event){
		event.preventDefault();
		event.stopPropagation();
		var that = this
		var params = $(event.target).serializeJSON()
		var params = params["task"]
		this.model.set({target_text: params["target_text"], status: 'completed', translator_id: TR.currentUser.id})
		this.counter = this.counter + parseInt(this.model.escape('price'))
		this.model.save({}, {
			success: function() {
				TR.tasks.fetch({
					data: {source_lang: that.model.source_lang, target_lang: that.model.target_lang, status: 'in progress'},
					success: function() { 
						if (TR.tasks.length == 0) {
							alert('You finished all the tasks available for this language pair.')
						} else {
						that.render()
						} 
					}
				})
			}
		})
	},
	
	updateCost: function(price) {
		this.earnings = this.earnings + price
	},
	
	skip: function() {
		if (TR.tasks.models.length == 0) {
			alert("You are out of tasks")
		} else {
			TR.tasks.models = TR.tasks.models.slice(1)
			this.render()
		}
	},
	
	
	render: function() {
		if (TR.tasks.models.length == 0) {
			this.$el.html("<div> </div>")
			alert("you are out of tasks")
		} else {
			this.model = TR.tasks.models[0]
			var content = this.template( { task: this.model, counter: this.counter} );
			this.$el.html(content);
			return this;
		}
	}
})