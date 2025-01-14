package com.shinhan.day08;

//규칙들이 들어있는 규격서 
//상수 + 추상메서드들의 묶음
//생성자없음
//Collection - List(ArrayList, LinkedList, Vector), Set(HashSet, TreeSet), Map 
public interface MyInterface {
	// 1.상수 : static final생략가능 
	static final String COMPANY = "신한DS-1";
	String COMPANY2 = "신한DS-2" ;
	// 2.추상메서드 : public abstract생략가능 
    public abstract void print1();
    void print2();
    //일반메서드는 불가
    //void print3() {  }
    //3.default 메서드
    default void print4() { 
    	System.out.println("구현class에서 공통적으로 사용할 기능(재정의가능)");
    	print6();
    }
    //4.interface 의 method  사용법=> MyInterface.print5()
    static void print5() { 
    	System.out.println("구현class에서 공통적으로 사용할 기능(재정의 불가능)");
    	print7();
    }
    //5.private method : interface내에서만 사용가능 ...default method에서 사용
    private void print6() { 
    	System.out.println("interface내에서만 사용가능 ");
    }
    //6.private method : interface내에서만 사용가능 ....static method에서 사용 
    private static void print7() { 
    	System.out.println("interface내에서만 사용가능 ");
    }
}








