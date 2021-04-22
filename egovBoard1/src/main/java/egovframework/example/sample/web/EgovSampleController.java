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
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import egovframework.example.sample.service.LoginVO;
import egovframework.example.sample.service.ReplyVO;
import egovframework.example.sample.service.SampleDefaultVO;
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
	public String selectList( @RequestParam(value="selectedMenu", required=false) String menu, HttpServletRequest request,
							 @ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, BoardVO vo,
							 HttpSession session) throws Exception {
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
		
		
		//HttpSession을 이용하여 회원 정보를 세션에 저장하여 사용
		LoginVO userInfo = new LoginVO();
		userInfo.setId(session.getAttribute("id").toString());
		userInfo.setPassword(session.getAttribute("password").toString());
		userInfo.setName(session.getAttribute("name").toString());
		model.addAttribute("userInfo", userInfo);
		 
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
	public String boardContentView(@ModelAttribute("replyVO") ReplyVO replyVO, 
								   @RequestParam("selectedId") int idx, Model model) throws Exception {
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
	public String insertBoard(@ModelAttribute("searchVO") SampleDefaultVO searchVO, @ModelAttribute("boardVO") BoardVO boardVO, 
							 BindingResult bindingResult, Model model, SessionStatus status) throws Exception {

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
		
		sampleService.insertReply(replyVO);
		
		return "redirect:/boardContentView.do";
	}
		
	//댓글 삭제하는 부분
	@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
	public String deleteReply(@ModelAttribute("replyVO") ReplyVO replyVO, @RequestParam("replyIdx") int replyIdx,  
							  Model model, RedirectAttributes redirect) throws Exception {
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
	public String updateReply(@ModelAttribute("replyVO") ReplyVO replyVO, @RequestParam("replyIdx") int replyIdx, 
							  Model model, RedirectAttributes redirect) throws Exception {
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
	public String updateBoard(@ModelAttribute("BoardVO") BoardVO boardVO, BindingResult bindingResult, 
							  Model model, SessionStatus status) throws Exception {
		sampleService.updateBoard(boardVO);

		return "redirect:/egovBoardList.do";
	}
	
	//삭제 버튼 누를 시 작동하는 메소드
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(@ModelAttribute("BoardVO") BoardVO boardVO, SessionStatus status) throws Exception {
		sampleService.deleteBoard(boardVO);

		return "redirect:/egovBoardList.do";
	}
	
	//로그인 페이지를 띄우는 메소드
	@RequestMapping("/egovLogin.do")
	public String login(@ModelAttribute("LoginVO") LoginVO loginVO) throws Exception {
		return "sample/egovLogin";
	}
	
	//로그인을 수행하는 메서드
	@RequestMapping(value = "/startLogin.do", method = RequestMethod.POST)
	public String startLogin(@ModelAttribute("LoginVO") LoginVO loginVO, Model model, HttpSession session) throws Exception {
		//먼저 로그인 결과 얻기
		String name = sampleService.getName(loginVO);
		
		if(!name.equals("noName")) {
			//회원 정보 얻기
			loginVO.setName(name);
			LoginVO userInfo = sampleService.getUser(loginVO);

			//HttpSession을 이용하여 DB에서 받아온 회원 정보를 session에 저장
			session.setAttribute("id", userInfo.getId());
			session.setAttribute("password", userInfo.getPassword());
			session.setAttribute("name", userInfo.getName());
			
			return "redirect:/egovBoardList.do";
		} else {
			model.addAttribute("result", "가입된 회원이 아니거나 비밀번호가 틀립니다.");
			return "sample/egovLogin";
		}
	}
}
