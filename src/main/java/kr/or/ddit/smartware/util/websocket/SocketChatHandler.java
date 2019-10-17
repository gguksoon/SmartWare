package kr.or.ddit.smartware.util.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.smartware.employee.model.Employee;

public class SocketChatHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(SocketChatHandler.class);
	
	@Resource(name = "eventMap")
	private Map<String, WebSocketSession> sessionMap;	// 소켓에 연결된 세션정보

	private Map<String, WebSocketSession> chatMap;
	
	public SocketChatHandler() {
		chatMap = new HashMap<String, WebSocketSession>();
	}

	// 클라이언트가 웹소켓에 접속하여 연결이 맺어진 후에 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Employee employee = getEmployee(session);
		
		chatMap.put(employee.getEmp_id(), session);
		logger.debug("채팅 접속 : {}", employee.getEmp_id());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Employee employee = getEmployee(session);
		logger.debug("메세지전송 = {} : {}", employee, message.getPayload());
		
		//채팅메시지 : str[0]type, str[1]메시지, str[2]chat_id, str[3]msg_id, str[4...]채팅방 인원 정보
		String[] str = message.getPayload().split(":");
		String type = str[0];
		
		// 메시지전송에 대한 send 이벤트
		if(type.equals("msg")) {
			for(int i=0; i<str.length; i++) {
				String chat_id = str[2];
				if(chatMap.get(str[i])!=null && i>3) {
					WebSocketSession webSession = chatMap.get(str[i]);
					Employee employeee = getEmployee(webSession);
					
//					logger.debug("c_use {}", webSession.getAttributes().get("C_USE"));
					logger.debug("c_use {}", employeee.getC_use());
					if(employeee.getC_use().equals("true") && employeee.getChat_id().equals(chat_id)) {
						webSession.sendMessage(new TextMessage(type + ":" + employee.getEmp_id() + ":" + str[1] + ":" + str[2] + ":" + str[3]));
					}else if(employeee.getC_use().equals("false")) {
						webSession.sendMessage(new TextMessage(type + ":" + employee.getEmp_id() + ":" + str[1] + ":" + str[2] + ":" + str[3]));
					}
				}
			}
		}
		
		for (WebSocketSession currentSession : chatMap.values()) {
			Employee employeee = getEmployee(currentSession);
			if(employeee.getC_use().equals("true") && type.equals("close")) {
				currentSession.sendMessage(new TextMessage(type + ":" + employee.getEmp_nm()));
			}else if(employeee.getC_use().equals("true") && type.equals("invite")) {
				String employees = "";
				for(int i=0; i<str.length; i++) {
					if(!str[i].equals("invite")) {
						employees += str[i];
						if(i!=str.length-1) {
							employees += ", ";
						}
					}
				}
				currentSession.sendMessage(new TextMessage(type + ":" + employees));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			Employee employee = getEmployee(session);
				
//			chatMap.remove(employee.getEmp_id());
			
			logger.debug("연결 끊김 : {}", employee);
	}
		
	//webSocketSession으로부터 userId 정보 조회
		private Employee getEmployee(WebSocketSession session) {
			return ((Employee) session.getAttributes().get("S_EMPLOYEE"));
		}
		
		// 서버측에서 모든 websocket session으로 보내는 메세지
		public void serverToClient() throws IOException {
			for(WebSocketSession wSession : sessionMap.values())
				wSession.sendMessage(new TextMessage("서버 전송 메세지"));				
		}
	}

