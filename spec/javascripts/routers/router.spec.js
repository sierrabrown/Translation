// describe("TR.Routers.Router - handlers", function() {
//   beforeEach(function () {
//     TR.initialize();
//     TR.jobs = new TR.Collections.Jobs();
//     TR.jobs.add(new TR.Models.Job({ id: 1 }));
// 		TR.currentUser = new TR.Models.User({username: 'test', email: 'test@gmail.com', password: 'testtest'})
//     this.$rootEl = $('<div>');
//     this.router = new TR.Routers.Router({
//       $rootEl: this.$rootEl,
//       jobs: TR.jobs,
// 			currentUser: TR.currentUser
//     });
//   });
//
//   describe("#index handler", function() {
//     it("renders the Jobs Index template into $rootEl", function () {
//       this.router.indexJob();
// 			console.log(this.$rootEl)
//       expect(this.$rootEl.text()).toMatch("Stats and Orders");
//     });
//   });
//
//   describe("#show handler", function () {
//     it("renders the Post Show template into $rootEl", function () {
//       this.router.show("1");
//       expect(this.$rootEl.text()).toMatch(/Post Show View/);
//     });
//   });
//
//   describe("#new handler", function () {
//     it("renders the Post Form template into $rootEl", function () {
//       this.router.new();
//       expect(this.router.$rootEl.text()).toMatch(/Submit/);
//     });
//   });
//
//   describe("#edit handler", function () {
//     it("renders the Post Form template into $rootEl", function () {
//       this.router.edit("1");
//       expect(this.router.$rootEl.text()).toMatch(/Submit/);
//     });
//   });
// });
