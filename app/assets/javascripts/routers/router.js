TR.Routers.Router = Backbone.Router.extend({
  routes: {
		"": "home",
		"jobs/index": "indexJob",
		"jobs/new": "newJob",
		"jobs/:id": "showJob",
		"jobs/:id/download": "downloadJob",
		"home": "home",
		"profile": "profile",
		"translate": "translate",
		"charge": "charge",
		"contact": "contact"
  },
	
	downloadJob: function(id) {
		debugger
	},
	
	showJob: function(id) {
		TR.jobs.fetch()
		var job = TR.jobs.getOrFetch(id)
		var view = new TR.Views.JobShow({model: job})
		this._swapView(view)
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
		TR.currentUser.fetch();
		var view = new TR.Views.JobsIndex({
			collection: TR.jobs,
			model: TR.currentUser
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
		var that = this
    if (this.currentView) { 
			this.currentView.$el.fadeOut(500, function() {
				that.currentView.remove()
	    	that.currentView = view;
				$('#main').html(view.render().$el.hide().fadeIn(500))
	    	//$('#main').html(view.render().$el);
			})
		} else {
    	that.currentView = view;
    	$('#main').html(view.render().$el);
		}
  }
});
