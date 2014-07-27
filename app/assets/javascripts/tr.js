window.TR = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		TR.users = new TR.Collections.Users();
		TR.jobs = new TR.Collections.Jobs();
		TR.tasks = new TR.Collections.Tasks();
    new TR.Routers.Router();
		Backbone.history.start();
  }
};

