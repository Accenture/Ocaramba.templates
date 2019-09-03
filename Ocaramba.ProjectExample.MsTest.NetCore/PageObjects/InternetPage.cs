namespace $safeprojectname$.PageObjects
{
    using System;
    using System.Globalization;
    using NLog;
    using Extensions;
    using Types;

    public class InternetPage : ProjectPageBase
    {
        private static readonly NLog.Logger Logger = LogManager.GetCurrentClassLogger();

        /// <summary>
        /// Locators for elements
        /// </summary>
        private readonly ElementLocator
            linkLocator = new ElementLocator(Locator.CssSelector, "a[href='/{0}']"),
            basicAuthLink = new ElementLocator(Locator.XPath, "//a[contains(text(),'Auth')]");

        public InternetPage(DriverContext driverContext)
            : base(driverContext)
        {
        }

        /// <summary>
        /// Methods for this HomePage
        /// </summary>
        /// <returns>Returns HomePage</returns>
        public void OpenHomePage()
        {
            var url = BaseConfiguration.GetUrlValue;
            Logger.Info(CultureInfo.CurrentCulture, "Opening page {0}", url);
            this.Driver.NavigateTo(new Uri(url));
        }

        /// <summary>
        /// Methods for this HomePage
        /// </summary>
        /// <returns>Returns Homepage</returns>

        public void GoToPage(string page)
        {
            Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");
            this.Driver.GetElement(this.linkLocator.Format(page)).Click();
        }   
    }
}
