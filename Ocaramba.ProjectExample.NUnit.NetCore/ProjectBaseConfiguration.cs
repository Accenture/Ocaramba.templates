using System.Configuration;
using System.IO;
using Ocaramba.Helpers;

namespace Ocaramba.ProjectExample.NUnit.NetCore
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
                    return Path.Combine(CurrentDirectory + ConfigurationManager.AppSettings["DataDrivenFile"]);
                }

                return ConfigurationManager.AppSettings["DataDrivenFile"];
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
                    return Path.Combine(CurrentDirectory + ConfigurationManager.AppSettings["DataDrivenFileXlsx"]);
                }

                return ConfigurationManager.AppSettings["DataDrivenFileXlsx"];
            }
        }

        /// <summary>
        /// Gets the Download Folder path
        /// </summary>
        public static string DownloadFolderPath
        {
            get { return FilesHelper.GetFolder(ConfigurationManager.AppSettings["DownloadFolder"], CurrentDirectory); }
        }
    }
}
