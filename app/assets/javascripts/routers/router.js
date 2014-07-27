TR.Routers.Router = Backbone.Router.extend({
  routes: {
		"": "static_pages#root",
		"jobs/index": "indexJob",
		"jobs/new": "newJob",
		"users/:id": "showUser",
		"home": "home",
		"translate": "translate"
  },
	
	showUser: function(id) {
		TR.jobs.fetch();
		user = TR.users.getOrFetch(id)
		var view = new TR.Views.UserShow({
			model: user, collection: TR.jobs
		})
		
		this._swapView(view)
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
	
	home: function() {
		var view = new TR.Views.Home()
		this._swapView(view)
	},

  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    $('#main').html(view.render().$el);
  }
	
});
