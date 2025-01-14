package com.shinhan.day08;

//구현class : 여러interface를 구현할 수 있다.(마치 다중상속과 비슷)
public class MyInterfaceImpl2 implements MyInterface{

	//구현class에서 추가된 메서드 
	void display() {
		System.out.println("상수:" + COMPANY + ":" + COMPANY2);
		System.out.println("---default method ----");
		print4();
		System.out.println("---static method ----");
		MyInterface.print5();
	}
	
	@Override
	public void print1() {
		System.out.println("추상메서드 구현....print1");
		
	}

	@Override
	public void print2() {
		System.out.println("추상메서드 구현....print2");
		
	}

}
