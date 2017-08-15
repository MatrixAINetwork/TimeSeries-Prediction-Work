#pragma once
#include "commonheader.h"
#include "helputil.h"

class CSVReader{
public:
	vector<vector<string>> data;
	vector<string> filenameList;
	HelpUtil util;

public:
	vector<vector<string>> readData(string filename);
	void writeData(string filename, vector<vector<string>> data_out);
	vector<vector<string>> getData();

//help function
public:
	void readFilenameList(string filepath, vector<string> filenameList);

};