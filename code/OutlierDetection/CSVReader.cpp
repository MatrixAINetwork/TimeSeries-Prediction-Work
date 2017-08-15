#include "stdafx.h"
#include "commonheader.h"
#include "CSVReader.h"
#include <io.h>

vector<vector<string>> CSVReader::readData(string filename)
{

	cout << "INFO:读取文件:" << filename <<endl;

	data.clear();

	string value = "";

	ifstream file(filename);
	
	//get the header
	if(file.good()){
		getline(file, value);
	}
	string pattern = ",";
	vector<string> header = util.split(value, pattern);
	data.push_back(header);

	vector<string> data_tmp;
	while (file.good())
	{
		getline(file, value);

		if(value != ""){
			//cout << "value = \"\"" <<endl;
			data_tmp.clear();
			data_tmp = util.split(value, pattern);			
			data.push_back(data_tmp);
		}
	}

	cout << "INFO: Reading finished..." <<endl;

	return data;
}

vector<vector<string>> CSVReader::getData()
{
	return data;
}

void CSVReader::readFilenameList(string filepath, vector<string> filenameList)
{
	cout<<"INFO:获得路径下的csv文件列表"<<endl;

	//文件句柄  
    long   hFile   =   0;  

    //文件信息  
    struct _finddata_t fileinfo;  
    string p;  
    if((hFile = _findfirst(p.assign(filepath).append("\\*").c_str(),&fileinfo)) !=  -1)  
    {  
        do  
        {  
            //如果是目录,迭代之  
            //如果不是,加入列表  
            if((fileinfo.attrib &  _A_SUBDIR))  
            {  
				//子目录不管
                //if(strcmp(fileinfo.name,".") != 0  &&  strcmp(fileinfo.name,"..") != 0)  
				//	readFilenameList( p.assign(filepath).append("\\").append(fileinfo.name), filenameList);  
            }  
            else  
            {  
				//是csv文件则加入文件到列表
				string name_tmp = fileinfo.name;				
				string str_tmp = name_tmp.substr(name_tmp.find_last_of('.'),4);
				if(str_tmp == ".csv")
					filenameList.push_back(p.assign(filepath).append("\\").append(fileinfo.name) );  
            }  
        }while(_findnext(hFile, &fileinfo)  == 0);  
        _findclose(hFile);  
    }  

	CSVReader::filenameList = filenameList;
}

void CSVReader::writeData(string filename, vector<vector<string>> data_out)
{
	ofstream file(filename);

	if(NULL == file)
		return;

	try
	{

		string comma = ",";
		for(int i=0; i<data_out.size(); i++)
		{
			string str_tmp = data_out[i][0];
			for(int j=1; j<data_out[0].size(); j++)
			{			
				str_tmp = str_tmp + comma + data_out[i][j];

				//test
				//cout << str_tmp << "->" << i << "," << j <<endl;
			}

			file << str_tmp <<endl;
			//file.write(str_tmp.data(), );
		}

		file.close();

	}catch(const char* s){
		cout << "error..." <<endl;
	}
}