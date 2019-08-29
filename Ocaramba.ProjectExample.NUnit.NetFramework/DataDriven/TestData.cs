using System.Collections;
using System.Globalization;
using NUnit.Framework;

namespace $safeprojectname$.DataDriven
{
    /// <summary>
    /// DataDriven methods for NUnit test framework
    /// </summary>
    public static class TestData
    {
        public static IEnumerable Credentials
        {
            get { return DataDrivenHelper.ReadDataDriveFile(ProjectBaseConfiguration.DataDrivenFile, "credential", new[] { "user", "password" }, "credential"); }
        }

        public static IEnumerable CredentialsExcel
        {
            get { return DataDrivenHelper.ReadXlsxDataDriveFile(ProjectBaseConfiguration.DataDrivenFileXlsx, "credential", new[] { "user", "password" }, "credentialExcel"); }
        }

        public static IEnumerable LinksSetTestName
        {
            get { return DataDrivenHelper.ReadDataDriveFile(ProjectBaseConfiguration.DataDrivenFile, "links", new[] { "number" }, "Count_links"); }
        }

        public static IEnumerable Links
        {
            get { return DataDrivenHelper.ReadDataDriveFile(ProjectBaseConfiguration.DataDrivenFile, "links"); }
        }

        public static IEnumerable LinksExcel()
        {
            return DataDrivenHelper.ReadXlsxDataDriveFile(ProjectBaseConfiguration.DataDrivenFileXlsx, "links");
        }

        public static IEnumerable CredentialsCSV()
        {
            var path = TestContext.CurrentContext.TestDirectory;
            path = string.Format(CultureInfo.CurrentCulture, "{0}{1}", path, @"\DataDriven\TestDataCsv.csv");
            return DataDrivenHelper.ReadDataDriveFileCsv(path, new[] { "user", "password" }, "credentialCsv");
        }
    }
}
