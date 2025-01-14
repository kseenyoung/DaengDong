package movie.movieDTO;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter@Setter@ToString
public class MovieDTO {
	int Screeningnumber;    
	String startTime ;    
	String endTime;      
	Date startDate ;         
	int TotalSeat ;  
	String ScreeningSpace ;     
	int MovieCode;   
	String Title;
}
