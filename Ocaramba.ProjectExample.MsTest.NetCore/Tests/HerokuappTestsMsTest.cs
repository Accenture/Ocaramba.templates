// MsTest tests
// See documentation : https://github.com/ObjectivityLtd/Ocaramba 

namespace $safeprojectname$
{

    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using PageObjects;

    [TestClass]
    public class $safeitemrootname$ : ProjectTestBase
    {
        [TestMethod]
        public void TickCheckboxTest()
        {
            // TODO: Add your test code here
            var checkboxes = new InternetPage(this.DriverContext);
            checkboxes.OpenHomePage();
        }

        [TestMethod]
        public void UnTickCheckboxTest()
        {
            // TODO: Add your test code here
            var checkboxes = new InternetPage(this.DriverContext);
            checkboxes.OpenHomePage();
        }
    }
}
