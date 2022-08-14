%% 数据导入及处理
clc, clear all, close all
A=xlsread('理化指标.xls','葡萄酒指标汇总', 'C3:J29');% 红葡萄酒
%A=xlsread('理化指标.xls','酿酒葡萄指标汇总', 'C3:AF29');% 红葡萄酒
%A=xlsread('理化指标.xls','酿酒葡萄指标汇总', 'C34:AF61');% 白葡萄酒
%A=xlsread('理化指标.xls','葡萄酒指标汇总', 'C33:J60');% 白葡萄酒
% 红葡萄酒质量评分数据
 B=[65.4	77.15	77.5	69.9	72.7	69.25	68.4	69.15	79.85	71.5	65.85	61.1	71.7	72.8	62.2	72.4	76.9	62.65	75.6	77.51111111	74.65	74.4	81.35	74.75	68.7	72.9	72.25]; 
% 白葡萄酒质量评分数据
% B=[79.95	75	76.90555556	78.15	76.25	71.95	75.85	71.33333333	76.65	77.05	71.85	67.85	69.9	74.55	75.4	70.65	79.55	74.9	74.3	77.2	77.8	75.2	76.65	74.7	78.3	77.8	70.9	72.2];
%  数据标准化处理
a=size(A,1);  
b=size(A,2);  
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i)); 
end
 
%% 计算相关系数矩阵的特征值和特征向量
CM=corrcoef(SA);  % 计算相关系数矩阵(correlation matrix)
[V, D]=eig(CM);  % 计算特征值和特征向量
 
for j=1:b
    DS(j,1)=D(b+1-j, b+1-j); % 对特征值按降序进行排序
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1)); %贡献率
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1)); %累积贡献率
end
 
%% 选择主成分及对应的特征向量
T=0.8;  % 主成分信息保留率.
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end
 
% 提取主成分对应的特征向量
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

%%  计算各评价对象的主成分得分
new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score, total_score]; % 将各主成分得分与总分放在同一个矩阵中
result_report=sortrows(result_report,(K+2)); % 按总分降序排序
%%  分析是否相关
data=[total_score(:,1),B'];
corr(data)