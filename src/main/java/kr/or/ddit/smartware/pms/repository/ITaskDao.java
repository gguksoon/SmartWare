package kr.or.ddit.smartware.pms.repository;

import java.util.List;
import java.util.Map;

import kr.or.ddit.smartware.pms.model.Task;

public interface ITaskDao {

	/**
	* Method : getWeekTask
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 주간 업무 리스트 반환
	*/
	List<Task> getWeekTask(Map<String, String> map);

	/**
	* Method : getDelayTask
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 지연중인 업무 리스트 반환
	*/
	List<Task> getDelayTask(Map<String, String> map);

	/**
	* Method : getAllProjectTask
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param emp_id
	* @return
	* Method 설명 : 프로젝트의 전체 업무 리스트 반환
	*/
	List<Task> getAllProjectTask(String emp_id);

	/**
	* Method : getEmpProjectTask
	* 작성자 : JO MIN SOO
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 프로젝트의 사원의 업무 리스트 반환
	*/
	List<Task> getEmpProjectTask(Map<String, String> map);

}
