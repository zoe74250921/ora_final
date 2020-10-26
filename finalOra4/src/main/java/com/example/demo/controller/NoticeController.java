package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dao.NoticeDao;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeDao dao;
	
	public void setDao(NoticeDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/listNotice")
	public void listNotice(Model model) {
		model.addAttribute("list",dao.listNotice());
	}
	
	@RequestMapping("/detailNotice")
	public void detailNotice(int n_no,Model model) {
		model.addAttribute("n",dao.detailNotice(n_no));
	}
}
