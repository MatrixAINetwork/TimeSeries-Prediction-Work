function dataFeature
    filepath = 'E:\\Matlab_Workspace\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv';
    fid_in = fopen(filepath);
    
    %读取表头
    headerformat = '%s';
    columnNum = 69;
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
    
    %分离出时间数据+属性值数据
    data_all = dcells;
    data_time = data_all{:,1};
    data_time = datetime(data_time);
    data_attr = [data_all{:,2:69}];
    %吧data_attr转换成num
    [m n] = size(data_attr);
    for i = 1:m
        for j=1:n
            data_attr{i,j} = str2num(data_attr{i,j});
        end
    end;
    
    %画功率图
    for i=1:n
        wn = [data_attr{:,i}];
        Pxx=10*log10(abs(fft(wn).^2)/m);
        f=(0:length(Pxx)-1)/length(Pxx)
        figure(1);
        plot(f,Pxx);
        xlabel('频率');
        ylabel('功率（dB）');
        title('周期图法');
        grid on;
    end;
    
    
end