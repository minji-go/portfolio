# :coffee: 테이크아웃 카페 키오스크 

## 1. 제작 기간 & 참여 인원
- 2022.04.25 ~ 2022.05.01,  2022.05.22 ~ 2022.05.27
- 팀 프로젝트 (3명)

## 2. 사용 기술
- Java 11

## 3. ERD 설계
![](https://github.com/Minji-Ko/portfolio/tree/main/%ED%86%A0%EC%9D%B4%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20(%ED%82%A4%EC%98%A4%EC%8A%A4%ED%81%AC)/document/ERD.png)


## 4. 핵심 기능
### 📌  상품 장바구니 기능
- <b>목적</b> 
    - 고객 커스텀 메뉴의 빠른 주문과 일반 주문을 통해 여러 상품을  장바구니에 담고 한번에 결제할 수 있도록 하였습니다.
- <b>기능</b> 
    1. 장바구니 담기 기능
    2. 장바구니에 담은 메뉴 확인 및 삭제
    3. 장바구니에 담긴 메뉴 페이징

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1.  static 메소드를 활용한 장바구니 담기
~~~java
public class CartOrder {

	public static ArrayList<Cart> cart;
	private static int cartMaxSize;
	
	/**
    * @cartMaxSize 카트에 담을 수 있는 최대 메뉴 개수
	 */
	static {
		cart = new ArrayList<Cart>();
		cartMaxSize = 12;
	}
        
    public static boolean addToCart(Cart menu) {
        if (cart.size() < cartMaxSize) {
            cart.add(menu);
            cart.sort((c1, c2) -> 
                        FindData.findMenu(c1.getMenuSeq()).getName()
                        .compareTo(FindData.findMenu(c2.getMenuSeq()).getName()));
            return true;
        } else {
            return false;
        }
    }
}
~~~
- 일반 주문, 빠른 주문 클래스에서 고객이 선택한 메뉴를 addToCart 메소드를 통해 cart라는 ArrayList에 추가한다.
- 메뉴의 이름순으로 정렬한다.

#### 2. 제어문과 boolean을 이용한 장바구니 페이징 및 상품 삭제
~~~java
/**
	 * 장바구니에 담긴 메뉴를 출력하는 메소드 입니다.
	 * @param input 에러 또는 삭제 완료 메시지
	 * @param info 에러 또는 삭제 완료 메시지 출력여부
	 * @return 입력값
	 */
	private String controlCart(String input, boolean info) {
		
		ArrayList<String> pages = loadCartPage();
		int index = 1;
	 
		while(true) {
			
            //1. 해당 페이지 키오스크 화면 출력
			System.out.print(pages.get(index-1));
			System.out.printf("\t\t\t[%d/%d]\n\n", index, pages.size());
			
            //2. 사용자의 이전 입력에 따른 결과 출력
			if(info == true) {
				System.out.println(input);
				info = false;
			} 

			System.out.println("(삭제: 번호 / 결제: Enter / 페이지: < > / 나가기: 0)");
			System.out.println();
			
            //3. 사용자의 입력
			Scanner scan = new Scanner(System.in);
			System.out.print("Select ▶ ");
			input = scan.nextLine();
			
			if(input.equals("<")) {
				if(index > 1) {
					index -= 1;						
				} else {
					info = true;
					input = "⚠️ 첫 페이지입니다.";
				}
				
			} else if (input.equals(">")) {
				if(index < pages.size()) {						
					index += 1;
				} else {
					info = true;
					input = "⚠️ 마지막 페이지입니다.";
				}
				
			} else if (input.equals("0")){
				return input;
				
			} else if (checkNum(input)) {
				Cart temp = cart.remove(Integer.parseInt(input)-1);
				input = "⚠️ " + FindData.findMenu(temp.getMenuSeq()).getName() + "을(를) 삭제하였습니다.";
				return input;
				
			} else if (input.equals("")) {
				return input;
				
			} else {
				info = true;
				input = "⚠️ " + input + "은 올바른 입력이 아닙니다.";
			}
	
			
		}
	}
~~~
-  각 페이지의 출력문은 loadCartPage 메소드에서 StringBuilder를 사용하여 만들고, pages라는 ArrayList에 추가한다. 
- 장바구니의 페이징은 현재페이지와 요청된 페이지의 관계를 따져 해당하는 페이지를 출력한다.
- 상품의 삭제는 호출한 메소드로 돌아갔다가 페이징부터 새로하여 해당 메소드를 다시 돌아온다.
---

</div>
</details> 
<br> 


### 📌  상품 결제 기능 
- <b>목적</b> 
    - 기존 키오스크의 단계별 선택 및 결제의 불편한 점을 보완하기 위해  고객의 선택에 따른 결제 정보를 한 눈에 확인 할 수 있도록 하였습니다.
- <b>기능</b> 
    1. 비회원의 바로 결제 기능
    2. 회원의 적립 또는 할인여부 적용
    3. 현금 계산의 경우 적절한 금액 투입 확인
    4. 결제 완료 처리
    

<details>
<summary><u>구현 코드 확인하기</u></summary>
<div markdown="1">

---
#### 1. 파일 입출력을 통한 장바구니 결제 완료 처리

~~~java
public class Payment {
	/**
	 * 결제완료 후 주문 내역을 저장하고 장바구니를 비우는 메소드입니다.
	 */
	private void afterPay() {

		if(Main.currentLogin != null) {
			
			Stamp st = null;
			
			for(Stamp s : Data.slist) {
				if(Main.currentLogin.getSeq().equals(s.getCumstomerSeq())){ st = s; }
			}
			
			if(stampUser) {
				st.setStamp(Integer.parseInt(st.getStamp()) + CartOrder.cart.size() - 11 + "");
			} else {
				st.setStamp(Integer.parseInt(st.getStamp()) + CartOrder.cart.size() + "");
			}
			
		}
		
		Calendar now = Calendar.getInstance();
		String orderDate = now.get(Calendar.YEAR) + "-" 
						+ (now.get(Calendar.MONTH) + 1) + "-" 
						+ now.get(Calendar.DATE);
		
		for(Cart c : CartOrder.cart) {
			Data.olist.add(new Order(findNextSeq_olist()
										, c.getMenuSeq()
										, orderDate
										, Main.currentLogin==null? "-1" : Main.currentLogin.getSeq()));	
		}
		
		Data.save(DataPath.적립);
		Data.save(DataPath.주문내역);
	
		CartOrder.cart.clear();
		Main.currentLogin = null;
	} 
}
~~~
---

</div>
</details> 
</br>

## 5. 트러블 슈팅 및 그외 기능 구현 경험
<details>
<summary>csv형식의 데이터 파일사용으로 인한 메뉴별 주문개수 파악의 어려움</summary>
<div markdown="1">
- <b>문제점</b>
    - 결제내역 데이터에서 최근 일주일간 가장 많이 주문한 메뉴 5개를 계산하는데 있어, DB를 사용하지 않고 csv형식의 파일 입출력을 사용하다보니 코드량이 많아짐

- <b>기존방법</b>
~~~java
private  void printBestMenu() {
		
        //1. 메뉴 개수만큼 배열의 크기 설정
		int[] menuSeq = new int[Data.mlist.size()];

        //2. 주문 내역을 최신순으로 정렬
		Data.olist.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));

        //3. 최근 일주일의 메뉴별 주문수 파악
        Calendar weekago = Calendar.getInstance();
		weekago.add(Calendar.DATE, -7);
		weekago.set(Calendar.HOUR, 0);
		weekago.set(Calendar.MINUTE, 0);

		for (Order o : Data.olist) {

			if (o.getOrderDate().compareTo(weekago) < 0) { break; }

            menuSeq[Integer.parseInt(o.getMenuSeq()) - 1]++;
		}
}
~~~

- <b>개선방법</b>
~~~java
private void printBestMenu() {

   int[] menuSeq = new int[Data.mlist.size()];

	    for(int i=0; i < Data.mlist.size(); i++) {
	       
            Menu m = Data.mlist.get(i);
		   
            menuSeq[i] = (int)Data.olist.stream()
		                .filter(o -> o.getMenuSeq().equals(m.getSeq()))
		                .count();
		}
}
~~~
- 스트림을 활용하여 가독성 및 성능 향상
 
</div>
</details>

    
<details>
<summary>베스트 메뉴 알아내기</summary>
<div markdown="1">

~~~java

ArrayList<String> best = new ArrayList<String>();

/**
* @menuSeq 메뉴별 주문 수량
* @count 베스트 메뉴 개수
*/
private void findMax(int[] menuSeq, int count) {
    
    int max = 0;

    for (int i = 0; i<menuSeq.length; i++) {

        if (menuSeq[i] > max) {
            max = menuSeq[i];
            best.add(i);
            menuSeq[i] = 0;
        }   
    }
    
    int count--;

    if(count > 0) {
        findMax(menuSeq, count);
    }
}
~~~
- 재귀 호출을 활용하여 베스트 메뉴의 메뉴번호를 반환하였다.
</div>
</details>  

<details>
<summary>데이터 삽입시 pk가 될 다음 번호 구하는 방식은 같은데 저장하는 파일에 따라 코드가 조금씩 달랐음</summary>
<div markdown="1">

- <b>기존코드</b>
~~~java 
private static String findMaxSeq_cmlist() {
      int max = 0;
      
      for(CustomMenu c : Data.cmlist) {
         if(Integer.parseInt(c.getSeq()) > max) { 
            max = Integer.parseInt(c.getSeq());
         }
      }
      return "" + (max + 1);
}

private static String findMaxSeq_cmlist() {
      int max = 0;
      
      for(Customer c : Data.clist) {
         if(Integer.parseInt(c.getSeq()) > max) { 
            max = Integer.parseInt(c.getSeq());
         }
      }
      return "" + (max + 1);
   }
~~~

- <b>개선코드</b>
~~~java
	/**
	 * ArrayList<T>의 기본키 값을 탐색하여 적절한 다음 기본키 값을 반환하는 메소드입니다.
	 * @param arr ArrayList
	 * @return 다음 기본키 값
	 */
	public static String nextSeq(ArrayList<?> arr) {
		
		Stream<String> temp = null;
		
		if (arr == Data.clist) {
			temp = Data.clist.stream().map(s->s.getSeq());
		} else if (arr == Data.slist) {
			temp = Data.slist.stream().map(s->s.getSeq());
		} 

		return "" + (temp.mapToInt(Integer::parseInt).max().getAsInt() + 1);
	}
~~~

</div>
</details>  
    
</br>

## 6. 구현 화면



## 7. 회고 / 느낀점


1. 발생 문제
ArrayList 탐색 중 개수를 세거나 필터링, 정렬 등의 일회성 기능을 사용하는 데 어려움을 느껴 유사한 코드가 계속해서 반복되는 문제가 발생함
> 람다식, 스트림, 파이프 기능 복습 및 사용해 일부 해결
MenuCategory.java와 같이 다른 기능에서 공통으로 사용되는 코드를 사전에 어떤 형식으로 재사용할지 정확히 정하지 않아 공통 코드가 여러번 수정되는 문제가 발생함 
> 추후 프로젝트시 코드 작성 이전에 확실한 공통 코드 형식 의견 공유 
각자 담당한 업무에만 집중하여 그 외 업무코드의 버전 관리가 원활하지 않아서 최종통합시 버전관리의 문제를 코드의 오류로 착각하였음
> 추후 프로젝트시 공통 코드에 대한 업데이트 정보 작성 및 개발자별 업데이트 여부 기록 
프로젝트 기간이 비연속적임에도 불구하고 이전 코드 작성에 대한 기록이 명확하지 않아서 다시 코드를 파악하는데 많은 시간이 소요됨
> 추후 프로젝트시 일정에 맞는 프로젝트 기간설정 및 작성한 코드 흐름에 대한 문서작성
2. 깨달은 점
요구분석서 및 기능명세서 등 문서 작업과 공통 코드 작성의 중요성
형상 관리의 중요성
팀원 간 정확한 의견 전달과 이해, 소통의 중요성
프로젝트 일정 및 상세 계획 수립의 중요성
3. 보완할 점
실제로 프로그램을 납품하기에 부족한 기능
반복되는 코드 등으로 인한 성능 저하 가능성


<b>1. Github를 통한 프로젝트 관리 시 파일 충돌과 코드 취합의 어려움</b>

- 제안: Github을 사용하면 서로의 코드를 쉽게 공유하고 오류가 발생하면  버전을 돌려 복구할 수 있다는 장점때문에 협업툴로써 사용을 제안하였다. 
- 원인: 그러나 협업툴로써 사용해본 경험이 전무하여 Github를 혼자 사용할 때와 비슷할 것이라 예상하여 협업 가이드 등을 충분히 찾아서 읽어보지 못하였다.
- 문제: 결국 Github 컨벤션없이 commit이 이뤄져 버전 관리가 제대로 진행되지 못했으며, 여러 사람이 공통 파일을 동시에 수정함으로 인해 충돌이 복잡하게 발생하여 해결할 수가 없어서 Github 사용을 중단하였다.
- 해결: 이를 해결하기 위해 코드 취합 담당자를 정한 후 zoom의 화면 공유 기능을 통해 다 함께 프로젝트 파일을 비교 정리하여 구글 드라이브를 이용하여 코드 취합을 하였다.


<b>2. 사전 문서 작성과 회의가 부족한 상태로 업무 분담해 팀원 간 소통 오류 발생</b>
- 원인 : 공통으로 공유하는 코드 부분을 여러사람이 같이 작성하면 진행속도가 느리고 일부만이 참여한다고 판단하여 충분한 논의 없이 바로 분담을 하였다.
- 문제 : 같은 데이터를 이해하는 방식이 달랐고, 각자의 이해를 바탕으로 코드를 작성하여 서로 원활하게 데이터 처리가 연결되지 않았으며, 런타임 오류가 발생하여 문제의 원인을 찾는데 한참 걸렸다.
- 해결 : 추가 회의를 통한 팀원 간 코드 공유 및 다른 팀원의 코드를 리뷰함으로써 해결하였으며,  파일입출력과 저장, 여러 데이터의 DTO 등 공통코드를 자발적으로 맡아서 작성하였다.

<b>3. 모바일 애플리케이션과 콘솔의 환경 차이를 고려한 프로그램 설계의 중요성</b>
- 원인 : 실제로 자주사용하는 웹 또는 모바일 어플리케이션에서의 기능과 콘솔에서 구현가능한 동작의 차이를 고려하지 않고 요구 분석서를 작성하였다.
- 문제:  콘솔 화면 내에서 동시 접속이 불가능하고 한번에 한 사람만 기능을 이용할 수 있기 때문에 예약 대기 및 자동 확정 시 알림 등을 구현하는게 불가능하였다.

<b>4. CSV형식의 파일입출력을 사용으로 인한 무결성 검증의 어려움</b>
- 원인:  CSV형식의 파일 입출력은 데이터 이상현상이 발생하여도 즉각적으로 에러가 나지 않는다.
- 문제 : 프로그램 기능 수행 중에 에러가 발생하면 업무 코드의 문제인지 파일 데이터의 무결성 문제인지 알기 위해 많은 시간이 소요되었다.
- 해결: CSV형식의 파일을 엑셀로 변환하여 시각적으로 확인하여 조금 더 발견하기 쉽도록 하였다. 그러나 여전히 프로그램이 검증하는게 아니라 RDBMS의 필요성을 느꼈다.

## 8. 문서 작업 자료
- [기획서](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/1.%20%EA%B8%B0%ED%9A%8D%EC%84%9C.docx)
- [요구분석서](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/2.%20%EC%9A%94%EA%B5%AC%20%EB%B6%84%EC%84%9D%EC%84%9C.docx)
- [순서도](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/3.%20%EC%88%9C%EC%84%9C%EB%8F%84.png)
- [화면설계서](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/4.%20%ED%99%94%EB%A9%B4%EC%84%A4%EA%B3%84%EC%84%9C.pptx)
- [기능명세서](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/5.%20%EA%B8%B0%EB%8A%A5%EB%AA%85%EC%84%B8%EC%84%9C.docx)
- [요악문서](https://github.com/Minji-Ko/portfolio/blob/main/%EC%BD%98%EC%86%94%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8/document/8.%20%EC%9A%94%EC%95%BD%EB%AC%B8%EC%84%9C.pdf)