package com.shinhan.day08;


class C extends A{ 
    int meth()  { return 100; } 
    static int sMeth() { return 100; } 
} 

class B  { 
    int meth()  { return 10; } 
    static int sMeth() { return 10; } 
} 

class A extends B{ 
    int meth()  { return 1; } 
    static int sMeth() { return 1; } 
} 
 
public class Inheritance { 
    public static void main(String[] args){ 
        C c = new C(); 
        B b = (B) c; 
        A a = (A) c; 
        
        if( a instanceof A ) {
            System.out.println( "a는 A의 인스턴스 이다.");
        }        
        if( a instanceof B) {
            System.out.println( "a는 B의 인스턴스 이다.");
        }
        if( a instanceof C) {
            System.out.println( "a는 C의 인스턴스 이다.");
        }
        
        System.out.println(a.meth() + " " + b.meth() + " " + c.meth()
                      + A.sMeth() + " " + B.sMeth() + " " + C.sMeth() ); 
    } 
}
