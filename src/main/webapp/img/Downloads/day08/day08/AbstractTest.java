package com.shinhan.day08;

public class AbstractTest {

	public static void main(String[] args) {
		f1();

	}

	private static void f1() {
		//추상class는 instance화 불가 
		//MessageSender a = new MessageSender("","");
		
		EMailSender sender1 = 
				new EMailSender("한글날", "aa", "wed0406@daum.net", "휴강~~");
		SMSSender sender2 = 
				new SMSSender("화요일", "bb", "010-1234-5678", "열공");
		send(sender1, "zz@naver.com");
		send(sender2, "010-7894-5612");
		
	}
	//다형성 = 자동형변환 + override
	//사용법은 같고 결과는 다르다. 
	private static void send(MessageSender sender, String recipient) {
		sender.sendMessage(recipient);
	}

}





