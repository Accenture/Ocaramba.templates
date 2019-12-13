namespace $safeprojectname$
{
    using Ocaramba;
    using OpenQA.Selenium;

    public partial class ProjectPageBase
    {
        public ProjectPageBase(DriverContext driverContext)
        {
            this.DriverContext = driverContext;
            this.Driver = driverContext.Driver;
        }

        protected IWebDriver Driver { get; set; }

        protected DriverContext DriverContext { get; set; }
    }
}