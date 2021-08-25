// <copyright file="InternetPage.cs" company="Ocaramba">
// Copyright (c) Ocaramba. All rights reserved.
// </copyright>
// <license>
//     The MIT License (MIT)
//     Permission is hereby granted, free of charge, to any person obtaining a copy
//     of this software and associated documentation files (the "Software"), to deal
//     in the Software without restriction, including without limitation the rights
//     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//     copies of the Software, and to permit persons to whom the Software is
//     furnished to do so, subject to the following conditions:
//     The above copyright notice and this permission notice shall be included in all
//     copies or substantial portions of the Software.
//     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//     SOFTWARE.
// </license>

namespace $safeprojectname$.PageObjects
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
    public class InternetPage : ProjectPageBase
    {
        private static readonly NLog.Logger Logger = LogManager.GetCurrentClassLogger();

        /// <summary>
        /// Locators for elements.
        /// </summary>
        private readonly ElementLocator
            linkLocator = new ElementLocator(Locator.CssSelector, "a[href='/{0}']"),
            basicAuthLink = new ElementLocator(Locator.XPath, "//a[contains(text(),'Auth')]");

        /// <summary>
        /// Initializes a new instance of the <see cref="InternetPage"/> class.
        /// </summary>
        /// <param name="driverContext">Base driverContext.</param>
        public InternetPage(DriverContext driverContext)
            : base(driverContext)
        {
        }

        /// <summary>
        /// Methods for this HomePage.
        /// </summary>
        public void OpenHomePage()
        {
            var url = BaseConfiguration.GetUrlValue;
            Logger.Info(CultureInfo.CurrentCulture, "Opening page {0}", url);
            this.Driver.NavigateTo(new Uri(url));
        }

        /// <summary>
        /// Go to page.
        /// </summary>
        /// <param name="page">Format locator.</param>
        public void GoToPage(string page)
        {
            Logger.Info(CultureInfo.CurrentCulture, "Clicking on element link");
            this.Driver.GetElement(this.linkLocator.Format(page)).Click();
        }
    }
}
