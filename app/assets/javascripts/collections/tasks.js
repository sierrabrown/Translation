TR.Collections.Tasks = Backbone.Collection.extend({
	model: TR.Models.Task,
	url: '/api/tasks',
	
  getOrFetch: function (id) {
    var task = this.get(id);

    if(!task) {
      task = new TR.Models.Task({ id: id });
      task.fetch({
        success: function () {
          this.add(task);
        }.bind(this)
      });
    } else {
      task.fetch();
    }
    return task;
  },
})