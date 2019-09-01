namespace $safeprojectname$.Tests
{
    using System.Diagnostics.CodeAnalysis;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using PageObjects;

    /// <summary>
    /// Tests to verify checkboxes tick and Untick.
    /// </summary>
    [TestClass]
    [SuppressMessage("StyleCop.CSharp.DocumentationRules", "SA1650:ElementDocumentationMustBeSpelledCorrectly", Justification = "Reviewed. Suppression is OK here.")]
    public class HerokuappTestsMsTest : ProjectTestBase
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
