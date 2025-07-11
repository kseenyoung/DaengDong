package com.shinhan.day08;

//Lendable interface : 규칙 checkOut(), checkIn()
//SeparateVolume 구현class : checkOut(){}, checkIn(){}
public class SeparateVolume  implements Lendable  {
    String requestNo;      // 청구번호
    String bookTitle;      // 제목
    String writer;         // 저자
    String borrower;       // 대출인
    String checkOutDate;   // 대출일
    byte state;            // 대출상태
    SeparateVolume(String requestNo, String bookTitle, String writer) {
        this.requestNo = requestNo;
        this.bookTitle = bookTitle;
        this.writer = writer;
    }
    public void checkOut(String borrower, String date) {   // 대출한다
        //이미 대출중이므로 대출불가 
    	if (state != STATE_NORMAL)
            return;
        this.borrower = borrower;
        this.checkOutDate = date;
        this.state = STATE_BORROWED;
        System.out.println("*" + bookTitle + " 이(가) 대출되었습니다.");
        System.out.println("대출인:" + borrower);
        System.out.println("대출일:" + date + "\n");    
    }
    public void checkIn() {   // 반납한다
        this.borrower = null;
        this.checkOutDate = null;
        this.state = STATE_NORMAL;
        System.out.println("*" + bookTitle + " 이(가) 반납되었습니다.\n");
    }
    
}
