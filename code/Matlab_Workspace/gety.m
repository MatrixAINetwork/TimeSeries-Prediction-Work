function [ y ] = gety( x, gzsj)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

%time是处理后只有时分秒信息的时间
%data是对应时间下的数据

for i=1:length(x)
    for j=1:length(gzsj)
        if x(i) == gzsj(j)
            y(i) = 300;
            break;
        else
            y(i) = 0;
        end;
    end;
end;



end

