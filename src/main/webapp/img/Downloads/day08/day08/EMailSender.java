package com.shinhan.day08;

public class EMailSender extends MessageSender {
    String senderAddr;
    String emailBody;
    EMailSender(String title, String senderName, 
                String senderAddr, String emailBody) {
        //1)자동은 부모default생성자 호출
    	//super();
    	//2)명시적으로 부모 생성자 호출
    	super(title, senderName);
        this.senderAddr = senderAddr;
        this.emailBody = emailBody;
    }
    void f1() {
    	
    }
    //이름,매개변수,return같고 modifier는 같거나 더 넓어져야한다. 
    //public>protected>생략>private
    //@Override
    public void sendMessage(String recipient) {
        System.out.println("------------------------------");
        System.out.println("제목: " + title);
        System.out.println("보내는 사람: " + senderName + 
                           " " + senderAddr);
        System.out.println("받는 사람: " + recipient);
        System.out.println("내용: " + emailBody);
    }
}

