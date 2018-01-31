# MeCab Web serice
* 한국어를 RESTful API로 이용하여 형태소 분석해 주는 서비스
 - 형태소 분석기 Mecab 을 컨테이너 서비스로 구성
 - 컨테이너 실행 도구 docker-compose로 손쉬운 사용
* server-komecab
    - MeCab를 이용할 수 있는 RESTful 서비스

## 형태소 분석을 위한 컨데이서 서비스 만들기
* container build
```shell-session
$ docker-compose build
```

## 형태소 분석 서비스 실행
* container run
```shell-session
$ docker-compose up -d
```


## 형태소 분석 RESTful API 실행방법
HTTP request
> POST /mecab/v1/parse-ko-dic

request header
> Content-Type: application/json

request body

```
{
  "sentence": 문자열
}
```

### 실행 예시
실행
```shell-session
$ curl -X POST http://localhost:5000/mecab/v1/parse-ko-dic \
       -H "Content-type: application/json" \
       -d '{"sentence": "함수형 프로그래밍"}'  | jq .
```

결과

```
{
  "DICT": "KO-DIC",
  "MESSAGE": "SUCCESS",
  "RESULTS": [
    {
      " ": "*",
      "원형": "*",
      "품사": "NNG",
      "품사-세분류1": "*",
      "품사-세분류2": "F",
      "품사-세분류3": "함수",
      "형태소": "함수",
      "활용구": "*",
      "활용형": "*"
    },
    {
      " ": "*",
      "원형": "*",
      "품사": "XSN",
      "품사-세분류1": "*",
      "품사-세분류2": "T",
      "품사-세분류3": "형",
      "형태소": "형",
      "활용구": "*",
      "활용형": "*"
     },
     {
       " ": "*",
       "원형": "*",
       "품사": "NNG",
       "품사-세분류1": "*",
       "품사-세분류2": "T",
       "품사-세분류3": "프로그래밍",
       "형태소": "프로그래밍",
       "활용구": "*",
       "활용형": "*"
     }
   ],
   "STATUS": 200
}
```

## 형태소 분석 서비스 종료
* container stop
```shell-session
$ docker-compose down
```
