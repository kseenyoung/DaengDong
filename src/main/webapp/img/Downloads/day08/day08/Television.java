package com.shinhan.day08;

public class Television implements RemoteController, RemoteController2{

	@Override
	public void turnOn2() {
		System.out.println(getClass().getSimpleName() + "-turnOn2()-RemoteController2");
		
	}

	@Override
	public void turnOff2() {
		System.out.println(getClass().getSimpleName() + "-turnOff2()-RemoteController2");
		
	}

	@Override
	public void turnOn() {
		System.out.println(getClass().getSimpleName() + "-turnOn()-RemoteController");
		
	}

	@Override
	public void turnOff() {
		System.out.println(getClass().getSimpleName() + "-turnOff()-RemoteController");
		
	}

}
