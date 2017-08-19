using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Collections;


public class WebHelper
{
    #region Get Themed image Path
    public static string GetBaseThemeImage(System.Web.UI.Page Page)
    {
        return "/App_Themes/" + Page.Theme;
    }

    public static string GetThemeImagePath(System.Web.UI.Page Page)
    {
        return GetBaseThemeImage(Page) + "/Images/";
    }

    public static string GetThemeImage(System.Web.UI.Page Page, string ImageName)
    {
        return GetThemeImagePath(Page) + ImageName;
    }
    #endregion

    #region GetBase Image
    public static string GetBaseImagePath(System.Web.UI.Page Page)
    {
        string them = "/App_Themes/" + Page.Theme.ToString() + "/Images/";
        return them;
    }

    public static string GetBaseImage(System.Web.UI.Page Page, string ImageName)
    {
        return GetBaseImagePath(Page) + ImageName;
    }
    #endregion

    public static string ApplicationPath(HttpRequest request)
    {
        return request.ApplicationPath == "/" ? "" : request.ApplicationPath;
    }

    public static string TemplatePath(HttpRequest request, string fileName)
    {
        return request.PhysicalApplicationPath + "Templates/" + fileName;
    }

    public static string GetCSSFilePath(System.Web.UI.Page page, string cssfileName)
    {
        return "/App_Themes/" + page.Theme.ToString() + "/" + cssfileName;
    }
    public static string GetRootFilePath(string fileName)
    {
        return "/" + fileName;
    }

    public static string GetHeaderImage()
    {
        return ConfigurationManager.AppSettings["HeaderImage"].ToString();
    }

    public static string GetHeaderPath()
    {
        return ConfigurationManager.AppSettings["HeaderPath"].ToString();
    }

    public static string GetDefaultHeader()
    {
        return GetHeaderPath() + ConfigurationManager.AppSettings["HeaderImage"].ToString();
    }

    public static string GetMasterImagePath()
    {
        return ConfigurationManager.AppSettings["MasterImagePath"].ToString();
    }

    public static string GetDefaultMasterImage()
    {
        return GetMasterImagePath() + ConfigurationManager.AppSettings["MasterImage"].ToString();
    }

    public static string GetMasterImage()
    {
        return ConfigurationManager.AppSettings["MasterImage"].ToString();
    }


    /// <summary>
    /// Get Random No, as a Uer-Registration NO.
    /// </summary>
    /// <param name="bytelength"></param>
    /// <returns></returns>
    public static string getRandomKey(int bytelength)
    {
        byte[] buff = new byte[bytelength];
        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
        rng.GetBytes(buff);
        StringBuilder sb = new StringBuilder(bytelength * 2);
        for (int i = 0; i < buff.Length; i++)
            sb.Append(string.Format("{0:X2}", buff[i]));
        return sb.ToString();
    }

    /// <summary>    
    /// </summary>
    /// <returns></returns>

    #region Message
    public static string GetSaveSuccess()
    {
        return ConfigurationSettings.AppSettings["SaveSuccess"].ToString();
    }

    public static string GetSaveFail()
    {
        return ConfigurationSettings.AppSettings["SaveFail"].ToString();
    }

    public static string GetUpdateSuccess()
    {
        return ConfigurationSettings.AppSettings["UpdateSuccess"].ToString();
    }

    public static string GetUpdateFail()
    {
        return ConfigurationSettings.AppSettings["UpdateFail"].ToString();
    }

    public static string GetDeleteSuccess()
    {
        return ConfigurationSettings.AppSettings["DeleteSuccess"].ToString();
    }

    public static string GetDeleteFail()
    {
        return ConfigurationSettings.AppSettings["DeleteFail"].ToString();
    }

    public static string GetRecordNotSelected()
    {
        return ConfigurationSettings.AppSettings["RecordNotSelected"].ToString();
    }

    public static string GetNoPublicHoliday()
    {
        return ConfigurationSettings.AppSettings["NoPublicHoliday"].ToString();
    }

    public static string GetPublishSuccess()
    {
        return ConfigurationSettings.AppSettings["PublishSuccess"].ToString();
    }

    public static string GetPublishFail()
    {
        return ConfigurationSettings.AppSettings["PublishFail"].ToString();
    }

    public static string GetUnpublishSucess()
    {
        return ConfigurationSettings.AppSettings["UnpublishSucess"].ToString();
    }

    public static string GetUnpublishFail()
    {
        return ConfigurationSettings.AppSettings["UnpublishFail"].ToString();
    }

    public static string GetEmailIDChangeSuccess()
    {
        return ConfigurationSettings.AppSettings["EmailIDChangeSuccess"].ToString();
    }

    public static string GetEmailIDChangeSuccessButSendMailFail()
    {
        return ConfigurationSettings.AppSettings["EmailIDChangeSuccessButSendMailFail"].ToString();
    }

    public static string GetEmailIDChangeFail()
    {
        return ConfigurationSettings.AppSettings["EmailIDChangeFail"].ToString();
    }

    public static string GetIPAddress()
    {
        return HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
    }

    public static string GetActivateSuccess()
    {
        return ConfigurationSettings.AppSettings["ActivateSuccess"].ToString();
    }

    public static string GetActivateFail()
    {
        return ConfigurationSettings.AppSettings["ActivateFail"].ToString();
    }

    public static string GetDeactiveSuccess()
    {
        return ConfigurationSettings.AppSettings["DeactiveSuccess"].ToString();
    }

    public static string GetDeactivateFail()
    {
        return ConfigurationSettings.AppSettings["DeactivateFail"].ToString();
    }


    public static string GetPackageActivationSuccess()
    {
        return ConfigurationSettings.AppSettings["PackageActivationSuccess"].ToString();
    }

    public static string GetActivationCodeSendSuccess()
    {
        return ConfigurationSettings.AppSettings["ActivationCodeSendSuccess"].ToString();
    }

    public static string GetActivationCodeSendFail()
    {
        return ConfigurationSettings.AppSettings["ActivationCodeSendFail"].ToString();
    }

    public static string GetPackageSummerySendFail()
    {
        return ConfigurationSettings.AppSettings["PackageSummerySendFail"].ToString();
    }
    public static string GetCommentSuccess()
    {
        return ConfigurationSettings.AppSettings["CommentSuccess"].ToString();
    }
    public static string GetCommentFail()
    {
        return ConfigurationSettings.AppSettings["CommentFail"].ToString();
    }
    public static string GetPostSuccess()
    {
        return ConfigurationSettings.AppSettings["PostSuccess"].ToString();
    }

    public static string GetMessageSuccess()
    {
        return ConfigurationSettings.AppSettings["MessageSuccess"].ToString();
    }
    public static string GetMessageFail()
    {
        return ConfigurationSettings.AppSettings["MessageFail"].ToString();
    }

    public static string GetRecordNotFound()
    {
        return ConfigurationSettings.AppSettings["RecordNotFound"].ToString();
    }

    public static string GetPostFail()
    {
        return ConfigurationSettings.AppSettings["PostFail"].ToString();
    }
    public static string GetStatusChangeFail()
    {
        return ConfigurationSettings.AppSettings["StatusChangeFail"].ToString();
    }
    public static string GetStatusChangeSuccess()
    {
        return ConfigurationSettings.AppSettings["StatusChangeSuccess"].ToString();
    }
    public static string GetCommentDeleteSuccess()
    {
        return ConfigurationSettings.AppSettings["CommentDeleteSuccess"].ToString();
    }
    public static string GetCopySuccess()
    {
        return ConfigurationSettings.AppSettings["CopySuccess"].ToString();
    }
    public static string GetCopyFail()
    {
        return ConfigurationSettings.AppSettings["CopyFail"].ToString();
    }
    public static string GetUserLockSuccess()
    {
        return ConfigurationSettings.AppSettings["UserIsLocked"].ToString();
    }
    public static string GetUserUnLockSuccess()
    {
        return ConfigurationSettings.AppSettings["UserIsUnLocked"].ToString();
    }
    public static string GetUserBlockSccuess()
    {
        return ConfigurationSettings.AppSettings["UserBlockSccuess"].ToString();
    }
    public static string GetUserBlockFail()
    {
        return ConfigurationSettings.AppSettings["UserBlockFail"].ToString();
    }
    public static string GetUserUnBlockSccuess()
    {
        return ConfigurationSettings.AppSettings["UserUnBlockSccuess"].ToString();
    }
    public static string GetUserUnBlockFail()
    {
        return ConfigurationSettings.AppSettings["UserUnBlockFail"].ToString();
    }
    public static string GetPasswordResetFail()
    {
        return ConfigurationSettings.AppSettings["PasswoedResetFail"].ToString();
    }
    public static string GetPasswordResetSuccess()
    {
        return ConfigurationSettings.AppSettings["PasswoedResetSuccess"].ToString();
    }
    public static string GetWebSiteUrl()
    {
        //return "http://localhost:" + HttpContext.Current.Request.Url.Port.ToString();
        // + "/eVidhyapith"
        return ConfigurationSettings.AppSettings["url"].ToString();
    }
    public static long GetUploadingFileMaxSize()
    {
        return Convert.ToInt64(ConfigurationManager.AppSettings["UploadingFileMaxSize"]);
    }
    public static string GetSendMailSuccess()
    {
        return ConfigurationSettings.AppSettings["SendMailSuccess"].ToString();
    }
    public static string GetSendMailFail()
    {
        return ConfigurationSettings.AppSettings["SendMailFail"].ToString();
    }
    public static string GetDraftSaveSuccess()
    {
        return ConfigurationSettings.AppSettings["DraftSaveSuccess"].ToString();
    }
    public static string GetDraftSaveFail()
    {
        return ConfigurationSettings.AppSettings["DraftSaveFail"].ToString();
    }
    public static string GetSaveAndMailSuccess()
    {
        return ConfigurationSettings.AppSettings["SaveAndMailSuccess"].ToString();
    }
    public static string GetSaveButMailFail()
    {
        return ConfigurationSettings.AppSettings["SaveButMailFail"].ToString();
    }

    public static string GetInvalidEmailAddress()
    {
        return ConfigurationSettings.AppSettings["InvalidEmailAddress"].ToString();
    }
    public static string GetNoFileSelected()
    {
        return ConfigurationSettings.AppSettings["NoFileSelected"].ToString();
    }

    public static string GetFolderSizeLarger()
    {
        return ConfigurationSettings.AppSettings["FolderSizeLarger"].ToString();
    }


    #endregion

    public static bool IsPathExist(string stringPath)
    {
        bool status = true;
        if (!Directory.Exists(stringPath))
        {
            try
            {
                Directory.CreateDirectory(stringPath);
            }
            catch
            {
                status = false;
            }
        }
        return status;
    }

    public static string GetLoginUser()
    {
        string userID = "";
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            userID = user.ProviderUserKey.ToString();
        }
        return userID;
    }

    public static string GetLoginUsersRole()
    {
        string roleName = "Guest";
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            if (Roles.IsUserInRole(user.UserName, "SuperAdmin"))
            {
                return "SuperAdmin";
            }
            else if (Roles.IsUserInRole(user.UserName, "Administrator"))
            {
                return "Administrator";
            }
            else if (Roles.IsUserInRole(user.UserName, "Teacher"))
            {
                return "Teacher";
            }
            else if (Roles.IsUserInRole(user.UserName, "Student"))
            {
                return "Student";
            }
            else if (Roles.IsUserInRole(user.UserName, "Parents"))
            {
                return "Parents";
            }
        }
        return roleName;
    }

    public static string GetImageIcon(HttpRequest request, string filename)
    {
        string imageIcon = "";
        if (!filename.Trim().Equals(""))
        {
            string fileExtension = filename.Substring(filename.LastIndexOf('.'));
            fileExtension = fileExtension.Trim();
            if (!fileExtension.Equals(""))
            {
                if (fileExtension.Equals(".doc") || fileExtension.Equals(".docx"))
                    imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/Word.png";
                else if (fileExtension.Equals(".xls") || fileExtension.Equals(".xlsx"))
                    imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/Excel.png";
                else if (fileExtension.Equals(".pdf"))
                    imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/Pdf.jpg";
                else if (fileExtension.Equals(".jpg") || fileExtension.Equals(".jpeg"))
                    imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/image.jpg";
                else
                    imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/Other.png";
            }
        }
        if (imageIcon.Trim().Equals(""))
            imageIcon = WebHelper.ApplicationPath(request) + "/App_Themes/Blue/Document_Icon/Other.png";
        return imageIcon;
    }

    public static bool SendEmail(string toEmail, string toName, string subject, string tBody, int isAttached, string attachment, int isCC, string cc, int isBcc, string bcc)
    {
        string smtpServer = ConfigurationManager.AppSettings["smtpServer"].ToString();
        int smtpPort = Int32.Parse(ConfigurationManager.AppSettings["stmpPort"].ToString());
        int isssl = Int32.Parse(ConfigurationManager.AppSettings["isSSL"].ToString());
        string smtpUserName = ConfigurationManager.AppSettings["fromEmail"].ToString();
        string pwd = ConfigurationManager.AppSettings["password"].ToString();
        string fromEmail = ConfigurationManager.AppSettings["fromEmail"].ToString();
        string fromName = ConfigurationManager.AppSettings["fromName"].ToString();
                
        bool status = false;
        MailMessage message = new MailMessage();
        System.Net.Mail.Attachment att = null;
        System.Net.Mail.SmtpClient cmt = new System.Net.Mail.SmtpClient(smtpServer, smtpPort);

        try
        {
            cmt.Credentials = new System.Net.NetworkCredential(smtpUserName, pwd);
            System.Net.Mail.MailAddress from = new System.Net.Mail.MailAddress(fromEmail, fromName);

            string str1 = "";
            int test = toEmail.LastIndexOf(",");

            if (test > 0)
            {
                str1 = toEmail.Remove(toEmail.LastIndexOf(","));
            }
            else
            {
                str1 = toEmail;
            }

            string[] str = str1.Split(',');

            message.Subject = subject;
            message.From = from;
            int iw = 0;
            while (iw < str.Length)
            {
                message.To.Add(str[iw]);
                iw++;
            }

            message.IsBodyHtml = true;
            message.Body = tBody;

            if (isCC == 1)
            {
                message.CC.Add(cc);
            }
            if (isBcc == 1)
            {
                message.Bcc.Add(bcc);
            }

            if (isAttached > 0)
            {
                att = new System.Net.Mail.Attachment(attachment);
                message.Attachments.Add(att);
            }
            //message.Headers.Add("Disposition-Notification-To", "admin@ravienergie.com");
            if (isssl > 0)
            {
                cmt.EnableSsl = true;
            }
            cmt.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

            cmt.Send(message);

            status = true;
        }
        catch (Exception ex)
        {
            status = false;
        }
        finally
        {
            cmt = null;
            if (att != null)
            {
                att.Dispose();
            }
            message.Dispose();
        }

        return status;
    }

    public static string GetStudentUserName(int instituteID, int studentID)
    {
        return DateTime.Now.Year.ToString() + "VT" + instituteID.ToString() + "S" + studentID.ToString();
    }

    public static string GetTeacherUserName(int instituteID, int teacherID)
    {
        return DateTime.Now.Year.ToString() + "VT" + instituteID.ToString() + "T" + teacherID.ToString();
    }

    public static string GetStudentParentUserName(int instituteID, int parentID)
    {
        return DateTime.Now.Year.ToString() + "VT" + instituteID.ToString() + "P" + parentID.ToString();
    }

    public static int GetImageWidth(string filePath)
    {
        System.Drawing.Image img = System.Drawing.Image.FromFile(filePath);
        return img.Width;
    }

    public static void Redirect(string url, string target, string windowFeatures)
    {
        HttpContext context = HttpContext.Current;

        if ((String.IsNullOrEmpty(target) ||
            target.Equals("_self", StringComparison.OrdinalIgnoreCase)) &&
            String.IsNullOrEmpty(windowFeatures))
        {

            context.Response.Redirect(url);
        }
        else
        {
            Page page = (Page)context.Handler;
            if (page == null)
            {
                throw new InvalidOperationException(
                    "Cannot redirect to new window outside Page context.");
            }
            url = page.ResolveClientUrl(url);

            string script;
            if (!String.IsNullOrEmpty(windowFeatures))
            {
                //script = @"var nWindow=window.open(""{0}"", ""{1}"", ""{2}"");";
                //if(!nWindow || nWindow=='undefine') {

                script = @"nWindow=window.open(""{0}"", ""{1}"", ""{2}"");";// if(!nWindow || nWindow=='undefine') {alert('Please, Unblock Popup...!');}";
                //}
            }
            else
            {
                script = @"nWindow=window.open(""{0}"", ""{1}"");";// if(!nWindow || nWindow=='undefine') {alert('Please, Unblock Popup...!');}";
            }
            //script += "if(!nWindow || nWindow=='undefine'){alert('sorry....!');}";
            script = String.Format(script, url, target, windowFeatures);
            //ScriptManager.RegisterStartupScript(page, typeof(Page), "Redirect", script, true);
            ScriptManager.RegisterClientScriptBlock(page, typeof(Page), "Redirect", script, true);
        }
    }

    public static string GetGoogleDocURL()
    {
        return ConfigurationSettings.AppSettings["goodleDocUrl"].ToString();
    }

    public static void SetCphIndicationVisible(Control currentPage, bool status)
    {
        try
        {
            ((ContentPlaceHolder)(currentPage.Page.Master).FindControl("cphIndication")).Visible = status;
            ((UpdatePanel)(currentPage.Page.Master).FindControl("UpdatePanelCphIndication")).Update();
        }
        catch { }
    }

    /// <summary>
    /// ////// Image Resize and store into database
    /// </summary>    
    /// <returns></returns>

    #region Image Resize
    public enum ResizeOptions
    {
        // Use fixed width & height without keeping the proportions
        ExactWidthAndHeight,

        // Use maximum width (as defined) and keeping the proportions
        MaxWidth,

        // Use maximum height (as defined) and keeping the proportions
        MaxHeight,

        // Use maximum width or height (the biggest) and keeping the proportions
        MaxWidthAndHeight
    }

    public static System.Drawing.Bitmap DoResize(System.Drawing.Bitmap originalImg, int widthInPixels, int heightInPixels)
    {
        System.Drawing.Bitmap bitmap;
        try
        {
            bitmap = new System.Drawing.Bitmap(widthInPixels, heightInPixels);
            using (System.Drawing.Graphics graphic = System.Drawing.Graphics.FromImage(bitmap))
            {
                // Quality properties
                graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                graphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                graphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;

                graphic.DrawImage(originalImg, 0, 0, widthInPixels, heightInPixels);
                return bitmap;
            }
        }
        finally
        {
            if (originalImg != null)
            {
                originalImg.Dispose();
            }
        }
    }

    public static System.Drawing.Bitmap ResizeImage(System.Drawing.Bitmap image, int width, int height, ResizeOptions resizeOptions)
    {
        float f_width;
        float f_height;
        float dim;
        switch (resizeOptions)
        {
            case ResizeOptions.ExactWidthAndHeight:
                return DoResize(image, width, height);

            case ResizeOptions.MaxHeight:
                f_width = image.Width;
                f_height = image.Height;

                if (f_height <= height)
                    return DoResize(image, (int)f_width, (int)f_height);

                dim = f_width / f_height;
                width = (int)((float)(height) * dim);
                return DoResize(image, width, height);

            case ResizeOptions.MaxWidth:
                f_width = image.Width;
                f_height = image.Height;

                if (f_width <= width)
                    return DoResize(image, (int)f_width, (int)f_height);

                dim = f_width / f_height;
                height = (int)((float)(width) / dim);
                return DoResize(image, width, height);

            case ResizeOptions.MaxWidthAndHeight:
                int tmpHeight = height;
                int tmpWidth = width;
                f_width = image.Width;
                f_height = image.Height;

                if (f_width <= width && f_height <= height)
                    return DoResize(image, (int)f_width, (int)f_height);

                dim = f_width / f_height;

                // Check if the width is ok
                if (f_width < width)
                    width = (int)f_width;
                height = (int)((float)(width) / dim);
                // The width is too width
                if (height > tmpHeight)
                {
                    if (f_height < tmpHeight)
                        height = (int)f_height;
                    else
                        height = tmpHeight;
                    width = (int)((float)(height) * dim);
                }
                return DoResize(image, width, height);
            default:
                return image;
        }
    }

    public static byte[] ImageToArray(Bitmap image, ImageFormat format)
    {
        using (MemoryStream mem = new MemoryStream())
        {
            mem.Position = 0;
            image.Save(mem, format);
            return mem.ToArray();
        }
    }

    public static System.Drawing.Image ResizeImage(System.Drawing.Image imgToResize, Size size)
    {
        int sourceWidth = imgToResize.Width;
        int sourceHeight = imgToResize.Height;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)size.Width / (float)sourceWidth);
        nPercentH = ((float)size.Height / (float)sourceHeight);

        if (nPercentH < nPercentW)
            nPercent = nPercentH;
        else
            nPercent = nPercentW;

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        Bitmap b = new Bitmap(destWidth, destHeight);
        Graphics g = Graphics.FromImage((System.Drawing.Image)b);
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;

        g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
        g.Dispose();

        return (System.Drawing.Image)b;
    }
    #endregion

    #region PhotoGallery
    ///////////////////

    public static string GetAlbumCreateSuccess()
    {
        return ConfigurationSettings.AppSettings["AlbumCreateSuccess"].ToString();
    }
    public static string GetAlbumCreateFail()
    {
        return ConfigurationSettings.AppSettings["AlbumCreateFail"].ToString();
    }
    public static string GetAlbumDeleteSucess()
    {
        return ConfigurationSettings.AppSettings["AlbumDeleteSucess"].ToString();
    }
    public static string GetAlbumDeleteFail()
    {
        return ConfigurationSettings.AppSettings["AlbumDeleteFail"].ToString();
    }
    public static string GetPhotoDeleteSucess()
    {
        return ConfigurationSettings.AppSettings["PhotoDeleteSucess"].ToString();
    }
    public static string GetPhotoDeleteFail()
    {
        return ConfigurationSettings.AppSettings["PhotoDeleteFail"].ToString();
    }

    public static string GetAlbumAlreadyExists()
    {
        return ConfigurationSettings.AppSettings["AlbumAlreadyExists"].ToString();
    }

    public static double GetAlbumMaximumSize()
    {
        return double.Parse(ConfigurationSettings.AppSettings["AlbumMaximumSize"].ToString());
    }
    public static double GetMaximumImageSizeAllowForOnlineExam()
    {
        return double.Parse(ConfigurationSettings.AppSettings["MaximumImageSizeAllowForOnlineExam"].ToString());
    }

    public static string GetWebBrowser()
    {
        return HttpContext.Current.Request.Browser.Browser;
    }

    public static string GetWebURL()
    {
        return HttpContext.Current.Request.RawUrl;
    }

    public static double GetDirectorySize(string path)
    {
        double folderLength = 0;
        if (Directory.Exists(path))
        {
            DirectoryInfo dirInfo = new DirectoryInfo(path);
            FileInfo[] aFiles = dirInfo.GetFiles("*.*", SearchOption.AllDirectories);
            for (int i = 0; i < aFiles.Length; i++)
            {
                folderLength += aFiles[i].Length;
            }
        }
        return folderLength;
    }

    public static string SplitString(string strObject, int max1LineLength, bool showExtenstion)
    {
        string strNew = "";
        if (strObject.Length <= (max1LineLength + 3))
        {
            return strObject;
        }
        else
        {
            if (showExtenstion)
            {
                strNew = strObject.Substring(0, max1LineLength) + ".." + Path.GetExtension(strObject);
            }
            else
            {
                strNew = strObject.Substring(0, max1LineLength) + "...";
            }
        }
        return strNew;
    }


    public static string GetDirectorySizeInString(double folderLength)
    {
        string folderSize = "";
        if (folderLength >= 1073741824)
        {
            folderLength = (folderLength / 1073741824); // size in GB
            folderSize = decimal.Round(Convert.ToDecimal(folderLength), 2, MidpointRounding.AwayFromZero).ToString() + " GB.";
        }
        else if (folderLength >= 1048576)
        {

            folderLength = (folderLength / 1048576); // size in MB
            folderSize = decimal.Round(Convert.ToDecimal(folderLength), 2, MidpointRounding.AwayFromZero).ToString() + " MB.";
        }
        else if (folderLength >= 1024)
        {
            folderLength = (folderLength / 1024); // size in KB
            folderSize = decimal.Round(Convert.ToDecimal(folderLength), 2, MidpointRounding.AwayFromZero).ToString() + " KB.";
        }
        else
        {
            //folderLength = folderLength; // size in Bytes which is by default.
            folderSize = decimal.Round(Convert.ToDecimal(folderLength), 2, MidpointRounding.AwayFromZero).ToString() + " Bytes.";
        }
        return folderSize;
    }

    //////////////////

    public static string GetValidFileExtention(int fileType)
    {
        string fileExt = "";
        switch (fileType)
        {
            case 0: // normal document file
                fileExt = ".txt,.rtf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.one";
                break;
            case 1: // document file for document module
                fileExt = ".txt,.rtf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.one,.rar,.zip";
                break;
            case 2: // Image for photo window
                fileExt = ".jpg,.jpeg";
                break;
            case 3: // All Image
                fileExt = ".jpg,.jpeg,.gif,.png";
                break;
            case 4: // for noticeboard module
                fileExt = ".txt,.rtf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.one,.jpg,.jpeg,.gif,.png";
                break;
            case 5: // for eLibrary module
                fileExt = ".pdf";
                break;
        }
        return fileExt;
    }

    #endregion

    #region  DirectoryStrucrure

    public enum DirectoryStrucrureName
    {
        AcademicCalendarFiles = 0,
        AchievementsUpload = 1,
        AdvertisementFileUploaded = 2,
        AssignmentFileUploaded = 3,
        ELibrary = 4,
        EventManager = 5,
        ExamResultFileUploaded = 6,
        FunZoneFiles = 7,
        OnlineDocumentation = 8,
        PhotoGallery = 9,
        TaskFiles = 10
    }

    #endregion

    public static string[] MultipleFileFilter(ref string dir)
    {
        //determine our valid file extensions
        string validExtensions = "*.jpg,*.jpeg,*.gif,*.png";

        //create a string array of our filters by plitting the
        //string of valid filters on the delimiter
        string[] extFilter = validExtensions.Split(new char[] { ',' });

        //ArrayList to hold the files with the certain extensions
        ArrayList files = new ArrayList();

        //DirectoryInfo instance to be used to get the files
        DirectoryInfo dirInfo = new DirectoryInfo(dir);

        //loop through each extension in the filter
        foreach (string extension in extFilter)
        {
            //add all the files that match our valid extensions
            //by using AddRange of the ArrayList
            files.AddRange(dirInfo.GetFiles(extension));
        }

        //convert the ArrayList to a string array
        //of file names
        return (string[])files.ToArray(typeof(string));
    }
}