// NUnit 3 tests
// <copyright file="HerokuappTestsNUnit.cs" company="Ocaramba">
// Copyright (c) Ocaramba. All rights reserved.
// </copyright>
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
    public class $safeitemrootname$ : ProjectTestBase
    {
        /// <summary>
        /// Test method.
        /// </summary>
        [Test]
        public void BasicAuthTest()
        {
            // TODO: Add your test code here
            var basicAuthPage = new InternetPage(this.DriverContext);
            basicAuthPage.OpenHomePage();
        }
    }
}
