package com.shinhan.day08;

//규격서 
public interface RemoteController {
	// 1.상수
	// 2.추상메서드
	public abstract void turnOn();

	void turnOff();

	// 3.default메서드
	default void f1() {

	}

	// 4.static메서드
	static void f2() {

	}

	// 5.private메서드
	private void f3() {

	}

	// 6.private static메서드
	private static void f4() {

	}
}
