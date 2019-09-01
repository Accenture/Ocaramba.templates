namespace $safeprojectname$.Tests
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using PageObjects;

    /// <summary>
    /// Tests to verify checkboxes tick and Untick.
    /// </summary>
    [TestClass]
    public class HerokuappTestsMsTest2 : ProjectTestBase
    {
        [TestMethod]
        public void PageSourceContainsCaseTest()
        {
            // TODO: Add your test code here
            var statusCodes = new InternetPage(this.DriverContext);
            statusCodes.OpenHomePage();
        }
    }
}
