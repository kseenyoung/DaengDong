import com.shinhan.daengdong.chat.model.ChatParticipant;
import com.shinhan.daengdong.chat.model.ChatRoom;
import com.shinhan.daengdong.member.dto.MemberDTO;
import org.junit.jupiter.api.Test;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;

public class ChatRoomTest {
    MemberDTO evan = MemberDTO.builder()
            .member_email("jamm0316@naver.com")
            .member_name("evan")
            .member_nickname("evany")
            .build();

    MemberDTO sofia = MemberDTO.builder()
            .member_email("sofia0225@naver.com")
            .member_name("sofia")
            .member_nickname("sof")
            .build();
    @Test
    void testCreateChatRoom() {
        ChatRoom chatRoom = new ChatRoom();
        chatRoom.createChatRoomByPlanId(1);
        assertEquals(1, chatRoom.getPlan_id());
    }

    @Test
    void testJoinAndLeaveParticipant() {
        ChatRoom chatRoom = new ChatRoom();
//        ChatParticipant evanChat = new ChatParticipant(evan);
//        ChatParticipant sofiaChat = new ChatParticipant(sofia);
        chatRoom.createChatRoomByPlanId(1);

//        chatRoom.join(evanChat);
//        chatRoom.join(sofiaChat);

        assertEquals(2, chatRoom.countParticipants());

//        chatRoom.leave(sofiaChat);
        assertEquals(1, chatRoom.countParticipants());
    }

    @Test
    void sendMessage() throws IOException {
        ChatRoom chatRoom = new ChatRoom();
        chatRoom.createChatRoomByPlanId(1);
//        ChatParticipant evanChat = new ChatParticipant(evan);
//        ChatParticipant sofiaChat = new ChatParticipant(sofia);

//        chatRoom.join(evanChat);
//        chatRoom.join(sofiaChat);

//        chatRoom.sendMessage(evanChat, "Hello world");

        assertEquals(2, chatRoom.countParticipants());
        assertEquals(1, chatRoom.getMessageHistory().size());
        assertEquals("evany: Hello world", chatRoom.getMessageHistory().get(0));
    }
}
