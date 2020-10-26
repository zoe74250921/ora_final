package com.example.demo.db;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.CoursePhotoVo;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodPhotoVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.PublicTransportVo;

public class CourseManager {
	
private static SqlSessionFactory sqlSessionFactory;
private static final int recommendNum = 3;	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("코스매니저 예외 " +e.getMessage());
		}
	}
	
	public static int nextCno() {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("course.nextCno");
		session.close();
		return re;
	}
	
	public static int insertCourse(CourseVo c, PublicTransportVo sPT, PublicTransportVo ePT) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		int rec = session.insert("course.insertCourse", c);
		int resPT = session.insert("course.insertPT",sPT); 
		int reePT = session.insert("course.insertPT",ePT);
		
		if(rec > 0 && resPT > 0 && reePT > 0) {
			session.commit();
			re = 1;
		}
		else {
			session.rollback();
		}
		
		session.close();
		return re;
	}
	
	public static List<CourseVo> recommendList(String view) {  // 메인페이지 추천
		List<CourseVo> clist = new ArrayList<CourseVo>();
		SqlSession session = sqlSessionFactory.openSession();
		clist = session.selectList("course.selectByView", view);
		Collections.shuffle(clist);
		clist = clist.subList(0, recommendNum);
		for(CourseVo c : clist) {
			c.setC_views(c.getC_view().split("-"));
			List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", c.getC_no());
			Collections.shuffle(cpList);
			c.setC_photo(cpList);
		}
		System.out.println(clist);
		session.close();
		return clist;
	}
	
	public static CourseVo getCourseByCno(int c_no) {
		CourseVo c = null;
		SqlSession session = sqlSessionFactory.openSession();
		c = session.selectOne("course.selectByCno", c_no);
		c.setC_views(c.getC_view().split("-"));
		List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", c_no);			
		Collections.shuffle(cpList);
		if(cpList.size() == 0 ) {
			cpList = null;
		} 
		c.setC_photo(cpList);
		session.close();
		
		return c;
	}
	
	public static List<CourseVo> listCourse(){
		List<CourseVo> cList = null;
		SqlSession session = sqlSessionFactory.openSession();
		cList = session.selectList("course.selectCourseList");
		session.close();
		
		return cList;
	}
	
	public static List<CourseVo> searchCourseList(HashMap map){
		List<CourseVo> scList = new ArrayList<CourseVo>();
		List<Integer> inCnumList = null;
		List<Integer> cNumList = new ArrayList<Integer>();
		SqlSession session = sqlSessionFactory.openSession();
		
		int maxSearchSize = 500;
		double disNum= 0.1;
		double nearDisNum = 1;
		double timeNum = 0.3;

		int distance = (int) map.get("distance");
		int minDis = (int) map.get("minDis");
		int time = (int) map.get("time");
		int minTime = (int) map.get("minTime");

		
		for(int i=0; i<=maxSearchSize; i++) {
			map.put("maxNearDis", (5+(i*nearDisNum)));
			map.put("minDis", ((distance-minDis)-(i*disNum)));
			map.put("maxDis", (distance+(i*disNum)));
			map.put("minTime", ((time-minTime)-(i*timeNum)));
			map.put("maxTime", (time+(i*timeNum)));

			inCnumList = session.selectList("course.selectSearchCourseNum", map);
			for(int num : inCnumList) {
				if(!cNumList.contains(num)) {
					cNumList.add(num);
				}
			}
			
		}
		System.out.println(cNumList);
		for(int c_no : cNumList) {
			map.put("c_no", c_no);
			scList.add(selectByCnoandUserDis(map));
		}
		session.close();
		return scList;
	}
	
	public static CourseVo selectByCnoandUserDis(HashMap map) {
		CourseVo c = null;
		SqlSession session = sqlSessionFactory.openSession();
		c = session.selectOne("course.selectByCnoandUserDis", map);
		c.setC_views(c.getC_view().split("-"));
		List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", (int)map.get("c_no"));
		Collections.shuffle(cpList);
		c.setC_photo(cpList);
		session.close();
		
		return c;
	}
	
	public static List<PublicTransportVo> getPublicTransportByCno(int c_no){
		List<PublicTransportVo> ptList = null;
		SqlSession session = sqlSessionFactory.openSession();
		ptList = session.selectList("course.selectPt", c_no);
		session.close();
		
		return ptList;
	}
	
	public static List<FoodVo> getFoodByCno(int c_no){
		List<FoodVo> fList = null;
		SqlSession session = sqlSessionFactory.openSession();
		fList = session.selectList("course.selectFood", c_no);
		for(FoodVo f : fList) {
			List<FoodPhotoVo> fpList = session.selectList("course.selectFoodPhoto", f.getFood_no());
			Collections.shuffle(fpList);
			f.setFood_photo(fpList);
			
		}
		session.close();
		
		return fList;
	}
	
	public static FoodVo getFoodByFoodNo(int food_no) {
		FoodVo f = null;
		SqlSession session = sqlSessionFactory.openSession();
		f = session.selectOne("course.selectOneFood", food_no);
		List<FoodPhotoVo> fpList = session.selectList("course.selectFoodPhoto", food_no);
		Collections.shuffle(fpList);
		f.setFood_photo(fpList);
		session.close();
		return f;
	}
	
	
	
	
	private static String getTime(int minute) { // 디비에 분으로되어있는 시간을 시간과분으로 나타내기위한 처리작업
		 String c_time = "";  
		 if(minute/60 >0) {
			 c_time += (minute/60)+"시간 ";
		 }
		 if(minute%60 >0) {
			 c_time += (minute%60)+"분";
		 }
		 return c_time;
	}
}











