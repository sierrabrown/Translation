TR.Routers.Router = Backbone.Router.extend({
  routes: {
		"": "static_pages#root",
		"jobs/new": "newJob"
  },
	
	newJob: function() {
		var view = new TR.Views.JobNew()
		this._swapView(view)
	},

  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    $('#main').html(view.render().$el);
  }
});
