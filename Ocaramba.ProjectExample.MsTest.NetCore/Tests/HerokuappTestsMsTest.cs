// <copyright file="HerokuappTestsMsTest.cs" company="Ocaramba">
// Copyright (c) Ocaramba. All rights reserved.
// </copyright>
// MsTest tests
// See documentation : https://github.com/ObjectivityLtd/Ocaramba

namespace $safeprojectname$
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using $safeprojectname$.PageObjects;

    /// <summary>
    /// Test class.
    /// </summary>
    [TestClass]
    public class $safeitemrootname$ : ProjectTestBase
    {
        /// <summary>
        /// Test method.
        /// </summary>
        [TestMethod]
        public void TickCheckboxTest()
        {
            // TODO: Add your test code here
            var checkboxes = new InternetPage(this.DriverContext);
            checkboxes.OpenHomePage();
        }

        /// <summary>
        /// Test method.
        /// </summary>
        [TestMethod]
        public void UnTickCheckboxTest()
        {
            // TODO: Add your test code here
            var checkboxes = new InternetPage(this.DriverContext);
            checkboxes.OpenHomePage();
        }
    }
}
