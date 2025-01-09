import com.shinhan.daengdong.chat.model.ChatRoom;
import com.shinhan.daengdong.chat.model.service.ChatService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;

import static org.junit.jupiter.api.Assertions.*;

public class ChatServiceTest {

    private ChatService chatService;

    @BeforeEach
    void setUp() {
        chatService = new ChatService();
    }

    @Test
    void testGetChatRoom_createsNewRoomIfNotExist() {
        ChatRoom room1 = chatService.getChatRoom(1);
        assertNotNull(room1);

        ChatRoom room2 = chatService.getChatRoom(1);
        assertSame(room1, room2, "같은 planId로 요청 시, 동일 com.shinhan.daengdong.chat.model.ChatRoom 객체 반환");
    }

    @Test
    void testGetChatRoom_differentPlanIdDifferentRoom() {
        ChatRoom room1 = chatService.getChatRoom(1);
        ChatRoom room2 = chatService.getChatRoom(2);

        assertNotNull(room1);
        assertNotNull(room2);
        assertNotSame(room1, room2, "서로 다른 planId는 다른 chatRoom을 반환해야한다.");
    }
}
