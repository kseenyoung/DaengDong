package com.shinhan.day08;

//구현class : interface에서 정의한 규격을 따르는 class이다의 의미 
//여러개의 interface를 구현가능 (다중상속과 비숫)
public class MyInterfaceImpl1 implements MyInterface{

	@Override
	public void print1() {
		System.out.println("---추상메서드 구현함----");
		System.out.println("--default메서드 사용가능--");
		print4();
		System.out.println("--static 메서드는 interface소유--");
		MyInterface.print5();
		print5();
	}
	@Override
	public void print4() {
		System.out.println("default메서드 재정의");
	}
	 
	void print5() { 
    	System.out.println("재정의 아님, 함수추가");
    	System.out.println(COMPANY); 
    	System.out.println(COMPANY2); 
    }



	@Override
	public void print2() {
		// TODO Auto-generated method stub
		
	}

}
