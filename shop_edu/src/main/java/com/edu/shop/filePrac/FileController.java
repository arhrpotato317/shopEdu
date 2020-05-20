package com.edu.shop.filePrac;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FileController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	// 첨부파일 연습 (https://to-dy.tistory.com/95)
	@RequestMapping("filePracMain.do")
	public ModelAndView filePracMain(ModelAndView mv) {
		logger.info("filePracMain");
		mv.setViewName("file/filePracMain");
		return mv;
	}
	
}
