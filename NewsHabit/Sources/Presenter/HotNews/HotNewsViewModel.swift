//
//  HotNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/22/24.
//

import Combine
import Foundation

class HotNewsViewModel {
    
    enum Input {
        case viewWillAppear
    }
    
    enum Output {
        case updateHotNews
    }
    
    // MARK: - Properties
    
    var cellViewModels = [HotNewsCellViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewWillAppear:
                self?.fetchNewsData()
                self?.output.send(.updateHotNews)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Fetch News Data
    
    func fetchNewsData() {
        let jsonData = Data(dummyData.utf8) // 더미 데이터 문자열을 Data 객체로 변환
        do {
            let decodedData = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            cellViewModels = decodedData.newsResponseDtoList.map {
                HotNewsCellViewModel(newsItem: $0)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    let dummyData = """
{
    "newsResponseDtoList": [
      {
        "title": "이강인 하극상 쇼크, '열애설' 이나은→'팬' 파비앙..연예계 직격탄 [Oh!쎈 이슈]",
        "category": "HOT",
        "naverUrl": "https://entertain.naver.com/read?oid=109&aid=0005021168",
        "imgLink": "https://ssl.pstatic.net/mimgnews/image/origin/109/2024/02/20/5021168.jpg",
        "description": "모든 사람들이 응원하고 사랑했던 축구 선수 이강인의 하극상 논란이 여전히 거세다. 그리고 그 여파는 연예계로도 퍼졌다.프랑스 출신 방송인 파비앙과 활동 재개를 앞둔 이나은이 직격탄을 맞았다. 이강인의 하극상 논란은...1"
      },
      {
        "title": "\\"로코 찍고 얼굴 환해져\\" 전종서, 첫 TV드라마 '웨딩 임파서블'로 보일 새로운 面 [종합]",
        "category": "HOT",
        "naverUrl": "https://entertain.naver.com/read?oid=117&aid=0003807721",
        "imgLink": "https://ssl.pstatic.net/mimgnews/image/origin/117/2024/02/20/3807721.jpg",
        "description": "배우 전종서가 안방극장에 진출했다. 20일 오후 tvN 새 월화드라마 '웨딩 임파서블' 제작발표회가 열린 가운데, 온라인 생중계 됐다. 이 자리에는 권영일 감독, 배우 전..."
      },
      {
        "title": "‘서울탱고’ 故방실이, 17년 뇌경색 투병 끝 별세…가요계 ‘침통’[종합]",
        "category": "HOT",
        "naverUrl": "https://entertain.naver.com/read?oid=241&aid=0003330889",
        "imgLink": "https://mimgnews.pstatic.net/image/origin/241/2024/02/20/3330889.jpg",
        "description": "서울 시스터즈 출신 가수 방실이가 17년여의 뇌경색 투병 끝에 사망했다. 향년 61세. 20일 가요계에 따르면 방실이는 오랜 뇌경색 투병 끝 이날 오전 인천 강화의 한 요양병원에서 세상을 떠났다. 방실이는 2007년..."
      },
        {
            "title": "푸틴, 김정은에 러시아산 승용차 선물…정부 \\"제재위반\\"(종합2보)",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/003/0012382803?sid=100",
            "imgLink": "https://imgnews.pstatic.net/image/003/2024/02/20/NISI20230920_0020043969_web_20230920204805_20240220154805937.jpg?type=w800",
            "description": "변해정 남빛나라 기자 = 정부는 블라디미르 푸틴 러시아 대통령이 김정은 북한 국무위원장에게 러시아산 전용 승용차를 선물한 데 대해 유엔 안전보장이사회(안보리) 대북제재 결의 위반임을 분명히 했다. 통일부 당국자는 2..."
        },
        {
            "title": "[오마이포토] 사상 첫 현직검사 탄핵 심판",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/047/0002422782?sid=102",
            "imgLink": "https://imgnews.pstatic.net/image/047/2024/02/20/0002422782_001_20240220153001115.jpg?type=w800",
            "description": "▲ [오마이포토] 사상 첫 현직검사 탄핵 심판 ⓒ 이정민 서울시 공무원 간첩조작 사건 피해자 유우성씨를 보복기소했다는 이유로 탄핵소추된 안동완 부산지검 2차장검사의 탄핵심판 사건 첫 변론기일이 20일 오후 서울 종로..."
        },
        {
            "title": "이디야커피, 블루 아카이브와 브랜드 콜라보 진행",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/082/0001256430?sid=101",
            "imgLink": "https://imgnews.pstatic.net/image/082/2024/02/20/0001256430_001_20240220151701159.jpg?type=w800",
            "description": "이디야커피는 20일부터 내달 18일까지 4주간 넥슨의 자회사 넥슨게임즈에서 개발한 서브컬처 게임 ‘블루 아카이브’와 브랜드 콜라보를 진행한다고 밝혔다. 이번 협업은 이디야커피 기존 고객은 물론 강력한 팬덤을 구축하고..."
        },
        {
            "title": "이낙연·이준석 결별…제3지대 '빅텐드' 해체",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/087/0001027124?sid=100",
            "imgLink": "https://imgnews.pstatic.net/image/087/2024/02/20/0001027124_001_20240220155902866.jpg?type=w800",
            "description": "개혁신당에서 한 지붕 아래 모였던 이준석 공동대표와 이낙연 공동대표가 11일만에 결별했다. 이낙연 공동대표는 20일 국회에서 기자회견을 열고 \\"다시 새로운미래로 돌아가 당을 재정비하고 선거체제를 신속히 갖추겠다\\"고 ..."
        },
        {
            "title": "차기 축구대표팀 감독 정할 전력강화위원장으로 정해성 선임",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/366/0000971678?sid=004",
            "imgLink": "https://imgnews.pstatic.net/image/366/2024/02/20/0000971678_001_20240220144501366.jpg?type=w800",
            "description": "히딩크 사단 일원으로 2002 한일 월드컵 4강 신화 이바지 차기 대한민국 축구 국가대표팀 사령탐 선임 작업을 주도할 대한축구협회 국가대표전력강화위언장으로 정해성 현 대회위원장이 선임됐다. 전력강화위는 남녀 대표팀과..."
        },
        {
            "title": "홍준표 \\"외국 감독에 놀아나지 말고 국내 감독 시켜야\\"",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/421/0007362809?sid=102",
            "imgLink": "https://imgnews.pstatic.net/image/421/2024/02/20/0007362809_001_20240220154301421.jpg?type=w800",
            "description": "홍준표 대구시장. 뉴스1 ⓒ News1 자료 사진(대구=뉴스1) 남승렬 기자 = 홍준표 대구시장은 20일 \\"한국 축구는 '축구 사대주의'에 젖어서 한물간 외국 감독 데리고 오는 데만 연연한다\\"고 비판했다.홍 시장은 이날 자신의 페이스북에 \\"외국 감독에게 두 번 놀아나지 말고 국내 감독시키는 게 바르지 않겠나\\"라고 반문했다......"
        },
        {
            "title": "강제동원 피해자, 공탁금 6천만원 수령..日 기업 돈 받은 첫 사례",
            "category": "HOT",
            "naverUrl": "https://n.news.naver.com/mnews/article/660/0000055932?sid=102",
            "imgLink": "https://imgnews.pstatic.net/image/660/2024/02/20/0000055932_001_20240220154501766.jpg?type=w800",
            "description": "강제동원 소송에서 최종 승소한 피해자 측이 일본 기업의 공탁금을 수령했습니다. 일본 기업 자금을 받은 첫 사례입니다. 히타치조센 피해자 이 모 씨 측은 20일 서울중앙지법에서 히타치조센이 법원에 공탁한 6천만 원을 ..."
        }
    ]
  }
"""
}
