package movie.movieController;

import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import movie.movieDTO.MovieDTO;
import movie.movieDTO.ReserveDTO;
import movie.movieDTO.UserDTO;
import movie.movieService.MovieService;
import movie.movieService.ReserveService;

public class ReserveController {
	static MovieService movieService = new MovieService();
	static ReserveService reserveService = new ReserveService();
	static Scanner sc = new Scanner(System.in);
	
	
	public static void create_reservation(String ID) {
		
		ReserveDTO reserveDTO = f_makeReserve(ID);
		
		System.out.print("예매 확정 하시겠습니까?(Y/N) : ");
		String isReserve = sc.nextLine();
		
		if(isReserve.equals("Y")) {
			reserveService.create_reserveService(reserveDTO);
			System.out.println("예약에 성공하셨습니다.");
		}
		
	}
	
	
	

	private static ReserveDTO f_makeReserve(String ID) {
		
		List<MovieDTO>  result = movieService.selectAll_movie();
		System.out.println();
		System.out.println("=============================");
		for (int i = 0; i < result.size(); i++) {
			System.out.println(i+1 + ". " +result.get(i).getTitle() + " " + result.get(i).getStartDate()+ " " + result.get(i).getStartTime());
		}
		
		
		System.out.println("=============================");
		System.out.println();
		System.out.print("■ 영화 선택해 ~ : ");
		MovieDTO myMovie = result.get(Integer.parseInt(sc.nextLine()) - 1);
		System.out.println();

		
//		EmpView.display(result == 1 ? "생성 완료" : "오류 발생");
		System.out.println(myMovie);
        int size = (int) Math.ceil(Math.sqrt(myMovie.getTotalSeat()));  // 정사각형 한 변의 크기 계산
        String[][] array = new String[size][size];            // 2차원 배열 생성

        // 배열에 인덱스+1 값 채우기
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                array[i][j] = i * size + j + 1 >  myMovie.getTotalSeat() ? " " : Integer.toString(i * size + j + 1) ;
            }
        }
        
        
        // 배열 출력
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                // 한 줄에 숫자를 나란히 출력
                System.out.print(array[i][j] + "\t");
            }
            System.out.println(); // 행 단위로 줄 바꿈
        }
        
    	System.out.print("■ 좌석 선택해 ~ : ");
		int mySeat = Integer.parseInt(sc.nextLine());
		
		
			
		ReserveDTO reserveDTO = new ReserveDTO();
		reserveDTO.setID(ID);
		reserveDTO.setScreeningnumber(myMovie.getScreeningnumber());
		reserveDTO.setSeatNumber(mySeat);
		
		return reserveDTO;
	}

	
	
}
