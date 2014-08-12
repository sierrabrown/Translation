describe("TR.Collections.Jobs collection", function () {
  beforeEach(function () {
    this.jobs = new TR.Collections.Jobs();
  });

  it("has the correct model defined", function () {
    expect(this.jobs.model).toEqual(TR.Models.Job);
  });

  it("has the correct url defined", function () {
    expect(this.jobs.url).toEqual('/api/jobs');
  });
});
