// NUnit 3 tests
// See documentation : https://github.com/ObjectivityLtd/Ocaramba 

using NUnit.Framework;
using Ocaramba.ProjectExample.NUnit.NetCore.PageObjects;

namespace Ocaramba.ProjectExample.NUnit.NetCore.Tests
{
    [TestFixture]
    [Parallelizable(ParallelScope.Fixtures)]
    public class HerokuappTestsNUnit : ProjectTestBase
    {
        [Test]
        public void BasicAuthTest()
        {
            // TODO: Add your test code here
            var basicAuthPage = new InternetPage(this.DriverContext);
            basicAuthPage.OpenHomePage();
        }
    }
}
