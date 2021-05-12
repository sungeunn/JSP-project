
package web.mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
 
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.MemberBean;
 
public class MailSend {
    
    public void MailSend(String email) {
    	
        Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.naver.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");
        
        Authenticator auth = new MailAuth();
        
        Session session = Session.getDefaultInstance(prop, auth);
        
        MimeMessage msg = new MimeMessage(session);
    
        try {
            msg.setSentDate(new Date());
            
            msg.setFrom(new InternetAddress("saeun05@naver.com", "allmovie"));
            InternetAddress to = new InternetAddress(email);
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject("회원가입을 축하드립니다.", "UTF-8");            
            msg.setText("안녕하세요. allmovie 입니다. 환영합니다.", "UTF-8");            
            
            Transport.send(msg);
            
        } catch(AddressException ae) {            
            System.out.println("AddressException : " + ae.getMessage());           
        } catch(MessagingException me) {            
            System.out.println("MessagingException : " + me.getMessage());
        } catch(UnsupportedEncodingException ue) {
            System.out.println("UnsupportedEncodingException : " + ue.getMessage());			
        } catch (Exception e) {
			e.printStackTrace();
        }
    }
}