clc, clear all, close all
A=xlsread('题面\附件1.xlsx', '性能数据表','C2:J115');
index=find(A(:,1)==250);
index=[index;115];
name=["A1","A2","A3","A4","A5","A6","A7","A8","A9","A10","A11","A12","A13","A14","B1","B2","B3","B4","B5","B6","B7"];
fid=fopen(['第一题1\','方程及R方.txt'],'w');%写入文件路径
for i= 1:21
    l=index(i);
    r=index(i+1)-1;
    B=A(l:r,:);
    T=B(:,1);
    yicun=B(:,2);
    C4=B(:,4);
    [f1,R1]=fit(T,yicun,'poly2');
    [f2,R2]=fit(T,C4,'poly2');
    fprintf(fid,'%s',"乙醇转化率(%): ");
    fprintf(fid,'%s',"y1 = "+f1.p1+"*x^2 +"+f1.p2+"*x +"+f1.p3+" rsquare: ");
    fprintf(fid,"%4f\n",R1.rsquare);
    fprintf(fid,'%s',"C4烯烃选择性(%): ");
    fprintf(fid,'%s',"y2 = "+f2.p1+"*x^2 +"+f2.p2+"*x +"+f2.p3+" rsquare: ");
    fprintf(fid,"%4f\n",R2.rsquare);
    figure
    subplot(2,1,1)
    hold on
    title(name(i))
    scatter(T,yicun);
    plot(f1);
    xlabel("T(温度)");
    ylabel("乙醇转化率(%)");
    subplot(2,1,2)
    hold on
    scatter(T,C4);
    plot(f2);
    xlabel("T(温度)");
    ylabel("C4烯烃选择性(%)");
    saveas(i, "第一题1\"+name(i)+".png")
end
fclose(fid);     
