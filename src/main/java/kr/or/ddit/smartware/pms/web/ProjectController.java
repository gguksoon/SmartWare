package kr.or.ddit.smartware.pms.web;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.ddit.smartware.calendar.model.Category;
import kr.or.ddit.smartware.calendar.service.ICategoryService;
import kr.or.ddit.smartware.employee.service.IDepartmentService;
import kr.or.ddit.smartware.messenger.model.Chat;
import kr.or.ddit.smartware.messenger.service.IMessengerService;
import kr.or.ddit.smartware.pms.model.Project;
import kr.or.ddit.smartware.pms.service.IProjectService;
import kr.or.ddit.smartware.pms.service.ITaskService;

@Controller
public class ProjectController {
	
	@Resource(name="projectService")
	private IProjectService projectService;
	
	@Resource(name="taskService")
	private ITaskService taskService;
	
	@Resource(name="departmentService")
	private IDepartmentService departmentService;
	
	@Resource(name="messengerService")
	private IMessengerService messengerService; 
	
	@Resource(name="categoryService")
	private ICategoryService categoryService;

	@Resource(name="jsonView")
	private View jsonView;
	
	/**
	* Method : pmsView
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @return
	* Method 설명 : pms 메인화면
	*/
	@RequestMapping("pms")
	public String pmsView() {
		
		return "tiles/pms/main";
	}
	
	/**
	* Method : getAllPastProject
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param model
	* @param emp_id
	* @return
	* Method 설명 : 완료된 프로젝트의 상세내용들을 리스트로 반환
	*/
	@RequestMapping("getAllPastProject")
	public View getAllPastProject(Model model, String emp_id) {
		model.addAttribute(projectService.getDetailProject(emp_id, "past"));
		
		return jsonView;
	}
	
	/**
	* Method : getAllRunningProject
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param model
	* @param emp_id
	* @return
	* Method 설명 : 진행중인 프로젝트의 상세내용들을 리스트로 반환
	*/
	@RequestMapping("getAllRunningProject")
	public View getAllRunningProject(Model model, String emp_id) {
		model.addAttribute(projectService.getDetailProject(emp_id, "running"));
		
		return jsonView;
	}
	
	/**
	* Method : getAllDepartEmpList
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param model
	* @return 
	* Method 설명 : 부서리스트와 부서내 사원들의 리스트가 저장된 맵객체를 반환
	*/
	@RequestMapping("getAllDepartEmpList")
	public View getAllDepartEmpList(Model model) {
		// 부서 리스트
		model.addAttribute("departmentList", departmentService.getAllDepartment());
		// key: depart_id, value: List<Employee>
		model.addAttribute("allDepartEmpList", departmentService.getAllDepartEmpList());
		
		return jsonView;
	}
	
	/**
	* Method : insertProject
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param model
	* @param project
	* @return
	* Method 설명 : 프로젝트 추가
	*/
	@PostMapping("insertProject")
	public View insertProject(Model model, String pro_nm, long start, long end, String leader, String member) {
		
		String[] memberArr = member.split(",");
		
		Project project = new Project();
		project.setPro_nm(pro_nm);
		project.setSt_dt(new Date(start));
		project.setEnd_dt(new Date(end));
		
		String pro_id = projectService.insertProject(project, leader, memberArr);
		model.addAttribute("pro_id", pro_id);
		
		// 카테고리 추가(일정의 카테고리)
		Category category = new Category();
		category.setCategory_nm(pro_nm);
		category.setColor("#FC4BFC");
		category.setPro_id(pro_id);
		categoryService.insertCategory(category);
		
		// 챗
		Chat chat = new Chat();
		chat.setChat_nm(pro_nm);
		
		String[] allMemberArr = new String[memberArr.length+1];  
		for(int i=0; i<memberArr.length; i++) {
			allMemberArr[i] = memberArr[i];
		}
		allMemberArr[memberArr.length] = leader;
		
		messengerService.insertChat(chat, allMemberArr);
		
		model.addAttribute("allMemberArr", allMemberArr);
		
		return jsonView;
	}
}
