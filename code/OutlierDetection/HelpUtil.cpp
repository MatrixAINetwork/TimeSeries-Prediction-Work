#include "stdafx.h"
#include "helputil.h"
#include <io.h>
#include <direct.h>

bool HelpUtil::ifNotDirCreate(string path){
	int ftype = _access(path.c_str(),0);
	if(0==ftype) return true;
	else
	{
		//mkdir(path.c_str());
		return false;
	}
}

string HelpUtil::merge(vector<string> list)
{
	string result = "";
	for(int i=0; i<list.size()-1; i++)
	{
		result = result + list[i] + "\\";
	}
	result = result + list[list.size()-1];
	return result;
}
vector<string> HelpUtil::split(string str, string pattern)
{
	string::size_type pos;
	vector<string> result;
	int size = str.size();
	str+=pattern;

	for(int i=0; i<size; i++)
	{
		pos = str.find(pattern, i);
		if(pos <= size)
		{
			string s = str.substr(i, pos-i);
			//³ýÈ¥Ê×Î²ÒýºÅ
			s.erase(0,s.find_first_not_of("\""));  
			s.erase(s.find_last_not_of("\"") + 1);  

			result.push_back(s);
			i = pos + pattern.size() - 1;
		}
	}
	
	return result;
}

int HelpUtil::hex_char_value(char c)
{
	if(c >= '0' && c <= '9')
		return c - '0';
	else if(c >= 'a' && c <= 'f')
		return (c - 'a' + 10);
	else if(c >= 'A' && c <= 'F')
		return (c - 'A' + 10);

    return 0;
}
int HelpUtil::hex_to_decimal(const char* szHex, int len)
{
	int result = 0;
	for(int i=0; i<len; i++)
	{
		result += (int)pow((float)16, (int)len-i-1) * hex_char_value(szHex[i]); 
	}

	return result;
}