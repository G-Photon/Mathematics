clc, clear all, close all
A=xlsread('题面\附件2.xlsx', '稳定性测试','A4:H10');% 红葡萄酒
fid=fopen(['第一题2\','方程及R方.txt'],'w');%写入文件路径
name=["乙醇转化率(%)","乙烯选择性","C4烯烃选择性","乙醛选择性","碳数为4-12脂肪醇","甲基苯甲醛和甲基苯甲醇","其他"];
t=A(:,1);
for i=1:7
    y=A(:,i+1);
    [f,R]=fit(t,y,'poly2');
    fprintf(fid,'%s',name(i)+": ");
    fprintf(fid,'%s',"y = "+f.p1+"*x^2 +"+f.p2+"*x +"+f.p3+" rsquare: ");
    fprintf(fid,"%4f\n",R.rsquare);
    figure
    hold on
    title(name(i))
    scatter(t,y);
    plot(f);
    xlabel("t(时间)");
    ylabel(name(i));
    saveas(i, "第一题2\"+name(i)+".png")
end
fclose(fid);
F=[A(:,4),A(:,3),A(:,5:8)];
F=corr(F);
name1=[name(3),name(2),name(4:7)];
h = heatmap(name1,name1,F, 'FontSize',10);
colormap("summer")
saveas(1, "第一题2\C4烯烃热力图.png")