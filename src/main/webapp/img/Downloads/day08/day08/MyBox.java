package com.shinhan.day08;

//구현class
public class MyBox implements Changeable{

	void f1() {
		
	}
	
	@Override
	public void resize(int width, int height) {
		System.out.println("---resize");
		
	}

	@Override
	public void setForeground(String color) {
		System.out.println("---setForeground");
		
	}

	@Override
	public void setBackground(String color) {
		System.out.println("---setBackground");
		
	}

	@Override
	public void setFont(String font) {
		System.out.println("---setFont");
		
	}

}
