package com.shinhan.day08;
public interface Lendable {
	
	//상수 (final static 생략가능)
	final static byte STATE_BORROWED = 1;   // 대출 중
    byte STATE_NORMAL = 0;     // 대출되지 않은 상태

	
	//추상메서드 ...public abstract생략가능 
	public abstract void checkOut(String borrower, String date);
	void checkIn();
}
