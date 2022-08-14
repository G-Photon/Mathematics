x=xlsread("数据\原油数据.xlsx","Sheet1","B19:F70");
y=xlsread("数据\原油数据.xlsx","Sheet1","K19:K70");
x1=xlsread("数据\原油数据.xlsx","Sheet1","B1:F18");
y1=xlsread("数据\原油数据.xlsx","Sheet1","K1:K18");
t2=17:-1:0;
t2=t2+52;
t1=52:-1:1;
F=[x,y];
F=corr(F);
name1=["美元指数","MSCI全球指数","标准普尔500指数","原油产量","总交易量","平均价格"];
h = heatmap(name1,name1,F, 'FontSize',10);
colormap("summer")
saveas(1, "热力图.png")
y1=[y1;y(1)]
figure
hold on
plot(t1,y)
ylabel("原油价格")
plot(t2,y1)