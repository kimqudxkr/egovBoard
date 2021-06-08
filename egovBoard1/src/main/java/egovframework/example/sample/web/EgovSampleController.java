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

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
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
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//필터 이용 시 페이지 초기화
		if(!(menu == null || menu.equals(""))) {
			searchVO.setPageIndex(1);
			paginationInfo.setCurrentPageNo(1);
		}
		
		//공지사항 받아오는 곳
		List<?> noticeList = sampleService.getNoticeList();
		model.addAttribute("noticeList", noticeList);

		//페이지네이션 적용
		vo.setOffset((searchVO.getPageIndex()-1)*15);
		
		//필터 적용시키는 곳
		if(menu != null)
			vo.setMenu(menu);
		List<?> sampleList = sampleService.getBoardList(vo);
		model.addAttribute("resultList", sampleList);
		model.addAttribute("menu", menu);

		//공지가 아닌 게시글 갯수
		int nonNoticeBoardCnt = sampleService.getNonNoticeBoardCnt(vo);
		model.addAttribute("nonNotice", nonNoticeBoardCnt);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//다음글을 위하여 게시글 갯수 설정 부분
		String idxCnt = sampleService.getIdxCnt();
		model.addAttribute("idxCnt", idxCnt);
		
		//페이지네이션 페이지 갯수 생성
		paginationInfo.setTotalRecordCount(nonNoticeBoardCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//HttpSession을 이용하여 회원 정보를 세션에 저장하여 사용
		LoginVO userInfo = (LoginVO) session.getAttribute("userInfo");
		model.addAttribute("userInfo", userInfo);
		
		return "sample/egovBoardList";
	}
	
	//검색한 글 목록 불러오는 부분
	@RequestMapping(value="/egovBoardListBySearch.do")
	public String selectLisBySearch(HttpServletRequest request, @RequestParam(value="selectedMenu", required=false) String menu,
			 						@ModelAttribute("boardVO") BoardVO boardVO,
									@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model,
							 HttpSession session) throws Exception {
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

		//페이지네이션 적용
		boardVO.setOffset((searchVO.getPageIndex()-1)*15);
		
		//검색 적용
		List<?> sampleList = sampleService.getBoardListBySearch(boardVO);
		model.addAttribute("resultList", sampleList);
		model.addAttribute("menu", menu);
		model.addAttribute("searchType", boardVO.getSearchType());
		model.addAttribute("searchValue", boardVO.getSearchValue());
		
		//공지가 아닌 게시글 갯수
		int nonNoticeBoardCnt = sampleService.getNonNoticeBoardCnt(boardVO);
		model.addAttribute("nonNotice", nonNoticeBoardCnt);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//다음글을 위하여 게시글 갯수 설정 부분
		String idxCnt = sampleService.getIdxCnt();
		model.addAttribute("idxCnt", idxCnt);
		
		//페이지네이션 페이지 갯수 생성
		paginationInfo.setTotalRecordCount(nonNoticeBoardCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//HttpSession을 이용하여 회원 정보를 세션에 저장하여 사용
		LoginVO userInfo = (LoginVO) session.getAttribute("userInfo");
		model.addAttribute("userInfo", userInfo);
		
		return "sample/egovBoardList";
	}
	
	//글쓰기 페이지
	@RequestMapping(value = "/boardWriteView.do")
	public String boardWrite(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model, LoginVO userInfo,HttpSession session) throws Exception {
		model.addAttribute("boardVO", new BoardVO());
		userInfo = (LoginVO) session.getAttribute("userInfo");
		model.addAttribute("userInfo", userInfo);
		
		return "sample/egovBoardWrite";
	}
	
	//글 내용 조회 페이지
	@RequestMapping(value = "/boardContentView.do")
	public String boardContentView(@ModelAttribute("replyVO") ReplyVO replyVO, LoginVO userInfo, HttpSession session, 
								   @RequestParam(value="selectedMenu", required=false) String menu, @RequestParam("selectedId") int idx, 
								   Model model) throws Exception {
		//조회수 증가 부분
		BoardVO boardVO = sampleService.selectBoardByIdx(idx);
		int cnt = boardVO.getCnt();
		boardVO.setCnt(cnt+1);
		sampleService.updateCnt(boardVO);
		
		//조회수 증가 후 게시글 정보 
		model.addAttribute("boardVO", boardVO);

		//댓글 조회 부분
		List<?> replyList = sampleService.getReplyList(idx);
		model.addAttribute("replyList", replyList);
		
		//세션을 이용하여 댓글 작성자 설정 부분
		userInfo = (LoginVO) session.getAttribute("userInfo");
		model.addAttribute("userInfo", userInfo);
		
		//다음글을 위하여 게시글 갯수 설정 부분
		String idxCnt = sampleService.getIdxCnt();
		model.addAttribute("idxCnt", idxCnt);
		
		//이전글, 다음글을 위한 부분
		boardVO.setMenu(menu);
		int afterBoardIdx = (sampleService.getAfterBoard(boardVO) == null ? 0 : sampleService.getAfterBoard(boardVO));
		int beforeBoardIdx = (sampleService.getBeforeBoard(boardVO) == null ? 0 : sampleService.getBeforeBoard(boardVO));
		
		model.addAttribute("menu", menu);
		model.addAttribute("afterBoardIdx", afterBoardIdx);
		model.addAttribute("beforeBoardIdx", beforeBoardIdx);
		
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
		
		//게시글 idx 재정렬
		sampleService.updateIdx();
		
		return "redirect:/egovBoardList.do";
	}
	
	//선택 삭제 버튼 누를 시 작동하는 메소드
	@RequestMapping(value="/deleteBoardMany.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteBoardMany(@RequestParam(value="idxs[]") List<Integer> idxs) throws Exception {
		//List 속 idx 개수 만큼 반복하여 delete 수행
		for(Integer idx : idxs) {
			BoardVO boardVO = new BoardVO();
			boardVO.setIdx(idx);
			sampleService.deleteBoard(boardVO);
		}
		
		//게시글 idx 재정렬
		sampleService.updateIdx();
		
		return "success";
	}
		
	//로그인 페이지를 띄우는 메소드
	@RequestMapping("/egovLogin.do")
	public String login(@ModelAttribute("LoginVO") LoginVO loginVO) throws Exception {
		return "sample/egovLogin";
	}
	
	//회원가입 페이지를 띄우는 메소드
	@RequestMapping("/egovBoardJoin.do")
	public String join(@ModelAttribute("LoginVO") LoginVO loginVO) throws Exception {
		return "sample/egovBoardJoin";
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
			session.setAttribute("userInfo", userInfo);
			
			return "redirect:/egovBoardList.do";
		} else {
			model.addAttribute("result", "가입된 회원이 아니거나 비밀번호가 틀립니다.");
			return "sample/egovLogin";
		}
	}
	
	//로그인을 수행하는 메서드
		@RequestMapping(value = "/startJoin.do", method = RequestMethod.POST)
		public String startJoin(@ModelAttribute("LoginVO") LoginVO loginVO, Model model) throws Exception {
			String result = sampleService.checkId(loginVO);
			
			if(result == null) {
				sampleService.joinUser(loginVO);
				
				return "redirect:/egovLogin.do";
			} else {
				System.out.println("중복!!!");
				
				return "sample/egovBoardJoin";
			}
		}
	
	//로그아웃을 수행하는 메서드
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) throws Exception {
		//세션에 저장된 정보를 리셋
		session.setAttribute("userInfo", null);
		
		return "redirect:/egovLogin.do";
	}
}
