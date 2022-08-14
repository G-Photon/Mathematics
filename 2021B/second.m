clc, clear all, close all
%% 导入B组
x=xlsread('B组/B组.xlsx','sheet1','A2:E41');
yicun=xlsread('B组/B组.xlsx','sheet1','F2:F41');
c4=xlsread('B组/B组.xlsx','sheet1','G2:G41');
%% 导入A组
%x=xlsread('整理后.xlsx', '自变量1','A2:E75');
%x=[x(1:54,:);x(60:end,:)];
%yicun=xlsread('整理后.xlsx', '因变量1','A2:A75');
%yicun=[yicun(1:54,:);yicun(60:end,:)];
%c4=xlsread('整理后.xlsx', '因变量1','B2:B75');
%c4=[c4(1:54,:);c4(60:end,:)];
%y=[yicun,c4];
%% 归一化
t=x';
t=mapminmax(t,0,1);
x=t';
%% 二次型
xx=x;
for i=1:4
    for j=i+1:5
        tem=x(:,i).*x(:,j);
        xx=[xx,tem];
    end
end
for i=1:5
    tem=x(:,i).*x(:,i);
    xx=[xx,tem];
end
%% 计算
stepwise(xx,yicun)
stepwise(xx,c4)