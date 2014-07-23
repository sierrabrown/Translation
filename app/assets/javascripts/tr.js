window.TR = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new TR.Routers.Router
		Backbone.history.start();
  }
};

