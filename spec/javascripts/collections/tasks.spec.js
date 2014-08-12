describe("TR.Collections.Tasks collection", function () {
  beforeEach(function () {
    this.tasks = new TR.Collections.Tasks();
  });

  it("has the correct model defined", function () {
    expect(this.tasks.model).toEqual(TR.Models.Task);
  });

  it("has the correct url defined", function () {
    expect(this.tasks.url).toEqual('/api/tasks');
  });
});
