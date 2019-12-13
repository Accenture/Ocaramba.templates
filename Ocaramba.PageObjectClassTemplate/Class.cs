using System;
using System.Globalization;
using NLog;
using Ocaramba;
using Ocaramba.Extensions;
using Ocaramba.Types;

namespace $rootnamespace$
{
    public class $safeitemrootname$ : ProjectPageBase
    {
        $if$ ($targetframeworkversion$ >= 4.5)private static readonly NLog.Logger Logger = LogManager.GetCurrentClassLogger();$endif$$if$ ($targetframeworkversion$ < 4.0)private readonly NLog.Logger logger = NLog.Web.NLogBuilder.ConfigureNLog("nlog.config").GetCurrentClassLogger();$endif$

        /// <summary>
        /// Locators for elements
        /// </summary>
        private readonly ElementLocator
            linkLocator = new ElementLocator(Locator.CssSelector, "a[href='/{0}']"),
            basicAuthLink = new ElementLocator(Locator.XPath, "//a[contains(text(),'Auth')]");

        public $safeitemrootname$(DriverContext driverContext)
            : base(driverContext)
        {
        }

        /// <summary>
        /// Methods for this HomePage
        /// </summary>
        public void ClickOnElementWithLocatorFormating(string page)
{
            $if$ ($targetframeworkversion$ >= 4.5)Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");$endif$$if$ ($targetframeworkversion$ < 4.0)logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");$endif$
            this.Driver.GetElement(this.linkLocator.Format(page)).Click();
        }

        /// <summary>
        /// Methods for this HomePage
        /// </summary>
        public void ClickOnElement()
{
            $if$ ($targetframeworkversion$ >= 4.5)Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");$endif$$if$ ($targetframeworkversion$ < 4.0)logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");$endif$
            this.Driver.GetElement(this.basicAuthLink).Click();
        }

    }
}

