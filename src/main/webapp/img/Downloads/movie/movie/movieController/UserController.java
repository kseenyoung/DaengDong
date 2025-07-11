package movie.movieController;

import java.sql.Date;
import java.util.Scanner;

import com.firstzone.dbtest.EmpDTO;
import com.firstzone.dbtest.EmpView;
import com.shinhan.util.DateUtil;

import movie.movieDTO.UserDTO;
import movie.movieService.UserService;
import movie.movieView.UserView;


public class UserController {
	static Scanner sc = new Scanner(System.in);
	static UserService userService = new UserService();
	
	
	
	public static void main(String[] args) {
		
		boolean isStop = false; 
		while(!isStop) {
			menu();
			int job_select = Integer.parseInt(sc.nextLine() );
			switch(job_select) {
			case 1->{ create_user(); }
			case 2->{ 
				String ID = login();
				
				while(ID != null) {
					menu2();
					int job_select2 = Integer.parseInt(sc.nextLine() );
					switch(job_select2) {
						case 1->{ ReserveController.create_reservation(ID);}
						case 2->{ }
						case 9->{ID=null;}
						default->{ System.out.println("작업선택 오류. 다시선택~");}
					}
				}
				
				
			}
			case 9->{isStop=true;}
			default->{ System.out.println("작업선택 오류. 다시선택~");}
			}
		}
		
		
		
		sc.close();
		System.out.println("=======프로그램종료=======");
	}
	
	private static void create_user() {
		// TODO Auto-generated method stub
		int result = userService.insertService( f_makeUser() );
		EmpView.display(result == 1 ? "생성 완료" : "오류 발생");
	}
	
	private static String login() {
		// TODO Auto-generated method stub
		System.out.println();
		System.out.print("ID : ");
		String ID = sc.nextLine();
		System.out.print("passwd : ");
		String passwd = sc.nextLine();
		
		UserDTO result = userService.loginService(ID, passwd);
		UserView.display(result);
		return result == null ? null : result.getID();
	}
	
	
	
	
	
	
	
	
	
	
	private static UserDTO f_makeUser() {
		
		System.out.print("1.ID : ");
		String ID = sc.nextLine();
		
		System.out.print("2.Password : ");
		String Paasword = sc.nextLine();
		

		System.out.print("3.Name : ");
		String Name = sc.nextLine();
		
		
			
		UserDTO s = new UserDTO();
		s.setID(ID);
		s.setPasswd(Paasword);
		s.setName(Name);
	
		
		return s;
	}

	private static void menu() {
		System.out.println("-----------------------");
//		System.out.println("1.회원 가입. 2.로그인 3.수정 4.삭제 5.상세보기 9.종료");
		System.out.println("1.회원 가입. 2.로그인 3.상영 중인 영화 조회");
		System.out.println("-----------------------");
		System.out.println();
		System.out.print("선택해!! : ");

	}
	
	private static void menu2() {
		System.out.println("-----------------------");
		System.out.println("1.예매. 9.뒤로가기");
		System.out.println("-----------------------");
		System.out.println();
		System.out.print("선택해!! : ");

	}
}
