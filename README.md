
# Daengdong

- 강아지와 함께 떠날 플래너를 작성해보세요!
- 여행 기록을 남기고 추억을 간직하세요
- 특별히 기억하고싶은 기억은 포토카드로!
## Authors
<table>
  <tr>
         <td align="center" width="16%">
            <a href="https://github.com/jamm0316"><img width="75%" src="readme/jm.png"/></a>
            <br />
            <a href="https://github.com/jamm0316">송재명</a>
        </td>
         <td align="center" width="16%">
            <a href="https://github.com/kseenyoung"><img width="75%" src="readme/sy.png"/></a>
            <br />
            <a href="https://github.com/kseenyoung">김신영</a>
        </td>
         <td align="center" width="16%">
            <a href="https://github.com/dmlcksghd"><img width="75%" src="readme/uc.png"/></a>
            <br />
            <a href="https://github.com/dmlcksghd">홍의찬</a>
        </td>
         <td align="center" width="16%">
            <a href="https://github.com/minyoung0302"><img width="75%" src="readme/my.png"/></a>
            <br />
            <a href="https://github.com/minyoung0302">정민영</a>
        </td>
         <td align="center" width="16%">
            <a href="https://github.com/yuseonghun"><img width="75%" src="readme/sh.png"/></a>
            <br />
            <a href="https://github.com/yuseonghun">유성훈</a>
        </td>
         <td align="center" width="16%">
            <a href="https://github.com/boseungdl"><img width="75%" src="readme/sb.png"/></a>
            <br />
            <a href="https://github.com/boseungdl">한승보</a>
        </td>
    </tr>
</table>

## Tech Stack

**Client:** Javascript, HTML, CSS

**Server:** Java, WebSocket, JSP

**Database:** MySQL 
## Archetecture

<img src="readme/Architecture.png" width="75%"/>

## Development Environment


`IDE` Intellij

`JDK` >= 11

`OS` mac, window



## 디렉토리 구조

### java
``` text
├── java
│   └── com
│       └── shinhan
│           └── daengdong
│               ├── chat
│               │   ├── controller
│               │   │   └── ChatController.java
│               │   ├── dto
│               │   │   └── ChatMessageDTO.java
│               │   ├── model
│               │   │   ├── ChatParticipant.java
│               │   │   ├── ChatRoom.java
│               │   │   ├── repository
│               │   │   │   └── ChatRoomRepository.java
│               │   │   └── service
│               │   │       └── ChatService.java
│               │   └── websocket
│               │       ├── ChatWebSocketConfig.java
│               │       ├── ChatWebSocketHandler.java
│               │       ├── HttpSessionInterceptor.java
│               │       ├── SessionInfo.java
│               │       └── WebSocketSessionManager.java
│               ├── home
│               │   └── controller
│               │       └── HomeController.java
│               ├── member
│               │   ├── controller
│               │   │   ├── MemberController.java
│               │   │   ├── MemberRestController.java
│               │   │   └── OauthController.java
│               │   ├── dto
│               │   │   ├── FavoritePlaceDTO.java
│               │   │   ├── FollowDTO.java
│               │   │   ├── ImageDTO.java
│               │   │   ├── LikePostsDTO.java
│               │   │   ├── MemberDTO.java
│               │   │   ├── NotificationDTO.java
│               │   │   ├── PetImageDTO.java
│               │   │   ├── RelationshipsDTO.java
│               │   │   └── SignUpDTO.java
│               │   ├── model
│               │   │   ├── repository
│               │   │   │   ├── MemberRepositoryImpl.java
│               │   │   │   └── MemberRepositoryInterface.java
│               │   │   └── service
│               │   │       ├── GoogleOauthService.java
│               │   │       ├── KakaoOauthService.java
│               │   │       ├── MemberServiceImpl.java
│               │   │       └── MemberServiceInterface.java
│               │   └── vo
│               │       ├── MemberPostsVO.java
│               │       └── MemberVO.java
│               ├── notification
│               │   ├── controller
│               │   ├── dto
│               │   ├── model
│               │   │   ├── repository
│               │   │   └── service
│               │   └── vo
│               ├── pet
│               │   └── dto
│               │       └── PetDTO.java
│               ├── photocard
│               │   ├── controller
│               │   ├── dto
│               │   ├── model
│               │   │   ├── repository
│               │   │   └── service
│               │   └── vo
│               ├── place
│               │   ├── controller
│               │   │   └── PlaceController.java
│               │   ├── dto
│               │   │   ├── FavoriteDTO.java
│               │   │   ├── PlaceDTO.java
│               │   │   ├── PlanPlaceDTO.java
│               │   │   └── RegionDTO.java
│               │   ├── model
│               │   │   ├── repository
│               │   │   │   ├── PlaceRepositoryImpl.java
│               │   │   │   └── PlaceRepositoryInterface.java
│               │   │   └── service
│               │   │       ├── PlaceServiceImpl.java
│               │   │       └── PlaceServiceInterface.java
│               │   └── vo
│               ├── plan
│               │   ├── controller
│               │   │   └── PlanController.java
│               │   ├── dto
│               │   │   ├── MemberPlanDTO.java
│               │   │   ├── PlanDTO.java
│               │   │   ├── PlanDetailsDTO.java
│               │   │   └── PlanRelationshipsDTO.java
│               │   ├── model
│               │   │   ├── repository
│               │   │   │   ├── PlanRepositoryImpl.java
│               │   │   │   └── PlanRepositoryInterface.java
│               │   │   └── service
│               │   │       ├── PlanServiceImpl.java
│               │   │       └── PlanServiceInterface.java
│               │   ├── vo
│               │   │   └── PlanVO.java
│               │   └── websoket
│               │       ├── PlanHandshakeInterceptor.java
│               │       └── PlanWebSocketHandler.java
│               ├── post
│               │   ├── controller
│               │   │   ├── PostController.java
│               │   │   └── PostRestController.java
│               │   ├── dto
│               │   │   ├── CommentDTO.java
│               │   │   ├── LikeDTO.java
│               │   │   ├── PostDTO.java
│               │   │   └── PostIMGDTO.java
│               │   ├── model
│               │   │   ├── repository
│               │   │   │   ├── PostRepositoryImpl.java
│               │   │   │   └── PostRepositoryInterface.java
│               │   │   └── service
│               │   │       ├── PostServiceImpl.java
│               │   │       └── PostServiceInterface.java
│               │   └── vo
│               │       ├── CommentVO.java
│               │       ├── LikeVO.java
│               │       └── PostVO.java
│               ├── review
│               │   └── dto
│               │       └── ReviewDTO.java
│               └── util
│                   ├── JacksonConfig.java
│                   ├── WebSocketConfig.java
│                   └── awsS3
│                       ├── S3Config.java
│                       ├── S3Controller.java
│                       └── S3Service.java
├── resources
│   ├── application.properties
│   ├── daengdong.sql
│   ├── dump.sql
│   ├── keystore.p12
│   ├── log4j.xml
│   └── mybatis
│       ├── mappers
│       │   ├── memberMapper.xml
│       │   ├── placeMapper.xml
│       │   ├── planMapper.xml
│       │   └── postMapper.xml
│       └── sqlMapConfig.xml
```

### webapp
``` text
webapp
 ┣ WEB-INF
 ┃ ┣ views
 ┃ ┃ ┣ common
 ┃ ┃ ┣ member
 ┃ ┃ ┣ photocard
 ┃ ┃ ┣ place
 ┃ ┃ ┣ plan
 ┃ ┃ ┣ post
 ┃ ┃ ┗ home.jsp
 ┃ ┣ root-context.xml
 ┃ ┣ root-contextDB.xml
 ┃ ┣ servlet-context.xml
 ┃ ┗ web.xml
 ┣ img
 ┣ .DS_Store
 ┗ index.jsp

```
## API Reference

### Auth

#### login page

```http
  GET /auth/login.do
```

#### login

```http
  POST /auth/login.do
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `member_id` | `string` | **Required**. Id of member |
| `password`  | `string` | **Required**. password of member |


### Room

#### room page

```http
  GET /room/rooms.do
```

### Chat

#### chat page

```http
  GET /chat/chat.do?chatId
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `chatId` | `int` | **Required**. chatId for enter chat |


## Run Locally

project Clone

```bash
  git clone https://github.com/kseenyoung/DaengDong
```

Move to project directory

```bash
  cd DaengDong
```

Start the server

```bash
  npm run start
```


## Screenshots

<img src="readme/Architecture.png" width="75%"/>
