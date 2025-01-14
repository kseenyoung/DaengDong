package com.shinhan.day08;

public class SMSSender extends MessageSender {
    String returnPhoneNo;
    String message;
    SMSSender(String title, String senderName, 
              String returnPhoneNo, String message) {
        super(title, senderName);
        this.returnPhoneNo = returnPhoneNo;
        this.message = message;
    }
    //@Override
    void sendMessage(String recipient) {
        System.out.println("------------------------------");
        System.out.println("제목: " + title);
        System.out.println("보내는 사람: " + senderName);
        System.out.println("전화번호: " + recipient);
        System.out.println("회신 전화번호: " + returnPhoneNo);
        System.out.println("메시지 내용: " + message);
    }
}