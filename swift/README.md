# SWIFT SYNTAX
## 기초
    자료형 앞 글자는 대문자
    ex)
    var a:Int

    var 변수, let 상수

    함수 매개변수 값은 상수로 복사되기 때문에 값을 수정할 수 없다
    var parameter = parameter 이런 식으로 변수 복사해서 사용하자


## string
  string은 선언하면 ""로 초기화 해주자
  string의 크기 (괄호 안쓴다)
  ex)
  str.count

  character 하나에 접근하기
  ex)
  var c:Character = str[str.Index(str.startIndex, offsetBy: offset)]

  string 쪼개기
  ex)
  var str =  "Hello Zedd!"
  var arr =  str.components(separatedBy: " ") //sep'a'ratedBy 주의


## for
  파이썬 처럼 스트링이나 배열 순회하기
  ex)
  for c in str {
    print(c)
  }

  시작, 끝, 증가량 정의한 for문
  ex)
  for i in stride(from:start , to:end+1, by:1){
    print(i)
  }


## 배열
  빈 배열 선언
  ex)
  arr : [Int] = []

  여러 크기 배열 선언하기
  ex)
  zeroArray1 = [Int](repeating: 0, count: 10)

  범위 연산자로 추출하기
  이렇게 하면 array slice 타입? 이 되기 때문에 [type](slice) 이런 식으로 캐스팅 해줘야 된다.
  ex)
  arr[0...1]

  내용물 맨 뒤에 추가
  ex)
  arr.append(i)

  내용물 맨 뒤에 제거
  ex)
  arr.popLast()

  원하는 자리에 삽입하기
  ex)
  arr.insert(value, at: 0) #맨 앞에 삽입!

  배열을 원하는 자리에 삽입하기
  ex)
  arr.insert(contentsOf: [1,2], at:0)

  처음 값 끝 값 뽑기
  c++에서 back이나 front 로 구현되어 있는 기능
  옵셔널이라서 !로 부셔줘야 한다.
  ex)
  arr.first
  arr.last

  배열 정렬하기
  ex)
  arr.sorted(by: <) 점점더 커지게, > 점점더 작게 정렬

  배열 내 최대 원소
  ex)
  arr.max()

  튜플 배열 내 최대 원소
  < 가 최대 값이고 옵셔널이라 !로 부셔줘야 한다
  약간 < 방향으로 정렬을 하고 가장 뒤에 값을 취하는 것 같다
  ex)
  var ans = arr.max(by: {$0.1 < $1.1})

  튜플 배열 내 최소 원소
  < 방향으로 정렬을 하고 가장 앞에 값을 취하는 것 같다
  ex)
  var ans = arr.min(by: {$0.1 < $1.1})


## 튜플
  튜플 선언 (이름 지어줄 경우)
  ex)
  var tup:(count:Int, name:String) = (1,"1")

  튜플 선언 (이름 없는 경우)
  ex)
  var tup:(Int, String) = (1,"1")

  튜플 정렬
  $0 이 첫번째, $1이 두번째고 .0이 첫번째 튜플 원소 .1이 두번째 튜플 원소를 가르친다.
  이름을 달고 선언하면 $0.count > $1.count 이런 식으로 더 보기좋게 쓸 수 있다.
  ex)
  var candidate = [(1,a_cnt), (2,b_cnt), (3,c_cnt)] #Int Int 타입
  candidate = candidate.sorted(by: {$0.1 > $1.1})

## dictionary
  c++의 map처럼 key value로 값 관리할 수 있다!
  var dic:[key:value] = [:]

  맵의 결과 값은 옵셔널로 나와서 !로 부셔줘야 한다.
  ex)
  var val = dict[key]!

## 유용한 함수들
  max 함수
  ex)
  var ans = max(first, second)

  print 개행 없이보기
  ex)
  print("hello", terminator:" ")
