%% 数据导入及处理
clc, clear all, close all
%A=xlsread('理化指标.xls','葡萄酒指标汇总', 'B3:J29');% 红葡萄酒
%B=xlsread('理化指标.xls','酿酒葡萄指标汇总', 'C3:AF29');% 红葡萄酒
A=xlsread('理化指标.xls','葡萄酒指标汇总', 'B33:J60');% 白葡萄酒
B=xlsread('理化指标.xls','酿酒葡萄指标汇总', 'C34:AF61');% 白葡萄酒
B=B(:,all(~isnan(B),1));
%%逐步回归法
stepwise(B,A(:,3)%可更改因变量
