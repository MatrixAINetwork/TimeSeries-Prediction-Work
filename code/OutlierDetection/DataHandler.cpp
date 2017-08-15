#include "stdafx.h"
#include "datahandler.h"
#include <set>
#include <iterator>

string DataHandler::getFilePath()
{

	string filePath = "F:\\sql_out\\231_二轴五位温升故障前数据";
	//string filePath = "F:\\sql_out\\231-6057-无轴温故障分天数据（全部）";
	//string filePath = "F:\\sql_out\\231-6057-非B故障分天数据";
	//string filePath = "F:\\sql_out\\B类故障4624229-分天数据";

	cout << "INFO: 文件路径：" << filePath <<endl;

	return filePath;
}

void DataHandler::initData()
{
	////初始化需要提取的header名称
	//string tmp_names[n] = {"ZX_WD_2","ZX_HW1_2","ZX_HW2_2"};
	//memcpy(header_names_extract, tmp_names, sizeof(tmp_names));

	//初始化需要拆分的温度的header名称
	string tmp_temperature_header[n_temperature] = {"ZX_WD_2"};
	memcpy(tmperature_header_extract, tmp_temperature_header, sizeof(tmp_temperature_header));
}

void DataHandler::extractDataForAnalysis(string filename, string name_tempera)
{
	cout << "extractDataForAnalysis: start..." <<endl;
	//初始化需要提取的header名称
	const int n_extract = 10;
	//string extract_header[n_extract] = {"ZX_HW1_2","ZX_HW2_2"};
	string extract_header[n_extract] = {"ZX_HW1_2","ZX_HW2_2","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};

	vector<vector<string>> data = getDataToHandle(extract_header, n_extract);
	filename.erase(filename.end()-4, filename.end());
	vector<string> split_filename = util.split(filename, "\\");
	split_filename.insert(split_filename.end()-1,"out");
	filename = util.merge(split_filename);

	string fileneme_temperature = filename+"-"+name_tempera+".csv";
	string filename_out = filename + "-tempera" + ".csv";
	cout << "INFO:读取温度相关关联数据" <<endl;
	cout << "INFO:" << fileneme_temperature <<endl;
	vector<vector<string>> data_tempera = reader.readData(fileneme_temperature);

	vector<vector<string>> data_out;
	vector<int> delet_positions;

	cout << "INFO:合并数据到到同一文件" <<endl;
	for(int i=0; i<data_tempera.size(); i++)
	{
		vector<string> tmp;
		
		////对于不合理的温度记录数据行号，直接跳过这一行的数据
		//if(data_tempera[i][0] == "-100")
		//{
		//	delet_positions.push_back(i);
		//	continue;
		//}

		//数据合并成一行，加入到输出数据

		//添加一行轴温数据（能够到这一步，证明轴温都是合法的）
		int flag = 0;
		for(int j=0; j<data_tempera[0].size(); j++)
		{
			tmp.push_back(data_tempera[i][j]);//先加入队列
			if(data_tempera[i][0] == "-100")
			{
				delet_positions.push_back(i);
				flag = 1;
				break;
			}			
		}
		if(flag == 1)//一但这一行的轴温有问题，就不用往下检查，反正这一行最后需要删除
			continue;

		//在轴温后面添加相关变量数据
		for(int j=0; j<data[0].size(); j++)
		{
			if(data[i][j].size() < 1)//如果为null
			{
				delet_positions.push_back(i);//添加行号,且没有必要再把数据加入队列
				break;
			}
			tmp.push_back(data[i][j]);
		}
		data_out.push_back(tmp);
	}

	//删除问题数据
	//postion一定是按照行号来递增的，每删除一行，后面的position都要减去1
	int minus = 0;
	for(int i=0; i<delet_positions.size(); i++)
	{
		data_out.erase(data_out.begin()+i-minus);
	}

	reader.writeData(filename_out, data_out);

	cout << "extractDataForAnalysis: end..." <<endl;
}

void DataHandler::axisTemperatureFunction()
{
	//initData();

	cout << "axisTemperatureFunction() start..." <<endl;

	string filepath = getFilePath();
	reader.readFilenameList(filepath, reader.filenameList);


	//需要进行温度拆分的header名称
	string str_names[n_temperature] = {"ZX_WD_2"};
	for(int i=0; i<reader.filenameList.size(); i++)
	{
		string filename = reader.filenameList[i];

		cout << "INFO: 读取2轴温度" <<endl;
		reader.readData(filename);		
		
		
		//memcpy(str_names, tmperature_header_extract, sizeof(tmperature_header_extract));
		//获得需要处理的数据
		cout << "INFO: 获得待处理的数据" <<endl;
		getDataToHandle(str_names, n_temperature);
		
		cout << "INFO: 数据拆分与转换" <<endl;
		vector<vector<string>> temperatureList;

		for(int j=0; j<data_to_handle[0].size(); j++)
		{
			//添加header
			vector<string> tmp;
			for(int i=0; i<8; i++)
			{
				stringstream ss;
				ss << i+1;
				tmp.push_back(str_names[j]+"_"+ss.str());				
			}
			temperatureList.push_back(tmp);
			//添加數據
			for(int i=1; i<data_to_handle.size(); i++)//跳过第一行
			{
				if(data_to_handle[i][j].size() < 16)//数据缺省，去除数据
				{
					vector<string> tmp(8,"-100");
					temperatureList.push_back(tmp);
				}else
				{
					temperatureList.push_back(split_temperature(data_to_handle[i][0]));	
				}			
			}

			cout << "INFO: 输出处理后数据" <<endl;
			filename.erase(filename.end()-4, filename.end());
			vector<string> split_filename = util.split(filename, "\\");
			split_filename.insert(split_filename.end()-1,"out");
			filename = util.merge(split_filename);

			reader.writeData(filename+"-"+data_to_handle[0][j]+".csv",temperatureList);

			temperatureList.clear();	
		}

					//提取溫度相關的變量到文件
		filename = reader.filenameList[i];
		extractDataForAnalysis(filename, str_names[0]);
		
	}

	cout << "axisTemperatureFunction() end..." <<endl;
}
vector<vector<string>> DataHandler::getSplitedTemperatureList(vector<vector<string>> dataList,int axis, string axisName)
{
	vector<vector<string>> temperatureList;
	int n = 8;

	//添加header
	vector<string> header;
	for(int i=0; i<n; i++)
	{
		stringstream ss;
		ss << i+1;
		header.push_back(axisName+"_"+ss.str());				
	}
	temperatureList.push_back(header);

	//添加数据
	//将16进制温度拆分成8个10进制
	int size = dataList.size();//row size
	for(int i=1; i<size; i++)//跳过第一行
	{
		if(dataList[i][axis].size() < 16)//数据缺省，转换成-100，之后便于剔除
		{
			vector<string> dataSingle(8,"-100");
			temperatureList.push_back(dataSingle);
		}else
		{
			temperatureList.push_back(split_temperature(dataList[i][axis]));	
		}		
	}

	return temperatureList;
}
vector<string> DataHandler::split_temperature(string str)
{
	vector<string> temperatureList;
	int i=0;
	while((i+1) <= str.length())
	{
		string str_tmp = str.substr(i, 2);
		int int_tmp = util.hex_to_decimal(str_tmp.data(), 2);
		string val_tmp;
		util.int2str(int_tmp, val_tmp);
		temperatureList.push_back(val_tmp);
		i = i+2;
	}

	return temperatureList;
}

vector<vector<string>> DataHandler::getDataToHandle(string str_names[], int n)
{

	cout<<"INFO:提取数据:";
	for(int i=0; i<n; i++){
		cout << str_names[i] << ";";
	}
	cout <<endl;

	data_to_handle.clear();

	vector<string> names(str_names, str_names+n);
	vector<string> header = reader.data[0];

	//需要提取的列的position
	vector<int> positions;
	for(int i=0; i<header.size(); i++)
	{
		for(int j=0; j<names.size(); j++)
		{
			if(header[i] == names[j])
			{
				positions.push_back(i);
				break;
			}
		}
	}
	
	//没有相关列
	if(positions.size() == 0)
	{
		cout << "ERROR: 文件当中没有找到待处理的数据" <<endl;
		return data_to_handle;
	}

 	for(int i=0; i<reader.data.size(); i++)
	{
		vector<string> vec_tmp;
		for(int j=0; j<positions.size(); j++)
		{
			vec_tmp.push_back(reader.data[i][positions[j]]);
		}
		data_to_handle.push_back(vec_tmp);
	}

	return data_to_handle;
}

//获得输出路径
string DataHandler::getOutputPath(string filename)
{
	filename.erase(filename.end()-4, filename.end());
	vector<string> split_filename = util.split(filename, "\\");
	split_filename.insert(split_filename.end()-1,"out");
	filename = util.merge(split_filename);

	return filename;
}
//拆分路径
vector<string> DataHandler::splitPath(string filename){
	filename.erase(filename.end()-4, filename.end());
	vector<string> split_filename = util.split(filename, "\\");

	return split_filename;
}
//插入路径
vector<string> DataHandler::insertDirInPath(vector<string> path, string dir){
	path.insert(path.end()-1,dir);

	return path;
}
vector<string> DataHandler::upPath(vector<string> path){
	path.pop_back();
	return path;
}
//返回最后整合路径
string DataHandler::getTailedPath(vector<string> path, string tail){
	string filename="";
	int i=0;
	for(; i<path.size()-1; i++){
		filename = filename+path[i]+"\\";
	}
	filename = filename+path[i]+tail+".csv";

	return filename;
}

//提取指定轴的相关数据
void DataHandler::extractTemperatureOfPointedAxis(string filesPath, string axisHeader[], int axisNum[])
{
	cout<< "INFO:开始-提取指定轴的数据" <<endl;

	//获得csv文件列表
	reader.readFilenameList(filesPath, reader.filenameList);	

	//遍历文件夹下的csv文件
	for(int i=0; i<reader.filenameList.size(); i++)
	{
		vector<vector<vector<string>>> allTemperatureList;

		//读取文件
		string filename = reader.filenameList[i];
		reader.readData(filename);	
		getDataToHandle(axisHeader,6);

		//遍历每个轴的温度进行拆分与输出
		int size = data_to_handle[0].size();
		for(int j=0; j<size; j++)
		{
			//拆分某个轴数据到列表
			vector<vector<string>> temperatureList = getSplitedTemperatureList(data_to_handle, j, axisHeader[j]);			
			//获得输出路径
			//string fileOutputPath = getOutputPath(filename);
			//输出拆分后数据到csv
			//string tmp = axisHeader[j];
			//reader.writeData(fileOutputPath+"-"+tmp+".csv",temperatureList);

			//将对应轴的温度放入总的vector
			allTemperatureList.push_back(temperatureList);
		}	

		//整合各轴拆分后的数据到统一的vector
		vector<vector<string>> dataOutTemp;
		int rowSize = allTemperatureList[0].size();
		int axisSize = allTemperatureList.size();
		int colSize = allTemperatureList[0][0].size();
		for(int i=0; i<rowSize; i++)
		{
			vector<string> rowTmp;
			for(int j=0; j<axisSize; j++)
			{
				for(int k=0; k<colSize; k++)
				{
					rowTmp.push_back(allTemperatureList[j][i][k]);
				}				
			}
			dataOutTemp.push_back(rowTmp);
		}
		
		//获得输出路径
		vector<string> path = insertDirInPath(splitPath(filename), "out\\1.axis");
		string fileOutputPath = getTailedPath(path,"_axis");
		//输出拆分并后的数据
		reader.writeData(fileOutputPath,dataOutTemp);
	}

	cout<< "INFO:结束-提取指定轴的数据" <<endl;
}

void DataHandler::extractRelatedDataAndMerge(string extractFilePath, string header[], int header_n, string mergeFileTail)
{
	//调用示例
	//初始化需要提取的header名称
	//const int n_extract = 10;
	//header[n_extract] = {"ZX_HW1_2","ZX_HW2_2","ZD_FLAG","ZD_ALT","ZD_CNT","ZD_LCG","ZD_TFG","ZD_JHG", "ZD_LLJ", "ZD_SPEED"};
	//extractFilePath = "F:\\sql_out\\231_无故障_多车型_一天数据";
	//mergeTail = "allAxisTemperature";
	//header_n=10;

	//获得csv文件列表
	reader.readFilenameList(extractFilePath, reader.filenameList);	

	//遍历文件夹下的csv文件
	for(int i=0; i<reader.filenameList.size(); i++)
	{
		//提取数据
		string filename = reader.filenameList[i];
		reader.readData(filename);	
		getDataToHandle(header,header_n);

		//获得输出路径,也是待合并数据的路径
		vector<string> path = insertDirInPath(splitPath(filename), "out\\2.merge");
		string fileOutputPath = getTailedPath(path,"_merge");

		//读取待合并数据
		path = insertDirInPath(splitPath(filename), "out\\1.axis");
		string mergeFilename = getTailedPath(path,"_axis");
		vector<vector<string>> data_to_merge = reader.readData(mergeFilename);

		vector<vector<string>> data_out;
		vector<int> delet_positions;

		cout << "INFO:合并数据到到同一文件" <<endl;
		for(int i=0; i<data_to_merge.size(); i++)
		{
			vector<string> tmp;

			for(int j=0; j<data_to_merge[0].size(); j++)
			{
				tmp.push_back(data_to_merge[i][j]);//先加入队列
				if(data_to_merge[i][j] == "-100")//一旦这一行有空，则跳过检查
				{
					delet_positions.push_back(i);
					break;
				}			
			}

			//在轴温后面添加相关变量数据
			for(int j=0; j<data_to_handle[0].size(); j++)
			{
				if(data_to_handle[i][j].size() < 1)//如果为null
				{
					delet_positions.push_back(i);//添加行号,且没有必要再把数据加入队列
					break;
				}
				tmp.push_back(data_to_handle[i][j]);
			}
			data_out.push_back(tmp);
		}

		//删除问题数据
		//postion一定是按照行号来递增的，每删除一行，后面的position都要减去1
		int minus = 0;
		for(int i=0; i<delet_positions.size(); i++)
		{
			if(i==132)
				cout<<"-----------"<<i<<endl;
			int t = delet_positions[i]-i;
			data_out.erase(data_out.begin()+t);
			
		}

		reader.writeData(fileOutputPath, data_out);	

	}



}

void DataHandler::splitTmpToDiffAxisWithComVars(string dir){
	
	//获得文件列表
	reader.readFilenameList(dir, reader.filenameList);

	//遍历文件
	for(int i=0; i<reader.filenameList.size(); i++){
		string filepath = reader.filenameList[i];
		reader.readData(filepath);	

		//获得输出路径,也是待合并数据的路径
		vector<string> path = insertDirInPath(splitPath(filepath), "splitedAxis");
		//按照轴拆分
		for(int j=0; j<6; j++){			
			vector<vector<string>> axisData;

			int nrow = reader.data.size();
			//遍历每一行
			for(int r=0; r<nrow; r++){
				vector<string> row;
				int s = 8*j+1;
				int e = 8*(j+1)-2;
				//轴温
				for(int k=s; k<=e; k++){
					row.push_back(reader.data[r][k]);
				}
				//环温
				s = 56+2*j+1;
				e = 56+2*(j+1);
				for(int k=s; k<=e; k++){
					row.push_back(reader.data[r][k]);
				}
				//相关变量
				s = 52;
				e = 56;
				for(int k=s; k<=e; k++){
					row.push_back(reader.data[r][k]);
				}

				axisData.push_back(row);
			}
			//输出
			string tail = "_axis_"+to_string(j+1);
			string fileOutputPath = getTailedPath(path,tail);
			reader.writeData(fileOutputPath, axisData);
		}		
	}

}

//距举例
//163_0151_2016-06-30_80_allAxisTemperature_merge2
//BTSJ=49列
vector<int*> DataHandler::getReplicatedBtsjIndex(vector<vector<string>> data){

	vector<int*> res;
	int btsj_n = 49;
	for(int i=1; i<data.size(); i++){
		
		//if(i==26237){
		//	cout<<i<<endl;
		//}
		int *tmp;
		if(data[i][btsj_n-1] == data[i-1][btsj_n-1]){		
			//cout<<"-----------------\n";
			tmp = new int[2];//tmp[0]=start index, tmp[1]=end index
			tmp[0]=i-1;
			while(data[i][btsj_n-1] == data[i-1][btsj_n-1]){				
				//outputRow(data[i-1]);
				i++;
				if(i==data.size()){
					break;
				}
			}	
			//outputRow(data[i-1]);
			tmp[1]=i-1;
			i--;
			res.push_back(tmp);
		}
	}	

	return res;
}

vector<int*> DataHandler::getReplicatedBtsjIndex3(vector<vector<string>> data, int btsjIndex){

	vector<int*> res;
	int btsj_n = btsjIndex;
	for(int i=1; i<data.size(); i++){
		
		//if(i==26237){
		//	cout<<i<<endl;
		//}
		int *tmp;
		if(data[i][btsj_n-1] == data[i-1][btsj_n-1]){		
			//cout<<"-----------------\n";
			tmp = new int[2];//tmp[0]=start index, tmp[1]=end index
			tmp[0]=i-1;
			while(data[i][btsj_n-1] == data[i-1][btsj_n-1]){				
				//outputRow(data[i-1]);
				i++;
				if(i==data.size()){
					break;
				}
			}	
			//outputRow(data[i-1]);
			tmp[1]=i-1;
			i--;
			res.push_back(tmp);
		}
	}	

	return res;
}

void DataHandler::outputRow(vector<string> row){
	for(int i=0; i<row.size(); i++){
		 cout<<row[i] << " ";
	}
	cout<<endl;
}

//针对正常无跳变数据，冗余数据相等，保留第一条即可
vector<vector<string>> DataHandler::removeReplicatedBtsjRows(string filename){

	cout<< "START: 移除文件" << filename << "中时间重复的数据" <<endl;

	vector<vector<string>> data = reader.readData(filename);
	vector<int*> replicatedBtsjIndex = getReplicatedBtsjIndex(data);
	
	//重复的时间数据可能是由于时间截取粒度原因，我们只精确到秒
	//由于后续研究的时间粒度以秒为单位，所以将精确到秒的相同数据进行整合
	//初步观察：时间相同的数据，轴温大部分相同，少部分不同
	//相同时间数据取第一条
	int len = replicatedBtsjIndex.size();
	int remove_len = 0;
	for(int i=0; i<len; i++){
		/*cout<<i<<endl;*/
		//if(i==7970){
		//	cout<<i<<endl;
		//}
		int start = replicatedBtsjIndex[i][0];
		int end = replicatedBtsjIndex[i][1];
		for(int j=start+1; j<=end; j++){
			int tmp = j-remove_len;
			data.erase(data.begin()+tmp);
			remove_len++;
		}
		//remove_len = remove_len + (end-start);
	}
	vector<string> path = dirUpInPath(splitPath(filename));
	//path = upPath(path);
	path = insertDirInPath(path, "3.remove");	
	string tmp = path[path.size()-1];
	path[path.size()-1] = tmp.substr(0,tmp.length()-6);

	string outputPath = getTailedPath(path, "_rm");
	reader.writeData(outputPath, data);
	

	cout<< "END: 移除文件" << filename << "中时间重复的数据" <<endl;

	return data;
}

//针对正常无跳变数据，冗余数据相等，保留第一条即可
vector<vector<string>> DataHandler::removeReplicatedBtsjRows3(string filename, int btsjIndex){

	cout<< "START: 移除文件" << filename << "中时间重复的数据" <<endl;

	vector<vector<string>> data = reader.readData(filename);
	vector<int*> replicatedBtsjIndex = getReplicatedBtsjIndex3(data, btsjIndex);
	
	//重复的时间数据可能是由于时间截取粒度原因，我们只精确到秒
	//由于后续研究的时间粒度以秒为单位，所以将精确到秒的相同数据进行整合
	//初步观察：时间相同的数据，轴温大部分相同，少部分不同
	//相同时间数据取第一条
	int len = replicatedBtsjIndex.size();
	int remove_len = 0;
	for(int i=0; i<len; i++){
		/*cout<<i<<endl;*/
		//if(i==7970){
		//	cout<<i<<endl;
		//}
		int start = replicatedBtsjIndex[i][0];
		int end = replicatedBtsjIndex[i][1];
		for(int j=start+1; j<=end; j++){
			int tmp = j-remove_len;
			data.erase(data.begin()+tmp);
			remove_len++;
		}
		//remove_len = remove_len + (end-start);
	}
	vector<string> path = dirUpInPath(splitPath(filename));
	path = insertDirInPath(path, "删除冗余行");	
	string outputPath = getTailedPath(path, "_rm");
	reader.writeData(outputPath, data);
	

	cout<< "END: 移除文件" << filename << "中时间重复的数据" <<endl;

	return data;
}

//针对有跳变的数据，冗余数据的值不一致，需要进行筛选保留合理的值
vector<vector<string>> DataHandler::removeReplicatedBtsjRows2(string filename){

	cout<< "START: 移除文件" << filename << "中时间重复的数据" <<endl;

	vector<vector<string>> data = reader.readData(filename);
	vector<int*> replicatedBtsjIndex = getReplicatedBtsjIndex(data);
	
	//重复的时间数据可能是由于时间截取粒度原因，我们只精确到秒
	//由于后续研究的时间粒度以秒为单位，所以将精确到秒的相同数据进行整合
	//初步观察：时间相同的数据，轴温大部分相同，少部分不同
	//相同时间数据取第一条
	int len = replicatedBtsjIndex.size();
	int remove_len = 0;
	for(int i=0; i<len; i++){

		//if(i == 452){
		//	printf("ERROR TEST: %d",i);
		//}

		/*cout<<i<<endl;*/
		//if(i==7970){
		//	cout<<i<<endl;
		//}
		int start = replicatedBtsjIndex[i][0];
		int end = replicatedBtsjIndex[i][1];
		//找到时间点相同的记录当中值最小的行的index
		int min_index = start;
		for(int j=start+1; j<=end; j++){
			if(data[min_index-remove_len][0] > data[j-remove_len][0]){
				min_index = j;
			}
		}
		//删除最小index外的其他重复行
		for(int j=start; j<=end; j++){
			if(j==min_index){
				continue;
			}
			int tmp = j-remove_len;
			data.erase(data.begin()+tmp);
			remove_len++;
		}
		//remove_len = remove_len + (end-start);
	}
	vector<string> path = dirUpInPath(splitPath(filename));
	path = insertDirInPath(path, "3. remove duplication");	
	string outputPath = getTailedPath(path, "_r");
	reader.writeData(outputPath, data);
	printf("\nLength:%d\n\n",data.size());
	cout<< "END: 移除文件" << filename << "中时间重复的数据" <<endl;

	return data;
}


void DataHandler::removeReplicatedBtsjRowsByDir(string dir){
	cout<< "START: 移除目录" << dir << "下文件中时间重复的数据" <<endl;

	//获得csv文件列表
	reader.readFilenameList(dir, reader.filenameList);	

	for(int i=0; i<reader.filenameList.size(); i++){
		string filename = reader.filenameList[i];
		removeReplicatedBtsjRows(filename);
	}

	cout<< "END: 移除目录" << dir << "下文件中时间重复的数据" <<endl;
}

void DataHandler::removeReplicatedBtsjRowsByDir3(string dir, int btsjIndex){
	cout<< "START: 移除目录" << dir << "下文件中时间重复的数据" <<endl;

	//获得csv文件列表
	reader.readFilenameList(dir, reader.filenameList);	

	for(int i=0; i<reader.filenameList.size(); i++){
		string filename = reader.filenameList[i];
		removeReplicatedBtsjRows3(filename, btsjIndex);
	}

	cout<< "END: 移除目录" << dir << "下文件中时间重复的数据" <<endl;
}

vector<string> DataHandler::dirUpInPath(vector<string> path){
	path.erase(path.end()-2);
	return path;
}
//输出文件夹下文件当中数据的记录数目
void DataHandler::getTheNumsOfFile(string dir){
	vector<vector<string>> data_out;

	reader.readFilenameList(dir, reader.filenameList);
	for(int i=0; i<reader.filenameList.size(); i++){
		vector<string> tmp;

		string filename = reader.filenameList[i];
		reader.readData(filename);
		string num = to_string(reader.data.size());
		tmp.push_back(num);
		tmp.push_back(reader.filenameList[i]);

		data_out.push_back(tmp);
	}
	reader.writeData(dir+"\\tmp.csv",data_out);
}

void DataHandler::splitTmp(){
	string fileDir = "E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\original\\2. 删除冗余行";
	vector<string> filenameList;
	reader.readFilenameList(fileDir, filenameList);
	filenameList = reader.filenameList;

	vector<SwitchInfo> switchInfoList;
	SwitchInfo t;
	t.set(52,"FZ_YBSXDLQZT",3);
	switchInfoList.push_back(t);
	t.set(53,"FZ_YSJGZ",2);
	switchInfoList.push_back(t);

	int n_filenum = filenameList.size();
	for(int i=0; i<n_filenum; i++){
		string filename = filenameList[i];
		vector<vector<string>> data = reader.readData(filename);
		int n_row = data.size();
		data = colToRowReverse(data);
		vector<vector<string>> data_out;
		int n_switch = switchInfoList.size();
		for(int i=0; i<n_switch; i++){
			SwitchInfo s = switchInfoList[i];
			vector<vector<string>> splited = splitSwitchVariable(data[s.index], s.n_bits);
			//将以行为主的拆分数据变成以列为主存的vector
			splited = colToRowReverse(splited);
			//插入header
			for(int j=0; j<s.n_bits; j++){
				string header_name = s.name + "_" + to_string(j+1);
				splited[j].insert(splited[j].begin(), header_name);

				//插入输出结果
				data_out.push_back(splited[j]);
			}		
		}

		data.erase(data.begin()+52);
		data.erase(data.begin()+(53-1));

		
		//合并原始数据 & 拆分数据到输出数据
		data_out.insert(data_out.begin(), data.begin(), data.end());

		//输出数据到csv
	
		string filename_out = getTailedPath(insertDirInPath(splitPath(filename),"out"), "_2");
		data_out = colToRowReverse(data_out);
		reader.writeData(filename_out, data_out);

	}

	
}

vector<vector<string>> DataHandler::splitSwitchVariable(vector<string> decimalList, int n_bits)
{
	vector<vector<string>> switchList;
	
	int n_row = decimalList.size();
	//跳过head
	for(int i=1; i<n_row; i++){
		vector<string> tmp = decimalToBits(stoi(decimalList[i]), n_bits);
		switchList.push_back(tmp);
	}

	return switchList;
}

//拆分一个文件中的所有开关量
void DataHandler::splitSwitchVariables(string filename, vector<SwitchInfo> switchInfoList, string tail, vector<string> removeIndexList){
	vector<vector<string>> data = reader.readData(filename);
	int n_row = data.size();
	//转换数据为列为主的vector
	data = colToRowReverse(data);

	////获得开关信息列表
	//vector<SwitchInfo> switchInfoList = getSwitchInfoList("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\itf_tcms_hxd_v20-swictInfoList.csv");
	
	//拆分每一个开关,插入输出
	vector<vector<string>> data_out;	
	int n_switch = switchInfoList.size();
	for(int i=0; i<n_switch; i++){
		SwitchInfo s = switchInfoList[i];
		vector<vector<string>> splited = splitSwitchVariable(data[s.index], s.n_bits);
		//将以行为主的拆分数据变成以列为主存的vector
		splited = colToRowReverse(splited);
		//插入header
		for(int j=0; j<s.n_bits; j++){
			string header_name = s.name + "_" + to_string(j+1);
			splited[j].insert(splited[j].begin(), header_name);

			//插入输出结果
			data_out.push_back(splited[j]);
		}
		
		////把没个开关拆分后的值放到一起
		//SwitchSplited tmp;
		//tmp.set(s, splited);
		//switchSplitedList.push_back(tmp);		
	}

	//删除原始数据中不需要的列
	//这种处理要求 index 递增
	int count=0;
	int n_rm = removeIndexList.size();
	//跳过header
	for(int i=1; i<n_rm; i++){
		int index = stoi(removeIndexList[i]);
		data.erase(data.begin()+(index-count));
		count++;
	}	 
	//int count=0;
	//for(int i=0; i<n_switch; i++){
	//	int index = switchInfoList[i].index;
	//	data.erase(data.begin()+(index-count));
	//	count++;
	//}

	//合并原始数据 & 拆分数据到输出数据
	data_out.insert(data_out.begin(), data.begin(), data.end());

	//输出数据到csv
	
	string filename_out = getTailedPath(insertDirInPath(splitPath(filename),"out"), tail);
	data_out = colToRowReverse(data_out);
	reader.writeData(filename_out, data_out);


	////遍历拆分后的数据
	//for(int i=0; i<n_switch; i++){
	//	//将header插入每一列，也就是每个vector的index=0处
	//	int n_bits = switchInfoList[i].n_bits;
	//	for(int j=0; j<n_bits; j++){
	//		vector<string> tmp = switchSplitedList[j].splited;
	//	}
	//}

}

void DataHandler::splitSwitchVariablesOfFiles(string fileDir){

	vector<SwitchInfo> switchInfoList = getSwitchInfoList("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\itf_tcms_hxd_v20-swictInfoList.csv");
	vector<string> removeIndexList = getRemoveIndexList("E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\itf_tcms_hxd_v20-removeList.csv");

	vector<string> filenameList;
	reader.readFilenameList(fileDir, filenameList);
	filenameList = reader.filenameList;

	int n_filenum = filenameList.size();
	for(int i=0; i<n_filenum; i++){
		string filename = filenameList[i];
		splitSwitchVariables(filename, switchInfoList, "_split", removeIndexList);
	}
}

vector<SwitchInfo> DataHandler::getSwitchInfoList(string filename){
	vector<vector<string>> data = reader.readData(filename);
	vector<SwitchInfo> switchInfoList;
	int n_row = data.size();
	//跳过第一行，第一行为header
	for(int i=1; i<n_row; i++){
		SwitchInfo tmp;
		tmp.set(stoi(data[i][0]),data[i][1],stoi(data[i][2]));

		switchInfoList.push_back(tmp);
	}
	
	return switchInfoList;
}

vector<vector<string>> DataHandler::colToRowReverse(vector<vector<string>> data){
	vector<vector<string>>  dataReversed;
	int n_col = data[0].size();
	int n_row = data.size();
	for(int i=0; i<n_col; i++){
		vector<string> tmp;
		for(int j=0; j<n_row; j++){
			tmp.push_back(data[j][i]);
		}
		dataReversed.push_back(tmp);
	}
	return dataReversed;
}

vector<string> DataHandler::decimalToBits(int decimal, int n_bits)
{
	vector<string> bitVector;
	int n = n_bits;//设置为n_bits位bit位

	for(int i=n-1; i>=0; i--){
		if(decimal&(1<<i))
			bitVector.push_back("1");
		else
			bitVector.push_back("0");
	}

	return bitVector;
}

	vector<string> DataHandler::getRemoveIndexList(string filename){		
		vector<vector<string>> data = reader.readData(filename);
		data = colToRowReverse(data);

		return data[0];
	}


