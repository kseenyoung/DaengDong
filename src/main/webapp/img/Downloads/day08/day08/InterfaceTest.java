package com.shinhan.day08;
import java.util.List;
import java.util.Vector;
public class InterfaceTest {
	public static void main(String[] args) {
		f9();
	}
	private static void f9() {
		MyBox a1 = new MyBox();
		Changeable a2 = new MyBox();
		Resizable a3 = new MyBox();
		Colorable a4 = new MyBox();
		
		 
		
	}
	private static void f8(Moveable aa) {
		aa.moveBy(1, 2);
		aa.moveTo(3, 4);
	}
	private static void f7() {
		//구현class type
		TranformImpl a1 = new TranformImpl();
		//구현class가 implement받은 interface
		Transformable a2 = new TranformImpl();
		//구현class가 implement받은 interface의 상위 interface
		Moveable a3 = new TranformImpl();
		//구현class의 부모class
		Object a4 = new TranformImpl();
		
		f8(a1);
		f8(a2);
		f8(a3);
		//f8(a4);
		 
	}
	private static void f6() {
		//인터페이스는 객체생성불가 (Cannot instantiate the type Lendable)
		//Lendable a = new Lendable();
		CDInfo a1 = new AppCDInfo("123","ㅇㅇㅇ");
		AppCDInfo a2 = new AppCDInfo("123","ㅇㅇㅇ");
		Lendable a3 = new AppCDInfo("123","ㅇㅇㅇ");
		Object a4 = new AppCDInfo("123","ㅇㅇㅇ");
		
		
		SeparateVolume b1 = new SeparateVolume("124","자바","신용권");	
		Lendable b2 = new SeparateVolume("124","자바","신용권");	
		Object b3 = new SeparateVolume("124","자바","신용권");	
		
	}
	private static void f5() {
		AppCDInfo a = new AppCDInfo("123","ㅇㅇㅇ");
		SeparateVolume b = new SeparateVolume("124","자바","신용권");		
		action(a, "jin", "2024-10-08");
		action(b, "jin", "2024-10-08");
	}
	private static void action(Lendable a, String name, String dt) {
		a.checkOut(name, dt);
		a.checkIn();
	}
	

	private static void f4() {
		//Collection : List, Set, Map
		//List interface를 구현한 구현class : ArrayList, LinkedList, Vector
		//순서있음, 중복허용
		List<String> a = new Vector<>();
		a.add("월");
		a.add("화");
		a.add("월");
		for(String s:a) {
			System.out.println(s);
		}
		
	}

	private static void f3() {
		RemoteController a = new Audio();
		a.turnOn();
		a.turnOff();
		
		RemoteController2 b = (RemoteController2)a;
		b.turnOn2();
		b.turnOff2();
		
	}

	private static void f2() {
		String s1 = "자바";
		//부모class = 자식객체 
		Object obj1 = s1;
		//interface = 자식객체 
		CharSequence obj2 = s1; 
		
		//Object기능
		System.out.println(obj1.getClass().getName());
		//CharSequence기능...interface에는 실제기능없고 구현class가 구현함 
		System.out.println(obj2.length());
		
	}

	private static void f1() {
		MyInterfaceImpl2 a = new MyInterfaceImpl2();
		MyInterfaceImpl1 b = new MyInterfaceImpl1();
		work(a);
		work(b);
		 
	}
	//자동형변환 : interface = 구현class
	private static void work(MyInterface inter) {
		//강제형변환 : 구현class = (구현class)interface
		if(inter instanceof MyInterfaceImpl2 aa) {
		    aa.display();
		}
		inter.print1();
		inter.print2();
		inter.print4();
	}
	
}
