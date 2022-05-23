package com.yfactory.mes.mtrl.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface MtrlService {
	
	/*발주관리등록페이지*/
	//미지시 생산계획조회
	List<Map>selectPl();
	//생산계획별 자재재고
	List<Map>mtrlPlanList(String ppCd);
	//발주요청서 등록
	List<Map>mtrlOrderList(String ppCd, String mtCd);
	
	//발주조회
	List<Map>listRequest();
	//발주조회 검색
	List<Map>mtrlReqSelectSearch(String poCdinput);
	
	/*LOT페이지*/
	//LOT재고조회
	List<Map>listMtrlLot();
	//LOT재고 검색
	List<Map>lotSelectSearch(String m1,
			 String m2,
			 String req1,
			 String req2);
	
	
	/*MODAL페이지*/
	//자재명 조회
	List<Map>mtcdList();
	List<Map>mtnmSelectSearch(String mtnm);
	
	//업체명 조회
	List<Map>vendorList();
	List<Map>vdrnmSelectSearch(String vdrnm);
	
	//발주코드 검색
	List<Map>pocdList();
	List<Map>pocdSelectSearch(String pocd);
	
	
	
}
