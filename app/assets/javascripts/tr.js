window.TR = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		TR.currentUser = new TR.Models.User({currentUser: true});
		TR.currentUser.fetch();
		TR.jobs = new TR.Collections.Jobs();
		TR.tasks = new TR.Collections.Tasks();
    new TR.Routers.Router();
		Backbone.history.start();
  }
};

