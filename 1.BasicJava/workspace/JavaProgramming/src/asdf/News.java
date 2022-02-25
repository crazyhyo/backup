package asdf;

public class News {
	String[] badNews = {"[트위터]\n엘란 마스크, 암호화폐 이용 결재중단"
			,"[해외소식]\n중국 암호화폐 채굴 규제안 발표"
			,"[국내소식]\n한은 금리인상안 확정, 과열된 코인시장 견제하나"
	};
	String[] normalNews = {
			"[공익광고]\n가짜뉴스 만연, 허위/조작보도 믿지 말아야"
			,"[국내소식]\n경제전문가 코인 도박아냐 신중한 결정 내려야"
			,"[전면광고]\n(빚투캐피탈)신용등급 관계없이 누구나 대출 가능"
	};
	String[] goodNews = {
			"[트위터]\n엘란 마스크: \"Doge To the Moon\" 암호화폐가 달러 대체할 것"
			,"[기술칼럼]\n성장하는 블록체인, 암호화폐 신뢰할 수 있어"
			,"[국내소식]\n나도 한번 해볼까? 직장인 A씨 암호화폐로 1200% 수익 거두고 사표 제출"
	};
	boolean accessNews = true;
	
	String pickNews(double sumRatio) {
		int random = (int) (Math.random() * normalNews.length);
		double probability = Math.random();
		accessNews = false;
		System.out.println();
		if(probability < 0.2) {
			return normalNews[random];
			
		}else if(probability < 0.8) {
			if(sumRatio > 0) {
				return goodNews[random];
			}else {
				return badNews[random];
			}
		}else{
			if(sumRatio < 0) {
				return goodNews[random];
			}else {
				return badNews[random];
			}
		}
	}
}
