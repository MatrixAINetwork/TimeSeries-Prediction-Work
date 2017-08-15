function resampleDataMuil2
   %导入数据-------------------------------------------------------------------
    %filepath = 'F:\\sql_out\\20161103-所有轴温报错_1日_axleTempFault\\out\\4.remove duplication\\used to HMM\\第二波-挑选数量级上万的文件分状态';
    %filepath = 'E:\\Data_Lab\\20170104-233型-66666次-各车号运行当日数据\\out\\3. remove duplication\8000以上';
    filepath = 'E:\\Data_Lab\\20170208-tcms-cc66666-240-分天数据-所有11条\\original\\2. 删除冗余行\\out';
    filePaths = getFilelist(filepath);  
    for i = 1:length(filePaths)
        resampleData2(filePaths{i},25);
    end    
end

%针对拆分开关后合并的数据
function resampleData2(filename_in, interval)
    
    fid_in = fopen(filename_in);

    %读取表头
    headerformat = '%s';
    columnNum = 154;
    header = textscan(fid_in, headerformat, columnNum, 'Delimiter',',');
    
    %读取数据
    format_s = ' %s';
    format_d = ' %d ';
    format = '';
    for i = 1:columnNum
        format = strcat(format, format_s);
    end
    dcells = textscan(fid_in, format, 'Delimiter',',');
    fclose(fid_in);    
    
%数据处理-------------------------------------------------------------------

    %分离出时间数据+属性值数据
    data_all = dcells;
    data_time = data_all{:,1};
    data_time = datetime(data_time);
    data_attr = [data_all{:,2:154}];
    %吧data_attr转换成num
    [m n] = size(data_attr);
    for i = 1:m
        for j=1:n
            data_attr{i,j} = str2num(data_attr{i,j});
        end
    end;
    
    %利用插值重采样
    DTn = datenum(data_time);
    ti = interval*1/(24*60*60);% Time Interval
    DTiv = [DTn(1):ti:DTn(end)]';           % Interpolation Vector
    Table12 = cell2mat(data_attr);        % Vector: Column #2 Of Table1
    DT15 = interp1(DTn, Table12, DTiv);     % Interpolated Column #2
    %newTime = {datestr(DTiv, 'yyyy-mm-dd HH:MM:ss')};
    tmp2 = cellstr(datetime(datestr(DTiv, 'yyyy-mm-dd HH:MM:ss')));
    NewTable1 = {tmp2 DT15};
    Result = cell2table(NewTable1);
    
    %输出处理后的值
    mycell = Result;
    [nrows,ncols]= size(mycell{1,2}{1});
    fileSplit = regexp(filename_in, '\\', 'split');
    filename_out = filename_in(1:end-4);
    filename_out = strcat(filename_out, '_ri_', num2str(interval), '.csv');
    fid_out = fopen(filename_out, 'w');
    %输出header
    fprintf(fid_out, '%s', header{1}{1});
    [m n] = size(header{1});
    for i = 2:m
        fprintf(fid_out, ',%s', header{1}{i});
    end
    fprintf(fid_out, '\n');
    %输出值
    for row = 1:nrows
        fprintf(fid_out, '%s', mycell{1,1}{1}{row,1});%cell的第-个cell是时间cell的集合
        for i = 1:ncols
            fprintf(fid_out, ',%f', mycell{1,2}{1}(row,i));%cell的第二个cell是属性值矩阵
        end
        fprintf(fid_out, '\n');
    end
    fclose(fid_out);    
    
end

function [filePaths] = getFilelist(filepath)

    fileFolder = fullfile(filepath);
    dirOutput = dir(fullfile(fileFolder, '*.csv'));
    fileNames = {dirOutput.name};
    filePaths = fullfile(fileFolder, fileNames);    
end