package com.shinhan.day08;

//abstract class : class내에 abstract 메서드가 0개이상 존재한다. 
public abstract class MessageSender {
	//1.field
    String title;
    String senderName;
    //2.constructor
    MessageSender(String title, String senderName) {
        this.title = title;
        this.senderName = senderName;
    }
    //3.method
    void aa() {
    	
    }
    //추상메서드 : 정의는 있고 구현은 없다. 구현은 자식class에서 한다. 
   abstract void sendMessage(String recipient) ;
}

