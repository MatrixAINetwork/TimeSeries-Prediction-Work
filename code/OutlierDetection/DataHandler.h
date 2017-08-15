#include "commonheader.h"
#include "csvreader.h"

//开关信息Struct
typedef struct SwitchInfo{
	int index;
	string name;
	int n_bits;

	void set(int a, string b, int c){
		index = a;
		name = b;
		n_bits = c;
	};
};

typedef struct SwitchSplited{
	SwitchInfo s;
	vector<vector<string>> splited;//列为主的vector

	void set(SwitchInfo a, vector<vector<string>> b){
		s = a;
		splited = b;
	};
};

class DataHandler
{
private:

public:
	CSVReader reader;
	HelpUtil util;
	vector<vector<string>> data_to_handle;

	static const int  n = 3;
	string header_names_extract[n];

	static const int n_temperature = 1;
	string tmperature_header_extract[n_temperature];

public:
	void axisTemperatureFunction();
	void initData();

//提取数据
public:
	void extractDataForAnalysis(string filename, string name_temperature);//提取二轴的温度相关数据
	void extractTemperatureOfPointedAxis(string filesPath, string axisHeader[], int axisNum[]);//提取指定轴的相关数据
	void extractRelatedDataAndMerge(string extractFilePath, string header[], int header_n, string mergeFileTail);	
	//将重采样数据拆分成不同轴+共同相关变量，用于LSTM
	void splitTmpToDiffAxisWithComVars(string path);
	
	string getFilePath();

//数据清理
public:
	//删除冗余
	vector<int*> getReplicatedBtsjIndex(vector<vector<string>> data);
	vector<int*> getReplicatedBtsjIndex3(vector<vector<string>> data, int btsjIndex);
	vector<vector<string>> removeReplicatedBtsjRows(string filename);
	vector<vector<string>> removeReplicatedBtsjRows3(string filename, int btsjIndex);
	vector<vector<string>> removeReplicatedBtsjRows2(string filename);//针对跳变剧烈的数据集，相同时间点的数据取低温数据
	void removeReplicatedBtsjRowsByDir(string dir);
	void removeReplicatedBtsjRowsByDir3(string dir, int btsjIndex);

	void getTheNumsOfFile(string dir);

	//拆解开关量,返回拆解后的内容
	//入参带有head
	vector<vector<string>> splitSwitchVariable(vector<string> decimalList, int n_bits);
	//拆分一个文件中的所有开关量
	void splitSwitchVariables(string filename, vector<SwitchInfo> switchInfoList,string tail, vector<string> removeIndexList);
	//加载外部文件，获得开关列信息
	vector<SwitchInfo> getSwitchInfoList(string filename);
	//获得不需要的列的index
	vector<string> getRemoveIndexList(string filename);
	//拆分多个文件
	void splitSwitchVariablesOfFiles(string fileDir);
	//
	void splitTmp();
	
//help function
public:
	vector<vector<string>> getDataToHandle(string str_names[], int n);
	void outputRow(vector<string> row);
	vector<string> splitPath(string filename);
	vector<string> insertDirInPath(vector<string> path, string dir);
	vector<string> upPath(vector<string> path);
	vector<string> dirUpInPath(vector<string> path);
	string getTailedPath(vector<string> path, string tail);
	vector<string> decimalToBits(int decimal, int n_bits);//十进制转换成8位的二进制
	vector<vector<string>> colToRowReverse(vector<vector<string>> data);//将以行为主存储的vector变成以列为主存储的

private:
	vector<string> split_temperature(string str);
	vector<vector<string>> getSplitedTemperatureList(vector<vector<string>> dataList,int axis, string axisName);
	string getOutputPath(string filename);
	

};

