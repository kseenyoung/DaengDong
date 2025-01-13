package com.shinhan.daengdong.plan.controller;

import com.shinhan.daengdong.member.dto.MemberDTO;
import com.shinhan.daengdong.plan.dto.MemberPlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDTO;
import com.shinhan.daengdong.plan.dto.PlanDetailsDTO;
import com.shinhan.daengdong.plan.dto.PlanRelationshipsDTO;
import com.shinhan.daengdong.plan.model.service.PlanServiceInterface;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@CrossOrigin(origins = "*") // 모든 도메인 허용
@RequestMapping("/plan")
public class PlanController {

    @Autowired
    private PlanServiceInterface planService;

    // 플랜 생성 페이지
    @GetMapping("/create")
    public String createPlanForm(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession(false);

            MemberDTO member = (MemberDTO) session.getAttribute("member");
            model.addAttribute("member", member);
            return "plan/createPlan";
        } catch (IllegalStateException e) {
            log.info(e.getMessage());
            return "redirect:/auth/login.do";
        }
    }

    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<Map<String, String>> createPlan(@RequestBody PlanDTO planDTO, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        planDTO.setMemberEmail(member.getMember_email()); // 세션 이메일 할당

        long days = ChronoUnit.DAYS.between(
                planDTO.getStartDate().toLocalDate(),
                planDTO.getEndDate().toLocalDate()
        ) + 1;

        log.info("총 여행 일수: {}", days);

        Long planId = planService.savePlan(planDTO); // DB INSERT
        log.info("!생성된 plan_id: {}", planId);

        session.setAttribute("currentPlanId", planId);
        log.info("create에서 currentPlanId: {}", session.getAttribute("currentPlanId"));
        session.setAttribute("currentMemberEmail", member.getMember_email());
        log.info("create에서 currentMemberEmail: {}", member.getMember_email());
        session.setAttribute("travelDays", days);
        session.setAttribute("currentPlan", planDTO);

        // 리디렉션 URL을 JSON으로 반환
        Map<String, String> response = new HashMap<>();
        response.put("redirectUrl", "/daengdong/plan/place?planId=" + planId);
        return ResponseEntity.ok(response);
    }


    @GetMapping("/myPlace")
    public String getMyPlace(HttpServletRequest request, Model model) {
        try {
            HttpSession session = request.getSession(false);

            MemberDTO member = (MemberDTO) session.getAttribute("member");

            String memberEmail = member.getMember_email();
            List<PlanDTO> userPlans = planService.getPlansByEmail(memberEmail);

            model.addAttribute("plans", userPlans);

            return "plan/myPlace";
        } catch (Exception e) {
            log.info(e.getMessage());
            return "redirect:/auth/login.do";
        }
    }

    @PostMapping("/myPlace")
    public String postMyPlace(@RequestBody PlanDTO planDTO, Model model) {

        return "plan/myPlace";
    }


    // @GetMapping("/myPlace")
    // public String getMyPlace(Model model) {
    //     List<PlanDTO> publicPlans = planService.getPublicPlan();
    //     for (PlanDTO plan : publicPlans) log.info("Plan ID: {}, Plan Name: {}", plan.getPlanId(), plan.getPlanName());
    //     model.addAttribute("plans", publicPlans);
    //
    //     return "plan/myPlace"; // myPlace.jsp 반환
    // }

    // newPlan.jsp / WBS - 새로운 프로젝트 생성 기능
    @GetMapping("/newPlan")
    public String newPlanForm() {
        return "plan/newPlan";
    }

    // 여행 프로젝트 제목 수정 기능
    @PostMapping("/planName")
    public String planName(@ModelAttribute PlanDTO planDTO) {
        log.info("여행 제목 수정 요청 데이터: {}", planDTO);
        planService.planName(planDTO);
        return "redirect:/plan/myPlace";
    }

    // 여행 날짜 변경 기능
    @PostMapping("/planDate")
    public String planDate(@ModelAttribute PlanDTO planDTO) {
        log.info("여행 기간 수정 요청 데이터: {}", planDTO);
        planService.planDate(planDTO);
        return "redirect:/plan/myPlace";
    }

    // 여행 공개 여부 상태 변경 기능
    @PostMapping("/planState")
    @ResponseBody
    public ResponseEntity<?> updatePlanState(@RequestBody PlanDTO planDTO) {
        try {
            planService.planState(planDTO);
            return ResponseEntity.ok("플랜 상태가 성공적으로 변경되었습니다.");
        } catch (Exception e) {
            log.error("플랜 상태 변경 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("플랜 상태 변경 실패");
        }
    }

    @GetMapping("/place")
    public String searchPlaceForm(
            @RequestParam(value = "planId", required = false) Long planId,
            HttpServletRequest request,
            Model model
    ) {
        HttpSession session = request.getSession(false);

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        //session.setAttribute("currentMemberEmail", member.getMember_email());
        //log.info("ccc currentMemberEmail: {}", member.getMember_email());
        model.addAttribute("memberEmail", member.getMember_email());

        if (planId != null) {
            session.setAttribute("currentPlanId", planId);
            log.info("URL 파라미터로 전달된 planId={} 을 세션에 저장했습니다.", planId);
        } else {
            log.info("이게 나오면 안됨");
            planId = (Long) session.getAttribute("currentPlanId");
            log.info("이게 나오면 안됨: {}", planId);
            if (planId == null) {
                log.error("Plan ID가 세션과 URL 모두에서 확인되지 않았습니다.");
                return "redirect:/plan/error"; // 적절한 에러 처리 페이지로 리디렉션
            }
        }
        log.info("최종 사용될 planId: {}", planId);

        Long currentPlanId = (Long) session.getAttribute("currentPlanId");
        String currentMemberEmail = (String) session.getAttribute("currentMemberEmail");

        log.info("pp에서의 currentMemberEmail: {}", currentMemberEmail);

        // 로그인한 사용자의 이메일을 자동으로 추가
        if (currentPlanId != null && currentMemberEmail != null) {
            if (!planService.isCompanionExists(currentPlanId, currentMemberEmail)) {
                MemberPlanDTO currentUserPlan = new MemberPlanDTO();
                currentUserPlan.setPlanId(currentPlanId);
                currentUserPlan.setMemberEmail(currentMemberEmail);
                planService.addCompanionToPlan(currentUserPlan);
                log.info("로그인한 사용자가 자동으로 추가되었습니다: {}", currentMemberEmail);
            }
        }

        return "place/searchPlace"; // searchPlace.jsp
    }

    @PostMapping("/addCompanion")
    public ResponseEntity<?> addCompanion(@RequestBody String companionEmail, HttpSession session) {

        // 세션에서 planId와 memberEmail 가져오기
        Long currentPlanId = (Long) session.getAttribute("currentPlanId");
        String currentMemberEmail = (String) session.getAttribute("currentMemberEmail");

        // 세션 값 로그로 출력
        log.info("currentPlanId: {}", currentPlanId);
        log.info("currentMemberEmail: {}", currentMemberEmail);

        if (!planService.isCompanionExists(currentPlanId, currentMemberEmail)) {
            MemberPlanDTO currentUserPlan = new MemberPlanDTO();
            currentUserPlan.setPlanId(currentPlanId);
            currentUserPlan.setMemberEmail(currentMemberEmail);
            planService.addCompanionToPlan(currentUserPlan);
        }

        // 쉼표로 구분된 동행자 이메일 문자열을 리스트로 변환
        List<String> companionEmailList = Arrays.asList(companionEmail.split(","));


        // 동행자 추가 처리
        for (String email : companionEmailList) {
            String trimmedEmail = email.trim();

            if (!trimmedEmail.isEmpty() && !trimmedEmail.equals(currentMemberEmail)) {
                if (planService.isMemberExists(trimmedEmail)) {
                    if (!planService.isCompanionExists(currentPlanId, trimmedEmail)) {
                        MemberPlanDTO companionPlan = new MemberPlanDTO();
                        companionPlan.setPlanId(currentPlanId);
                        companionPlan.setMemberEmail(trimmedEmail);
                        planService.addCompanionToPlan(companionPlan);
                        log.info("추가된 동행자 이메일: {}", trimmedEmail);
                    }
                }
            }
        }

        String message = "동행자가 추가되었습니다.";
        //PlanWebSocketHandler.sendMessageToUsers(currentPlanId.toString(), message);

        return ResponseEntity.ok("동행자가 성공적으로 추가되었습니다.");
    }

    @GetMapping("/followingList")
    @ResponseBody
    public ResponseEntity<?> getFollowingList(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            log.warn("로그인이 되어 있지 않습니다. 세션이 null입니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        log.info("현재 로그인된 사용자: {}", member.getMember_email());

        List<PlanRelationshipsDTO> followingList = planService.getFollowingList(member.getMember_email());
        log.debug("조회된 팔로잉 목록: {}", followingList);

        log.info("팔로잉 목록 조회 성공: {}명", followingList.size());
        return ResponseEntity.ok(followingList);
    }

    @GetMapping("/followerList")
    @ResponseBody
    public ResponseEntity<?> getFollowerList(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        List<PlanRelationshipsDTO> followerList = planService.getFollowerList(member.getMember_email());
        log.debug("조회된 팔로워 목록: {}", followerList);

        log.info("팔로워 목록 조회 성공: {}명", followerList.size());
        return ResponseEntity.ok(followerList);
    }

    // 동행자 리스트 조회
    @GetMapping("/companions")
    @ResponseBody
    public ResponseEntity<?> getCompanions(HttpSession session) {
        Long currentPlanId = (Long) session.getAttribute("currentPlanId"); // 수정됨
        if (currentPlanId == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("플랜 정보가 세션에 존재하지 않습니다.");
        }

        List<MemberPlanDTO> companions = planService.getCompanionsByPlanId(currentPlanId);
        return ResponseEntity.ok(companions);
    }

    // 동행자 삭제
    @GetMapping("/companionsDelete")
    @ResponseBody
    public ResponseEntity<?> deleteCompanion(@RequestParam String memberEmail, HttpSession session) {
        Long currentPlanId = (Long) session.getAttribute("currentPlanId");

        if (memberEmail == null || memberEmail.trim().isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("유효하지 않은 이메일입니다.");
        }

        String currentMemberEmail = (String) session.getAttribute("currentMemberEmail");
        if (currentMemberEmail.equals(memberEmail)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("현재 사용자는 삭제할 수 없습니다.");
        }

        MemberPlanDTO memberPlanDTO = new MemberPlanDTO();
        memberPlanDTO.setPlanId(currentPlanId);
        memberPlanDTO.setMemberEmail(memberEmail.trim());

        // DTO 전달
        planService.deleteCompanionFromPlan(memberPlanDTO);

        return ResponseEntity.ok("동행자가 성공적으로 삭제되었습니다.");
    }

    @GetMapping("viewChatRoom.do")
    public String viewChatRoom() {
        return "chat/chatFragment";
    }

    // 플랜 상세 조회 (플랜 및 장소 정보)
    @GetMapping("/details")
    @ResponseBody
    public ResponseEntity<?> getPlanDetails(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);

            MemberDTO member = (MemberDTO) session.getAttribute("member");
            if (member == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }
            String memberEmail = member.getMember_email();

            List<PlanDetailsDTO> planDetails = planService.getPlanDetailsByEmail(memberEmail);
            if (planDetails.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body("조회된 플랜 정보가 없습니다.");
            }

            Map<String, Object> response = new HashMap<>();
            response.put("status", 200);
            response.put("message", "Success");
            response.put("data", planDetails);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("플랜 상세 조회 중 오류 발생: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("플랜 상세 조회 실패");
        }
    }

    @GetMapping("/detailsByPlanId")
    public ResponseEntity<?> getPlanInfo(@RequestParam("planId") Long planId) {

        // (1) 플랜 기본정보 조회
        PlanDTO planDTO = planService.findPlanById(planId);
        if (planDTO == null) {
            return ResponseEntity.badRequest().body("유효하지 않은 planId");
        }

        // (2) 일수 계산 (startDate, endDate가 존재한다고 가정)
        Date start = planDTO.getStartDate();
        Date end = planDTO.getEndDate();
        long days = ChronoUnit.DAYS.between(start.toLocalDate(), end.toLocalDate()) + 1;
        int travelDays = (int) days;

        // (3) dayPlans: plan_places 테이블에 저장된 (day, kakaoPlaceId, etc.)를 조회
        //    -> 아래처럼 PlanService에 "findPlanPlaces(planId)" 메서드를 만든다고 가정
        List<PlanDetailsDTO> placeList = planService.findPlanPlacesByPlanId(planId);
        // placeList 안에 { day=1, kakaoPlaceName=..., ... } 정보가 담겼다고 가정.

        // 이 데이터를 {1: [...], 2: [...]} 이런 식으로 변환
        Map<Integer, Object[]> dayPlans = new HashMap<>();
        for (PlanDetailsDTO pd : placeList) {
            int dayIndex = pd.getDay(); // 예: 1,2,3
            // dayPlans.computeIfAbsent(dayIndex, k-> new ArrayList<Map<String,Object>>());
            // 변환 로직... (아래는 간단히 예시)
        }

        // (4) 동행자 목록 (companions)
        planService.getCompanionsByPlanId(planId);
        // 예: List<MemberPlanDTO>
        // 변환해서  [{email:..., nickname:...}, ...] 식으로 리턴
        // (nickname이 없으면 email만)

        // 예시 (간단화):
        List<MemberPlanDTO> companions = planService.getCompanionsByPlanId(planId);
        System.out.println("placeList: " + placeList);

        // (5) 최종 JSON 응답
        Map<String, Object> result = new HashMap<>();
        result.put("travelDays", travelDays);
        result.put("dayPlans", dayPlans);
        result.put("companions", companions);
        result.put("planTitle", planDTO.getPlanName());
        result.put("placeList", placeList);

        return ResponseEntity.ok(result);
    }

}