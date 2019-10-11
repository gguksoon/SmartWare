package kr.or.ddit.smartware.email.repository;

import java.util.List;
import java.util.Map;

public interface IEmailDao {
	/**
	 * Method : getAddressbookList
	 * 작성자 : PC-18
	 * 변경이력 :
	 * @param depart_id
	 * @return
	 * Method 설명 : 부서에 해당하는 사원들 출력
	 */
	List<Map> getAddressbookList(String depart_id);
	
	/**
	 * Method : getDepartMentList
	 * 작성자 : PC-18
	 * 변경이력 :
	 * @return
	 * Method 설명 : 부서목록 출력
	 */
	List<Map> getDepartMentList();
	
	List<Map> getPositionList();
	
	/**	
	 * Method : getEmpSearchList
	 * 작성자 : PC-18
	 * 변경이력 :
	 * @param keyword
	 * @return
	 * Method 설명 : 사원검색을통한 조회
	 */
	List<Map> getEmpSearchList(String keyword);
	
	/**
	 * Method : getDepSearchList
	 * 작성자 : PC-18
	 * 변경이력 :
	 * @param keyword
	 * @return
	 * Method 설명 : 부서검색을 통한 조회
	 */
	List<Map> getDepSearchList(String keyword);
	

}