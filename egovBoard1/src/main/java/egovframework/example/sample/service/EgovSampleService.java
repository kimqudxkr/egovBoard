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
package egovframework.example.sample.service;

import java.util.List;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
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
public interface EgovSampleService {

	//게시글 목록을 받아옴
	List<?> getBoardList() throws Exception;
	
	//공지 게시글 목록을 받아옴
	List<?> getNoticeList() throws Exception;
	
	//메뉴를이용하여 원하는 게시글만 보이도록 받아옴
	List<?> getFilteredBoardList(String menu) throws Exception;
	
	//댓글 목록을 받아옴
	List<?> getReplyList(int idx) throws Exception;
	
	//게시글 작성
	String insertBoard(BoardVO vo) throws Exception;
	
	//댓글 작성
	void insertReply(ReplyVO vo) throws Exception;
	
	//게시글 내용 확인
	BoardVO selectBoard(BoardVO vo) throws Exception;
	
	//게시글 내용 수정
	void updateBoard(BoardVO vo) throws Exception;
	
	//게시글 삭제
	void deleteBoard(BoardVO vo) throws Exception;
	
	//댓글 삭제
	void deleteReply(ReplyVO vo) throws Exception;
	
	//댓글 수정
	void updateReply(ReplyVO vo) throws Exception;
	
	//특정 게시글 선택
	BoardVO selectBoardByIdx(int idx) throws Exception;
	
	//조회수 증가
	void updateCnt(BoardVO vo) throws Exception;
	//=========================================================================
	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectSampleListTotCnt(SampleDefaultVO searchVO);

}
