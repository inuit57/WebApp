package mailTest;

import java.util.Random;


public class KeyGenerator {
	private String key ; 
//	long seed = System.currentTimeMillis();
//	Random rand = new Random(seed); 
	
	public KeyGenerator() {
		//생성자를 호출할 경우 
		//키를 생성해준다. 		
		generate(); 
	}
	
	private void generate(){
		key = "";
		int r_num = (int)(Math.random()*3); 

		for(int i =0 ; i<6; i++){
			//System.out.println((int)(Math.random()*3));
			r_num = (int)(Math.random()*3); 
			switch(r_num){
			case 0:
				key+=(char)('a' + (int)(Math.random()*26)); 
				break;
			case 1:
				key+=(char)('A' + (int)(Math.random()*26)); 
				break; 
			case 2:
				key+= (int)(Math.random()*10); 
				break; 
			}
		}
	}
	public static void main(String[] args) {
		KeyGenerator kg = new KeyGenerator(); 
		kg.generate(); 
		System.out.println(kg.getKey());
	}
	// 키를 재발급한다. 
	public void resetKey(){
		generate(); 
	}
	
	//현재 키 값을 받아온다. 
	public String getKey(){
		return key; 
	}
}
