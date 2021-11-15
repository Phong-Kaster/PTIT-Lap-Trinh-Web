package bean;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mailer")

public class Mailer {
	@Autowired
	JavaMailSender mailer;
	
	public String from() {
		return "TimesWriter-noreply";
	}
	
	public String retrievePasswordSubject() {
		return "Thay đổi mật khẩu Times Writer";
	}
	
	public String ReceiveMessage() {
		return "Đăng ký nhận tin Times Writer";
	}
	
	
	public String bodyRP(String hash) { // RESET PASS WORD
		String body = "<body marginheight=\"0\" topmargin=\"0\" marginwidth=\"0\" style=\"margin: 0px; background-color: #f2f3f8;\" leftmargin=\"0\">\r\n" + 
				"    <!--100% body table-->\r\n" + 
				"    <table cellspacing=\"0\" border=\"0\" cellpadding=\"0\" width=\"100%\" bgcolor=\"#f2f3f8\"\r\n" + 
				"        style=\"@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;\">\r\n" + 
				"        <tr>\r\n" + 
				"            <td>\r\n" + 
				"                <table style=\"background-color: #f2f3f8; max-width:670px;  margin:0 auto;\" width=\"100%\" border=\"0\"\r\n" + 
				"                    align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:80px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"text-align:center;\">\r\n" + 
				"                          <a href=\"http://localhost:8080/LTW_NEWS/\" title=\"logo\" target=\"_blank\">\r\n" + 
				"                            <img width=\"100%\" src=\"https://timeswriter.xyz/assets/uploads/1/images/logo/times.png\" title=\"logo\" alt=\"logo\">\r\n" + 
				"                          </a>\r\n" + 
				"                        </td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:20px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td>\r\n" + 
				"                            <table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\"\r\n" + 
				"                                style=\"max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);\">\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"height:40px;\">&nbsp;</td>\r\n" + 
				"                                </tr>\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"padding:0 35px;\">\r\n" + 
				"                                        <h1 style=\"color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;\">Bạn đã\r\n" + 
				"                                            yêu cầu cấp lại mật khẩu</h1>\r\n" + 
				"                                        <span\r\n" + 
				"                                            style=\"display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;\"></span>\r\n" + 
				"                                        <p style=\"color:#455056; font-size:15px;line-height:24px; margin:0;\">\r\n" + 
				"                                            Để khôi phục lại password vui lòng nhấp vào link bên dưới.\r\n" + 
				"                                        </p>\r\n" + 
				"                                        <a href=\"http://localhost:8080/LTW_NEWS/reset-password/hash.htm\"\r\n" + 
				"                                            style=\"background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;\">Reset\r\n" + 
				"                                            Password</a>\r\n" + 
				"                                    </td>\r\n" + 
				"                                </tr>\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"height:40px;\">&nbsp;</td>\r\n" + 
				"                                </tr>\r\n" + 
				"                            </table>\r\n" + 
				"                        </td>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:20px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"text-align:center;\">\r\n" + 
				"                            <p style=\"font-size:14px; color:rgba(69, 80, 86, 0.7411764705882353); line-height:18px; margin:0 0 0;\">&copy; <strong>https://timeswriter.xyz</strong></p>\r\n" + 
				"                        </td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:80px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                </table>\r\n" + 
				"            </td>\r\n" + 
				"        </tr>\r\n" + 
				"    </table>\r\n" + 
				"    <!--/100% body table-->\r\n" + 
				"</body>";
		return body.replace("hash",hash);
	}
	
	public String bodyRM() // RECEIVE MESSAGE
	{
		return "<body marginheight=\"0\" topmargin=\"0\" marginwidth=\"0\" style=\"margin: 0px; background-color: #f2f3f8;\" leftmargin=\"0\">\r\n" + 
				"    <!--100% body table-->\r\n" + 
				"    <table cellspacing=\"0\" border=\"0\" cellpadding=\"0\" width=\"100%\" bgcolor=\"#f2f3f8\"\r\n" + 
				"        style=\"@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;\">\r\n" + 
				"        <tr>\r\n" + 
				"            <td>\r\n" + 
				"                <table style=\"background-color: #f2f3f8; max-width:670px;  margin:0 auto;\" width=\"100%\" border=\"0\"\r\n" + 
				"                    align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:80px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"text-align:center;\">\r\n" + 
				"                          <a href=\"http://localhost:8080/LTW_NEWS/\" title=\"logo\" target=\"_blank\">\r\n" + 
				"                            <img width=\"100%\" src=\"https://timeswriter.xyz/assets/uploads/1/images/logo/times.png\" title=\"logo\" alt=\"logo\">\r\n" + 
				"                          </a>\r\n" + 
				"                        </td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:20px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td>\r\n" + 
				"                            <table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\"\r\n" + 
				"                                style=\"max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);\">\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"height:40px;\">&nbsp;</td>\r\n" + 
				"                                </tr>\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"padding:0 35px;\">\r\n" + 
				"                                        <h1 style=\"color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;\">\r\n" + 
				"                                            Cảm ơn bạn đã đăng ký nhận tin từ Times Writer</h1>\r\n" + 
				"                                        <span\r\n" + 
				"                                            style=\"display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;\"></span>\r\n" + 
				"                                        <p style=\"color:#455056; font-size:15px;line-height:24px; margin:0;\">\r\n" + 
				"                                            Chúng tôi sẽ gửi đến bạn những tin tức mới nhất cho bạn\r\n" + 
				"                                        </p>\r\n" + 
				"                                        <!-- <p\r\n" + 
				"                                            style=\"background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;\">\r\n" + 
				"                                            Chúng tôi sẽ gửi những tin tức mới nhất cho bạn</p> -->\r\n" + 
				"                                    </td>\r\n" + 
				"                                </tr>\r\n" + 
				"                                <tr>\r\n" + 
				"                                    <td style=\"height:40px;\">&nbsp;</td>\r\n" + 
				"                                </tr>\r\n" + 
				"                            </table>\r\n" + 
				"                        </td>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:20px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"text-align:center;\">\r\n" + 
				"                            <p style=\"font-size:14px; color:rgba(69, 80, 86, 0.7411764705882353); line-height:18px; margin:0 0 0;\">&copy; <strong>www.rakeshmandal.com</strong></p>\r\n" + 
				"                        </td>\r\n" + 
				"                    </tr>\r\n" + 
				"                    <tr>\r\n" + 
				"                        <td style=\"height:80px;\">&nbsp;</td>\r\n" + 
				"                    </tr>\r\n" + 
				"                </table>\r\n" + 
				"            </td>\r\n" + 
				"        </tr>\r\n" + 
				"    </table>\r\n" + 
				"    <!--/100% body table-->\r\n" + 
				"</body>";
	}
	
	public void send(String from,String to, String subject,String body)
	{
		try {
			 //Tao mail
            MimeMessage mail = mailer.createMimeMessage();
            //su dung lop tro giup
            MimeMessageHelper helper
            				= new MimeMessageHelper(mail,true,"utf-8");
            helper.setFrom(from, from);
            helper.setTo(to);
            helper.setReplyTo(from, from);
            helper.setSubject(subject);
            helper.setText(body, true);

            // gui mail
            mailer.send(mail);
		}
		catch(Exception ex)
		{
			System.out.println(ex);
			throw new RuntimeException(ex);
		}
		
	}
	
}
