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
package egovframework.example.sample.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
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

@Controller
public class EgovSampleController {

	/** EgovSampleService */
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	//글 목록 불러오는 페이지
	@RequestMapping(value="/egovBoardList.do")
	public String selectList(@RequestParam(value="selectedMenu", required=false) String menu, @ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, BoardVO vo) throws Exception {
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//공지사항 받아오는 곳
		List<?> noticeList = sampleService.getNoticeList();
		model.addAttribute("noticeList", noticeList);

		//필터 적용시키는 곳
		List<?> sampleList = (menu == null || menu.equals("all")) ? sampleService.getBoardList() : sampleService.getFilteredBoardList(menu);
		model.addAttribute("resultList", sampleList);
		model.addAttribute("menu", menu);

		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "sample/egovBoardList";
	}
	
	//글쓰기 페이지
	@RequestMapping(value = "/boardWriteView.do")
	public String boardWrite(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute("boardVO", new BoardVO());
		
		return "sample/egovBoardWrite";
	}
	
	//글 내용 조회 페이지
	@RequestMapping(value = "/boardContentView.do")
	public String boardContentView(@ModelAttribute("replyVO") ReplyVO replyVO, @RequestParam("selectedId") int idx, Model model) throws Exception {
		//조회수 증가 부분
		BoardVO boardVO = sampleService.selectBoardByIdx(idx);
		int cnt = boardVO.getCnt();
		boardVO.setCnt(cnt+1);
		sampleService.updateCnt(boardVO);
		
		model.addAttribute("boardVO", boardVO);
		
		//댓글 조회 부분
		List<?> replyList = sampleService.getReplyList(idx);
		model.addAttribute("replyList", replyList);
		
		return "sample/egovBoardContent";
	}
	
	//글쓰기 버튼 클릭 시 insert하는 곳
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.POST)
	public String insertBoard(@ModelAttribute("searchVO") SampleDefaultVO searchVO, @ModelAttribute("boardVO") BoardVO boardVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(boardVO, bindingResult);

		sampleService.insertBoard(boardVO);
		
		return "redirect:/egovBoardList.do";
	}
	
	//댓글 작성하는 부분
	@RequestMapping(value = "/writeReply.do", method = RequestMethod.POST)
	public String insertReply(@ModelAttribute("replyVO") ReplyVO replyVO, Model model, RedirectAttributes redirect) throws Exception {
		//전달할 파라미터 입력
		int idx = replyVO.getIdx();
		redirect.addAttribute("selectedId", idx);
		
		System.out.println(replyVO.getReplyIdx());
		
		sampleService.insertReply(replyVO);
		
		return "redirect:/boardContentView.do";
	}
		
	//댓글 삭제하는 부분
	@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
	public String deleteReply(@ModelAttribute("replyVO") ReplyVO replyVO, @RequestParam("replyIdx") int replyIdx,  Model model, RedirectAttributes redirect)
				throws Exception {
		//전달할 파라미터 입력
		int idx = replyVO.getIdx();
		redirect.addAttribute("selectedId", idx);
		
		//삭제할 댓글 설정 부분
		replyVO.setReplyIdx(replyIdx);
		sampleService.deleteReply(replyVO);
		
		return "redirect:/boardContentView.do";
	}
		
	//댓글 수정하는 부분
	@RequestMapping("/updateReply.do")
	public String updateReply(@ModelAttribute("replyVO") ReplyVO replyVO, @RequestParam("replyIdx") int replyIdx,  Model model, RedirectAttributes redirect) throws Exception {
		//전달할 파라미터 입력
		int idx = replyVO.getIdx();
		redirect.addAttribute("selectedId", idx);
		
		//삭제할 댓글 설정 부분
		replyVO.setReplyIdx(replyIdx);
		sampleService.updateReply(replyVO);
		
		return "redirect:/boardContentView.do";
	}
		
	//한 게시글에 대한 정보를 받아오는 메소드
	public BoardVO selectBoard(BoardVO boardVO) throws Exception {
		return sampleService.selectBoard(boardVO);
	}
	
	//수정 화면을 띄우는 메소드
	@RequestMapping("/updateBoardView.do")
	public String updateBoardView(@ModelAttribute("BoardVO") BoardVO boardVO, SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute(selectBoard(boardVO));
		
		return "sample/egovBoardWrite";
	}
	
	//수정 버튼을 누를시 작동하는 메소드
	@RequestMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute("BoardVO") BoardVO boardVO, BindingResult bindingResult, Model model, SessionStatus status) throws Exception {
		sampleService.updateBoard(boardVO);

		return "redirect:/egovBoardList.do";
	}
	
	//삭제 버튼 누를 시 작동하는 메소드
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(@ModelAttribute("BoardVO") BoardVO boardVO, SessionStatus status) throws Exception {
		sampleService.deleteBoard(boardVO);

		return "redirect:/egovBoardList.do";
	}
	
	//==========================================================================================================================
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/egovSampleList.do")
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = sampleService.selectSampleList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sample/egovSampleList";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		
		model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/addSample.do", method = RequestMethod.POST)
	public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.insertSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setId(id);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute(selectSample(sampleVO, searchVO));
		return "sample/egovSampleRegister";
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return sampleService.selectSample(sampleVO);
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		sampleService.deleteSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}

}
