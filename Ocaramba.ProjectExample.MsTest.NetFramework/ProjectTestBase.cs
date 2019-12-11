namespace $safeprojectname$
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Ocaramba;
    using Ocaramba.Logger;

    /// <summary>
    /// The base class for all tests <see href="https://github.com/ObjectivityLtd/Ocaramba/wiki/ProjectTestBase-class">More details on wiki</see>
    /// </summary>
    [TestClass]
    public class ProjectTestBase : TestBase
    {
        private readonly DriverContext driverContext = new Ocaramba.DriverContext();

        /// <summary>
        /// Gets or sets logger instance for driver
        /// </summary>
        public TestLogger LogTest
        {
            get
            {
                return this.DriverContext.LogTest;
            }

            set
            {
                this.DriverContext.LogTest = value;
            }
        }

        /// <summary>
        /// Gets or sets the microsoft test context.
        /// </summary>
        /// <value>
        /// The microsoft test context.
        /// </value>
        public TestContext TestContext { get; set; }

        /// <summary>
        /// Gets the driver context
        /// </summary>
        protected DriverContext DriverContext
        {
            get
            {
                return this.driverContext;
            }
        }

        /// <summary>
        /// Before the test.
        /// </summary>
        [TestInitialize]
        public void BeforeTest()
        {
            this.DriverContext.CurrentDirectory = AppDomain.CurrentDomain.BaseDirectory;
            this.DriverContext.TestTitle = this.TestContext.TestName;
            this.LogTest.LogTestStarting(this.driverContext);
            this.DriverContext.Start();
        }

        /// <summary>
        /// After the test.
        /// </summary>
        [TestCleanup]
        public void AfterTest()
        {
            this.DriverContext.IsTestFailed = this.TestContext.CurrentTestOutcome == UnitTestOutcome.Failed || !this.driverContext.VerifyMessages.Count.Equals(0);
            var filePaths = this.SaveTestDetailsIfTestFailed(this.driverContext);
            this.SaveAttachmentsToTestContext(filePaths);
            var javaScriptErrors = this.DriverContext.LogJavaScriptErrors();
            this.DriverContext.Stop();
            this.LogTest.LogTestEnding(this.driverContext);
            if (this.IsVerifyFailedAndClearMessages(this.driverContext) && this.TestContext.CurrentTestOutcome != UnitTestOutcome.Failed)
            {
                Assert.Fail("Look at stack trace logs for more details");
            }

            if (javaScriptErrors)
            {
                Assert.Fail("JavaScript errors found. See the logs for details");
            }
        }

        private void SaveAttachmentsToTestContext(string[] filePaths)
        {
            if (filePaths != null)
            {
                foreach (var filePath in filePaths)
                {
                    this.LogTest.Info("Uploading file [{0}] to test context", filePath);
                    this.TestContext.AddResultFile(filePath);
                }
            }
        }
    }
}
