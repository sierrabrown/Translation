TR.Collections.Jobs = Backbone.Collection.extend({
	model: TR.Models.Job,
	url: '/api/jobs',
	
  getOrFetch: function (id) {
    var job = this.get(id);

    if(!job) {
      job = new TR.Models.Job({ id: id });
      job.fetch({
        success: function () {
          this.add(job);
        }.bind(this)
      });
    } else {
      job.fetch();
    }
    return job;
  },
})