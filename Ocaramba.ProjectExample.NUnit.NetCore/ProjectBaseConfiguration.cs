using System.Configuration;
using System.IO;
using Ocaramba;
using Ocaramba.Helpers;

namespace $safeprojectname$
{
    /// <summary>
    /// SeleniumConfiguration that consume app.config file
    /// </summary>
    public static class ProjectBaseConfiguration
    {
        private static readonly string CurrentDirectory = Directory.GetCurrentDirectory();

        /// <summary>
        /// Gets the data driven file.
        /// </summary>
        /// <value>
        /// The data driven file.
        /// </value>
        public static string DataDrivenFile
        {
            get
            {
                if (BaseConfiguration.UseCurrentDirectory)
                {
                    return Path.Combine(CurrentDirectory + BaseConfiguration.Builder["appSettings:DataDrivenFile"]);
                }

                return BaseConfiguration.Builder["appSettings:DataDrivenFile"];
            }
        }

        /// <summary>
        /// Gets the Excel data driven file.
        /// </summary>
        /// <value>
        /// The Excel data driven file.
        /// </value>
        public static string DataDrivenFileXlsx
        {
            get
            {
                if (BaseConfiguration.UseCurrentDirectory)
                {
                    return Path.Combine(CurrentDirectory + BaseConfiguration.Builder["appSettings:DataDrivenFileXlsx"]);
                }

                return BaseConfiguration.Builder["appSettings:DataDrivenFileXlsx"];
            }
        }

        /// <summary>
        /// Gets the Download Folder path
        /// </summary>
        public static string DownloadFolderPath
        {
            get { return FilesHelper.GetFolder(BaseConfiguration.Builder["appSettings:DownloadFolder"], CurrentDirectory); }
        }
    }
}
