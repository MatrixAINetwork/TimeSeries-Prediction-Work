////代码的目的就是验证makefile中oracle的头文件和lib文件路径是否正确了
//#include <iostream>
//#define WIN32COMMON //避免函数重定义错误
//#include <occi.h>
//using namespace std;
//using namespace oracle::occi;
//int main()
//{
//  Environment *env=Environment::createEnvironment();
//  cout<<"success"<<endl;
//  string name = "xxx";
//  string pass = "xxx";
//  string srvName = "xxx";
//
//  try
//  {
//    Connection *conn = env->createConnection("bsm3", "bsm3", "BSM3");
//    cout<<"conn success"<<endl;
//    env->terminateConnection(conn);
//  }a
//  catch(SQLException e)
//  {
//    cout<<e.what()<<endl;
//    system("pause");
//    return -1;
//  }
//
//  Environment::terminateEnvironment(env);
//  cout<<"end!"<<endl;
//  system("pause");
//  return 0;
//
//}