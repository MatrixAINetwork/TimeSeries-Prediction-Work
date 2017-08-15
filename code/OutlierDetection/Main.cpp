#include "stdafx.h"  
#include"csvreader.h"
#include "datahandler.h"

int main(int argc, char* argv[]){

	DataHandler handler;
	
	//handler.axisTemperatureFunction();
	
	//string filesPath="F:\\sql_out\\231-6057-无轴温故障分天数据（全部）";

	////TEST
	////获得全部轴温数据并拆分输出到同一个文件
	////string filesPath="F:\\sql_out\\231-6057-无轴温故障分天数据（全部） - 提取全部温度";
	////string filePath = "F:\\sql_out\\231_无故障_多车型_一天数据";

	//string filePath = "F:\\sql_out\\不同车型车号_一天数据";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);

	////20161026
	//string filePath = "F:\\sql_out\\不同车型车号_一天数据2";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);

	////20161026
	//string filePath = "F:\\sql_out\\162_故障日数据";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);	

	////Test
	//const int header_n=20;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};
	//string mergeTail = "allAxisTemperature";	
	//string extractFilePath = "F:\\sql_out\\231_无故障_多车型_一天数据";
	////extractRelatedDataAndMerge(string extractFilePath, string header[], int header_n, string mergeFileTail);
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, mergeTail);


	////Test
	//const int header_n=20;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};
	//string mergeTail = "allAxisTemperature";	
	//string extractFilePath = "F:\\sql_out\\162_故障日数据";
	////extractRelatedDataAndMerge(string extractFilePath, string header[], int header_n, string mergeFileTail);
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, mergeTail);

	////20161026
	//const int header_n=20;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};
	//string mergeTail = "allAxisTemperature";	
	//string extractFilePath = "F:\\sql_out\\20161026-车型车号时间GroupTop100";
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, mergeTail);




	//20161103
	//string filePath = "F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);
	//------------------------------------------------------------------------------------
	//const int header_n=20;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};
	//string mergeTail = "allAxisTemperature";	
	//string extractFilePath = "F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault";
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, mergeTail);

	////20161209
	//const int header_n=21;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED", "BTSJ"};
	//string mergeTail = "allAxisTemperature";	
	////string extractFilePath = "F:\\sql_out\\20161026-车型车号时间GroupTop100";
	//string extractFilePath = "F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault";
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, "allAxisTemperature");

	//handler.removeReplicatedBtsjRows("F:\\sql_out\\20161026-车型车号时间GroupTop100\\out\\163_0151_2016-06-30_80_allAxisTemperature_merge2.csv");
	//handler.removeReplicatedBtsjRowsByDir("F:\\sql_out\\20161026-车型车号时间GroupTop100\\out\\allaxistemperature_merge2");
	//handler.removeReplicatedBtsjRowsByDir("F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault\\out\\merge with time");

	//输出文件夹下文件当中数据的记录数目
	//handler.getTheNumsOfFile("F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault\\out\\4.remove duplication");

	
	////20161230
	////【1】拆分温度
	//string filePath = "E:\\Data_Lab\\20161229-239型-不同车号-5线路-itf_6a-当日数据2\\少缺省";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);

	////20170104
	////233型-66666次-各车号运行当日数据
	////【1】拆分温度
	//string filePath = "E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);
	////【2】抽取相關量合併
	//const int header_n=21;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED", "BTSJ"};
	//string mergeTail = "allAxisTemperature";	
	//string extractFilePath = "E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据";
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, "allAxisTemperature");
	////【3】移除冗餘
	//handler.removeReplicatedBtsjRowsByDir("E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据\\out\\2. merge with time");

	////20170112
	////【1】拆分温度
	//string filePath = "E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);

	////20170211
	////测试十进制转二进制
	//vector<int> tmp = handler.decimalToBits(18);
	//测试splitSwitchVariables
	////获得开关信息列表
	//vector<SwitchInfo> switchInfoList = handler.getSwitchInfoList("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\itf_tcms_hxd_v20-swictInfoList.csv");
	//vector<string> removeIndexList = handler.getRemoveIndexList();
	//handler.splitSwitchVariables("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\tcms_1_cc66666_240_0143_2016-05-20.csv", switchInfoList, "_split", removeIndexList);
	////2010213
	////测试拆分所有文件
	//handler.splitSwitchVariablesOfFiles("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\original");
	//去除冗余行,btsjIndex=1
	//handler.removeReplicatedBtsjRowsByDir3("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\original\\2. 删除冗余行", 1);
	//handler.splitTmp();

	////20170405
	////拆分
	//string dir = "";
	//handler.splitTmpToDiffAxisWithComVars("E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据\\out\\4. interpolation\\8000以上");

	////20170405
	////拆分
	//string dir = "";
	//handler.splitTmpToDiffAxisWithComVars("E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据\\out\\4. interpolation\\8000以上");

	////20170104
	////233型-66666次-各车号运行当日数据
	////【1】拆分温度
	//string filePath = "E:\\Data_Lab\\数据驱动";
	//string axisHeader[6] = {"ZX_WD_1","ZX_WD_2","ZX_WD_3","ZX_WD_4","ZX_WD_5","ZX_WD_6"};//需要进行温度拆分的header名称
	//int axisNum[6]={1,2,3,4,5,6};
	//handler.extractTemperatureOfPointedAxis(filePath, axisHeader, axisNum);
	////【2】抽取相關量合併
	//const int header_n=21;
	//string header[header_n] = {"ZX_HW1_1","ZX_HW2_1","ZX_HW1_2","ZX_HW2_2","ZX_HW1_3","ZX_HW2_3","ZX_HW1_4","ZX_HW2_4","ZX_HW1_5","ZX_HW2_5","ZX_HW1_6","ZX_HW2_6","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED", "BTSJ"};
	//string mergeTail = "_merge";	
	//string extractFilePath = "E:\\Data_Lab\\数据驱动";
	//handler.extractRelatedDataAndMerge(extractFilePath, header, header_n, mergeTail);
	//【3】移除冗餘
	handler.removeReplicatedBtsjRowsByDir("E:\\Data_Lab\\数据驱动\\out\\2.merge");

	cout << "pause..." <<endl;
	system("pause");
}
