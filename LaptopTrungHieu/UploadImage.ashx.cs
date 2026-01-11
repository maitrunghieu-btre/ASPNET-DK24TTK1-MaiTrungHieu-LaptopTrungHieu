using System;
using System.Web;
using System.IO;

namespace Laptop.Admin
{
    public class UploadImage : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile uploads = context.Request.Files["upload"];
            string CKEditorFuncNum = context.Request["CKEditorFuncNum"];
            string file = System.IO.Path.GetFileName(uploads.FileName);

            // Đổi tên file để tránh trùng: ticks + tên file
            string newFileName = DateTime.Now.Ticks.ToString() + "_" + file;

            // Lưu vào thư mục /Images/Products/
            string path = context.Server.MapPath("~/Images/Products/");
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);

            uploads.SaveAs(path + newFileName);

            // Trả về đường dẫn ảnh cho CKEditor hiển thị
            string url = "/Images/Products/" + newFileName;

            context.Response.Write("<script>window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ", \"" + url + "\");</script>");
            context.Response.End();
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}