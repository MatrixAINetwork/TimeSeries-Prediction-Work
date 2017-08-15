#include "commonheader.h"
#include <sstream>

class HelpUtil
{
public:
	string merge(vector<string> list);
	vector<string> split(string str, string pattern);	
	int hex_to_decimal(const char* szHex, int len);

	void int2str(const int &int_temp,string &string_temp)  
	{  
        stringstream stream;  
        stream<<int_temp;  
        string_temp=stream.str();   //此处也可以用 stream>>string_temp  
	} 

	bool ifNotDirCreate(string path);
private:
	int hex_char_value(char c);

};