describe("PostApp.Views.PostShow", function () {
  it("renders content into $el", function () {
    var post = new PostApp.Models.Post({ title: "post1" });
    var view = new PostApp.Views.PostShow({ model: post });
    view.render();
    expect(view.$el.text()).toMatch(/Post Show View/);
  });
});
