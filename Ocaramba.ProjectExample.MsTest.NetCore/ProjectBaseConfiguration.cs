using System.Configuration;
using System.IO;
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
        /// Gets the Download Folder path
        /// </summary>
        public static string DownloadFolderPath
        {
            get { return FilesHelper.GetFolder(ConfigurationManager.AppSettings["DownloadFolder"], CurrentDirectory); }
        }
    }
}
