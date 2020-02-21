// NUnit 3 tests
// See documentation : https://github.com/ObjectivityLtd/Ocaramba 

using NUnit.Framework;
using $safeprojectname$.PageObjects;

namespace $safeprojectname$
{
    [TestFixture]
    [Parallelizable(ParallelScope.Fixtures)]
    public class HerokuappTestsNUnit : ProjectTestBase
    {
        [Test]
        public void HomePageTest()
        {
            // TODO: Add your test code here
            var homePage = new InternetPage(this.DriverContext);
            homePage.OpenHomePage();
        }
    }
}
