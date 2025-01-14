package com.shinhan.day08;

//class는 다중상속 불가
//interface는 다중상속 가능 
public interface Changeable extends Resizable, Colorable{
    void setFont(String font);

}
