TR.Routers.Router = Backbone.Router.extend({
  routes: {
		"": "static_pages#root",
		"jobs/index": "indexJob",
		"jobs/new": "newJob",
		"translate": "translate"
  },
	
	indexJob: function() {
		TR.jobs.fetch();
		var view = new TR.Views.JobsIndex({
			collection: TR.jobs
		})
		
		this._swapView(view)
	},
	
	newJob: function() {
		var view = new TR.Views.JobNew()
		this._swapView(view)
	},
	
	translate: function() {
		var view = new TR.Views.TranslateHome()
		this._swapView(view)
	},

  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    $('#main').html(view.render().$el);
  }
	
});
