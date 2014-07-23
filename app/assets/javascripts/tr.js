window.TR = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		TR.jobs = new TR.Collections.Jobs();
    new TR.Routers.Router();
		Backbone.history.start();
  }
};

