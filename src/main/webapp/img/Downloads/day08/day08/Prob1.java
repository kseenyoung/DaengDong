package com.shinhan.day08;

public class Prob1 {
	public static void main(String[] args) {
		//자동형변환: 부모 = 자식 
		Entry e1=new Directory("tetD");
		e1.print();
		Entry e2=new File("testF",1000);
		e2.print();
		
	}

}
/*
tetD
testF(1000)
*/

///////////////////////////////////////
//abstract class : class안에 추상메서드가 1개이상있음 
//직접 생성은 불가하다.(new  Entry()  불가)
abstract class Entry{
	//1.field
	private String name;
	private int size;
	//2.constructor
	public Entry() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Entry(String name) {
		super();
		this.name = name;
	}
	public Entry(int size) {
		super();
		this.size = size;
	}
	public Entry(String name, int size) {
		super();
		this.name = name;
		this.size = size;
	}
    //3.일반메서드 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	//추상메서드 : 정의는 있고 구현은 없다. 구현은 자식이 한다.(필수) 
	public abstract void print();
	

}
class Directory extends Entry{
	Directory(String name){
		super(name);
	}
	public  void print() {
		System.out.println(getName());
	}
}

class File extends Entry{
	File(String name, int size){
		super(name, size);
	}
	public void print() {
		System.out.println(getName() + "(" + getSize() + ")");
	}
}







