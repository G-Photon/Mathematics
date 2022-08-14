%% ���ݵ��뼰����
clc, clear all, close all
A=xlsread('��ָ��.xls','���Ѿ�ָ�����', 'C3:J29');% �����Ѿ�
%A=xlsread('��ָ��.xls','���Ѿ�ָ�����', 'C33:J60');% �����Ѿ�
% �����Ѿ�������������
 B=[65.4	77.15	77.5	69.9	72.7	69.25	68.4	69.15	79.85	71.5	65.85	61.1	71.7	72.8	62.2	72.4	76.9	62.65	75.6	77.51111111	74.65	74.4	81.35	74.75	68.7	72.9	72.25]; 
% �����Ѿ�������������
% B=[79.95	75	76.90555556	78.15	76.25	71.95	75.85	71.33333333	76.65	77.05	71.85	67.85	69.9	74.55	75.4	70.65	79.55	74.9	74.3	77.2	77.8	75.2	76.65	74.7	78.3	77.8	70.9	72.2];
%  ���ݱ�׼������
a=size(A,1);  
b=size(A,2);  
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i)); 
end
 
%% �������ϵ�����������ֵ����������
CM=corrcoef(SA);  % �������ϵ������(correlation matrix)
[V, D]=eig(CM);  % ��������ֵ����������
 
for j=1:b
    DS(j,1)=D(b+1-j, b+1-j); % ������ֵ�������������
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1)); %������
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1)); %�ۻ�������
end
 
%% ѡ�����ɷּ���Ӧ����������
T=0.8;  % ���ɷ���Ϣ������.
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end
 
% ��ȡ���ɷֶ�Ӧ����������
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

%%  ��������۶�������ɷֵ÷�
new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score, total_score]; % �������ɷֵ÷����ַܷ���ͬһ��������
result_report=sortrows(result_report,(K+2)); % ���ֽܷ�������

%% ��k-Means���෨ȷ����ѵľ�����
A=result_report(:,(K+1));
A=[A,B'];
X=A;
numC=7;
for i=1:numC
    kidx = kmeans(X,i);
    silh = silhouette(X,kidx); %��������ֵ
    silh_m(i) = mean(silh);    %����ƽ������ֵ
end

figure
plot(1:numC,silh_m,'ko-', 'linewidth',2)
set(gca,'linewidth',2);
xlabel('�����')
ylabel('ƽ������ֵ')
title(' ��ͬ����Ӧ��ƽ������ֵ')

% ����2��5��ʱ������ֵ�ֲ�ͼ
 figure
 set(gca,'linewidth',2);
for i=2:5
    kidx = kmeans(X,i);
    subplot(2,2,i-1);
    [~,h] = silhouette(X,kidx);
    set(gca,'linewidth',2);
    title([num2str(i), '��ʱ������ֵ ' ])
    snapnow
    xlabel('����ֵ');
    ylabel('�����');
end

%% Kmeans���༰�������
figure
[idx,ctr]=kmeans(A,3,'dist','sqEuclidean');
[m,n]=size(A);
t1=ones(1,n)*30;
c1=find(idx==1); c2=find(idx==2); c3=find(idx==3);
h=plot(A(idx==1),A(idx==1,2),'k--*', A(idx==2),A(idx==2,2),'k--s', A(idx==3),A(idx==3,2),'k--d');
xlabel('���ɷֵ÷�','fontsize',12);
ylabel('������������','fontsize',12);
title('�����Ѿ���ָ�����ͼ','fontsize',12)
set(h, 'MarkerSize',8, 'MarkerFaceColor','k');
set(gca,'linewidth',2) ;
 
disp('���ɷֵ÷�(���1��Ϊ������ţ�������2��Ϊ�ܷ֣�ǰ��Ϊ�����ɷֵ÷�)')
result_report  
disp('��������');
disp(['��1��:' ,'���ĵ㣺',num2str(ctr(1)),'  ','������Ʒ��ţ�', num2str(c1')]);
disp(['��2��:' ,'���ĵ㣺',num2str(ctr(2)),'  ','������Ʒ��ţ�', num2str(c2')]);
disp(['��3��:' ,'���ĵ㣺',num2str(ctr(3)),'  ','������Ʒ��ţ�', num2str(c3')]);