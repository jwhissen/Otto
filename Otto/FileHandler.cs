using System;
using System.Web;

namespace Otto
{
    public class FileDownload : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            //Currently only handling .v files
            //Get the filename
            string fileName = context.Request.Path;

            //basic flush and setup
            context.Response.Clear();
            context.Response.ContentType = "application";

            context.Response.TransmitFile(fileName);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

}         
 
