using System;
using System.Globalization;
using NLog;
using Ocaramba.Extensions;
using Ocaramba.ProjectExample.NUnit.NetFramework;
using Ocaramba.Types;

namespace Ocaramba.Template.NUnit.PageObjects
{
    public class InternetPage : ProjectPageBase
    {
        private static readonly NLog.Logger Logger = LogManager.GetCurrentClassLogger();

        /// <summary>
        /// Locators for elements
        /// </summary>
        private readonly ElementLocator
            linkLocator = new ElementLocator(Locator.CssSelector, "a[href='/{0}']");

        public InternetPage(DriverContext driverContext)
            : base(driverContext)
        {
        }

        /// <summary>
        /// Methods for this HomePage
        /// </summary>
        public void OpenHomePage()
        {
            var url = BaseConfiguration.GetUrlValue;
            this.Driver.NavigateTo(new Uri(url));
            Logger.Info(CultureInfo.CurrentCulture, "Opening page {0}", url);
        }

    }
}
