TR.Collections.Users = Backbone.Collection.extend({
	model: TR.Models.User,
	url: '/users',
	
  getOrFetch: function (id) {
    var user = this.get(id);

    if(!user) {
      user = new TR.Models.User({ id: id });
      user.fetch({
        success: function () {
          this.add(user);
        }.bind(this)
      });
    } else {
      user.fetch();
    }
    return user;
  },
})