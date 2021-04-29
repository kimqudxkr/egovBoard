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

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.LoginVO;
import egovframework.example.sample.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
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

@Service("sampleService")
public class EgovSampleServiceImpl extends EgovAbstractServiceImpl implements EgovSampleService {
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSampleServiceImpl.class);

	/** SampleDAO */
	// TODO ibatis 사용
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	// TODO mybatis 사용
	//  @Resource(name="sampleMapper")
	//	private SampleMapper sampleDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	//게시글 목록을 받아옴
	@Override
	public List<?> getBoardList(BoardVO vo) throws Exception {
		return sampleDAO.getBoardList(vo);
	}
	
	//검색 게시글 목록을 받아옴
	@Override
	public List<?> getBoardListBySearch(BoardVO vo) throws Exception {
		return sampleDAO.getBoardListBySearch(vo);
	}
	
	//공지가 아닌 게시글 갯수를 받아옴
	public Integer getNonNoticeBoardCnt(BoardVO vo) throws Exception {
		return sampleDAO.getNonNoticeBoardCnt(vo);
	}
	
	//공지 게시글 목록을 받아옴
	@Override
	public List<?> getNoticeList() throws Exception {
		return sampleDAO.getNoticeList();
	}
	
	//댓글 목록을 받아옴
	@Override
	public List<?> getReplyList(int idx) throws Exception {
		return sampleDAO.getReplyList(idx);
	}
	
	//게시글 작성
	@Override
	public String insertBoard(BoardVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		return sampleDAO.insertBoard(vo);
	}
	
	//댓글 작성
	@Override
	public void insertReply(ReplyVO vo) throws Exception {
		sampleDAO.insertReply(vo);
	}
	
	//특정 게시글 선택
	@Override
	public BoardVO selectBoardByIdx(int idx) throws Exception {
		return sampleDAO.selectBoardByIdx(idx);
	}
	
	//게시글 내용 확인
	@Override
	public BoardVO selectBoard(BoardVO vo) throws Exception {
		BoardVO resultVO = sampleDAO.selectBoard(vo);
		
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}
	
	//게시글 내용 수정
	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		sampleDAO.updateBoard(vo);
	}
	
	//게시글 삭제
	@Override
	public void deleteBoard(BoardVO vo) throws Exception {
		sampleDAO.deleteBoard(vo);
	}
	
	//게시글 idx 재정렬
	@Override
	public void updateIdx() throws Exception {
		sampleDAO.updateIdx();
	}
	
	//댓글 삭제
	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		sampleDAO.deleteReply(vo);
	}
	
	//댓글 수정
	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		sampleDAO.updateReply(vo);
	}
	
	//조회수 증가
	@Override
	public void updateCnt(BoardVO vo) throws Exception {
		sampleDAO.updateCount(vo);
	}
	
	//로그인 시도
	public String getName(LoginVO vo) throws Exception {
		return sampleDAO.getName(vo);
	}
	
	//회원 정보 얻기
	public LoginVO getUser(LoginVO vo) throws Exception {
		return sampleDAO.getUser(vo);
	}
	
	//게시글 갯수 얻기
	public String getIdxCnt() throws Exception {
		return sampleDAO.getIdxCnt();
	}
	
	//이전 게시글 idx 얻기
	public Integer getBeforeBoard(BoardVO vo) throws Exception {
		return sampleDAO.getBeforeBoard(vo);
	}
	
	//다음 게시글 idx 얻기
	public Integer getAfterBoard(BoardVO vo) throws Exception {
		return sampleDAO.getAfterBoard(vo);
	}
	
	//=========================================================================================
	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectSampleListTotCnt(SampleDefaultVO searchVO) {
		return sampleDAO.selectSampleListTotCnt(searchVO);
	}

}
