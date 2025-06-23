// <copyright file="$safeitemrootname$.cs" company="Ocaramba">
// Copyright (c) Ocaramba. All rights reserved.
// </copyright>
// Page object class
// See documentation : https://github.com/ObjectivityLtd/Ocaramba


namespace $rootnamespace$
{
    using System;
    using System.Globalization;
    using NLog;
    using Ocaramba;
    using Ocaramba.Extensions;
    using Ocaramba.Types;

    /// <summary>
    /// Page object class.
    /// </summary>
    public class $safeitemrootname$ : ProjectPageBase
        {
            private static readonly NLog.Logger Logger = LogManager.GetCurrentClassLogger();

            /// <summary>
            /// Locators for elements
            /// </summary>
            private readonly ElementLocator
                linkLocator = new ElementLocator(Locator.CssSelector, "a[href='/{0}']"),
                basicAuthLink = new ElementLocator(Locator.XPath, "//a[contains(text(),'Auth')]");

            /// <summary>
            /// Initializes a new instance of the <see cref="$safeitemrootname$"/> class.
            /// </summary>
            /// <param name="driverContext">Base driverContext.</param>
            public $safeitemrootname$(DriverContext driverContext)
                : base(driverContext)
            {
            }

            /// <summary>
            /// Methods for this HomePage
            /// </summary>
            public void ClickOnElementWithLocatorFormating(string page)
            {
                Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");
                this.Driver.GetElement(this.linkLocator.Format(page)).Click();
            }

            /// <summary>
            /// Methods for this HomePage
            /// </summary>
            public void ClickOnElement()
    {
                Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");
                this.Driver.GetElement(this.basicAuthLink).Click();
            }

        }
    }

