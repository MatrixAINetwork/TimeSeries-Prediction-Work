%Time = datetime(allAxisTemperaturemerge21(1:end,49));

tmp = x163_0151_2016_06_30_80_allAxisTemperature_merge2_1;
t = tmp(1:end,49);
time = datetime(t);
data = [tmp(1:end,1:48) tmp(1:end,50:69)];
%time_table = timetable(time, data(1:end,1));

DTn = datenum(time);
ti = 10/(24*60*60);% Time Interval
DTiv = [DTn(1):ti:DTn(end)]';           % Interpolation Vector
Table12 = cell2mat(data);        % Vector: Column #2 Of Table1
DT15 = interp1(DTn, Table12, DTiv);     % Interpolated Column #2
%newTime = {datestr(DTiv, 'yyyy-mm-dd HH:MM:ss')};
tmp2 = cellstr(datetime(datestr(DTiv, 'yyyy-mm-dd HH:MM:ss')));
NewTable1 = {tmp2 DT15};
Result = cell2table(NewTable1);

%Result = [NewTable1{1} repmat(' ', size(NewTable1{2})) num2str(NewTable1{2}, '%.5f ')];

% [m,n] = size(DT15);
% x = 1:1:m;
% plot(x,DT15(:,1),'r',x, cell2mat(data(:,1)), 'b')

%csvwrite('163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv',Result);

mycell = Result;
[nrows,ncols]= size(mycell{1,2}{1});
filename = '163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv';
fid = fopen(filename, 'w');
for row = 1:nrows
    fprintf(fid, '%s', mycell{1,1}{1}{row,1});%cell的第-个cell是时间cell的集合
    for i = 1:ncols
        fprintf(fid, ',%d', mycell{1,2}{1}(row,i));%cell的第二个cell是属性值矩阵
    end
    fprintf(fid, '\n');
end
fclose(fid);