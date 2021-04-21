/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : SampleDAO.java
 * @Description : Sample DAO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Repository("sampleDAO")
public class SampleDAO extends EgovAbstractDAO {
	//게시글 목록을 받아옴
	public List<?> getBoardList() throws Exception {
		return list("sampleDAO.getBoardList");
	}
	
	//공지 게시글 목록을 받아옴
	public List<?> getNoticeList() throws Exception {
		return list("sampleDAO.getNoticeList");
	}
	
	//메뉴를이용하여 원하는 게시글만 보이도록 받아옴
	public List<?> getFilteredBoardList(String menu) throws Exception {
		return list("sampleDAO.getFilteredBoardList", menu);
	}
	
	//댓글 목록을 받아옴
	public List<?> getReplyList(int idx) throws Exception {
		return list("sampleDAO.getReplyList", idx);
	}
	
	//게시글 작성
	public String insertBoard(BoardVO vo) throws Exception {
		return (String) insert("sampleDAO.insertBoard", vo);
	}
	
	//댓글 작성
	public void insertReply(ReplyVO vo) throws Exception {
		insert("sampleDAO.insertReply", vo);
	}
	
	//게시글 내용 확인
	public BoardVO selectBoard(BoardVO vo) throws Exception {
		return (BoardVO) select("sampleDAO.selectBoard", vo);
	}
	
	//게시글 내용 수정
	public void updateBoard(BoardVO vo) throws Exception {
		update("sampleDAO.updateBoard", vo);
	}
	
	//게시글 삭제
	public void deleteBoard(BoardVO vo) throws Exception {
		delete("sampleDAO.deleteBoard", vo);
	}
	
	//댓글 삭제
	public void deleteReply(ReplyVO vo) throws Exception {
		delete("sampleDAO.deleteReply", vo);
	}
	
	//댓글 수정
	public void updateReply(ReplyVO vo) throws Exception {
		delete("sampleDAO.updateReply", vo);
	}
	
	//특정 게시글 선택
	public BoardVO selectBoardByIdx(int idx) throws Exception {
		return (BoardVO) select("sampleDAO.selectBoardByIdx", idx);
	}
	
	//조회수 증가
	public void updateCount(BoardVO vo) throws Exception {
		update("sampleDAO.updateCount", vo);
	}
	//====================================================================
	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map 
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectSampleListTotCnt(SampleDefaultVO searchVO) {
		return (Integer) select("sampleDAO.selectSampleListTotCnt", searchVO);
	}
}
