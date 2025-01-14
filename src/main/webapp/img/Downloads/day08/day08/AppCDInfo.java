package com.shinhan.day08;

//상속은 1개만 가능 
//구현은 여러개 가능 
public class AppCDInfo extends CDInfo implements Lendable{
	String borrower;         // 대출인
    String checkOutDate;     // 대출일
    byte state;              // 대출상태
    AppCDInfo(String registerNo, String title) {
        super(registerNo, title);
    }
    public void checkOut(String borrower, String date) {   
        if (state != STATE_NORMAL)
            return;
        this.borrower = borrower;
        this.checkOutDate = date;
        this.state = STATE_BORROWED;
        System.out.println("*" + title + " CD가 대출되었습니다.");
        System.out.println("대출인:" + borrower);
        System.out.println("대출일:" + date + "\n");    
    }
    public void checkIn() { 
        this.borrower = null;
        this.checkOutDate = null;
        this.state = STATE_NORMAL;
        System.out.println("*" + title + " CD가 반납되었습니다.\n");
    }

}
