import com.shinhan.daengdong.chat.model.service.ChatService;
import com.shinhan.daengdong.chat.websocket.ChatWebSocketHandler;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

public class ChatWebSocketHandlerTest{

    private ChatWebSocketHandler handler;
    private ChatService mockService;

    @BeforeEach
    void setUp() {
        mockService = Mockito.mock(ChatService.class);
//        handler = new ChatWebSocketHandler(mockService);
    }

    @Test
    void testHandleTextMessage() throws Exception {
        WebSocketSession session = Mockito.mock(WebSocketSession.class);
        TextMessage message = new TextMessage("Hello from client");

//        handler.handleTextMessage(session, message);
    }

}
