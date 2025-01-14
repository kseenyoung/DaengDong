package com.shinhan.day08;

public class TranformImpl extends Object implements Transformable{
    void f1() {
    	
    }
	@Override
	public void moveTo(int x, int y) {
		System.out.println("moveTo....x=" + x + " y=" + y);
		
	}

	@Override
	public void moveBy(int xOffset, int yOffset) {
		System.out.println("moveBy....xOffset=" + xOffset + " yOffset=" + yOffset);
		
	}

	@Override
	public void resize(int width, int height) {
		System.out.println("resize=> width="+width + " height="+height);
		
	}

}
