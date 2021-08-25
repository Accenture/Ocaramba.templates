// <copyright file="HerokuappTestsNUnit.cs" company="Ocaramba">
// Copyright (c) Ocaramba. All rights reserved.
// </copyright>
// NUnit 3 tests
// See documentation : https://github.com/ObjectivityLtd/Ocaramba

namespace $safeprojectname$
{
    using NUnit.Framework;
    using $safeprojectname$.PageObjects;

    /// <summary>
    /// Test class.
    /// </summary>
    [TestFixture]
    [Parallelizable(ParallelScope.Fixtures)]
    public class HerokuappTestsNUnit : ProjectTestBase
    {
        /// <summary>
        /// Test method.
        /// </summary>
        [Test]
        public void HomePageTest()
        {
            // TODO: Add your test code here
            var homePage = new InternetPage(this.DriverContext);
            homePage.OpenHomePage();
        }
    }
}
