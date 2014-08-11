TR.Models.Job = Backbone.Model.extend({
	urlRoot: '/api/jobs',
	
	validate: function(attrs, options) {
		var errors = []
    	if (attrs.title == "") {
      	errors.push("Title field can't be blank.");
    	}
	    if (attrs.source_text == "") {
	      errors.push("Text field can't be blank.");
	    }
	    if (attrs.source_lang == attrs.target_lang) {
	      errors.push("Source and target languages must be different.");
	    }
		if (errors.length > 0) {
			return errors
		}
	 }
	
})