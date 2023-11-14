%adsorption curve
S{1} = load('06-Jun-2023'); %正态分布
S{2} = load('07-Jun-2023'); %均匀分布
S{3} = load('09-Jun-2023'); %单一分布
qt0=S{1}.qt0;qt02=S{2}.qt0;qt03=S{3}.qt0;q0=S{1}.q0;
t1=tSpan./60;scale=[1 1 1];
tend=t1(end);
nz=21;
p11=zeros(1,3);p12=zeros(1,3);p13=zeros(1,3);p14=zeros(1,3);
p21=zeros(1,3);p22=zeros(1,3);p23=zeros(1,3);p24=zeros(1,3);
p31=zeros(1,3);p32=zeros(1,3);p33=zeros(1,3);p34=zeros(1,3);
linecolor={'b','r','k'};linecolor2={'b-.','r-.','k-.'};linecolor3={'b--','r--','k--'};
legstr={'CO_{2}','CH_{4}','N_{2}'};
figure(1)

subplot(2,2,1);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:3
    qt0_curve=sum(qt0(:,:,k),2)./sZ;
    qt0_curve2=sum(qt02(:,:,k),2)./sZ;
    qt0_curve3=sum(qt03(:,:,k),2)./sZ;
    p11(k)=plot(t1,qt0_curve,linecolor{k});
    p21(k)=plot(t1,qt0_curve2,linecolor2{k});
    p31(k)=plot(t1,qt0_curve3,linecolor3{k});
end
axis([0,tend,0,3])
subtitle('固定床整体吸附量与平衡吸附量比值-时间曲线');
lgd(1)=legend(p11,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(2)=legend(ah,p21,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(3)=legend(ah,p31,legstr);
title(lgd(1),'正态分布');title(lgd(2),'均匀分布');title(lgd(3),'体积平均');
set(lgd(1),'position',[0.34,0.83,0.01,0.01],'units','normalized');
set(lgd(2),'position',[0.38,0.83,0.01,0.01],'units','normalized');
set(lgd(3),'position',[0.42,0.83,0.01,0.01],'units','normalized');


subplot(2,2,2);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:3
    qt0_curve_real=sum(qt0(:,:,k),2)./sZ*q0(k);
    qt0_curve_real2=sum(qt02(:,:,k),2)./sZ*q0(k);
    qt0_curve_real3=sum(qt03(:,:,k),2)./sZ*q0(k);
    p12(k)=plot(t1,qt0_curve_real*scale(k),linecolor{k});
    p22(k)=plot(t1,qt0_curve_real2*scale(k),linecolor2{k});
    p32(k)=plot(t1,qt0_curve_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,180])
subtitle('固定床整体吸附量-时间曲线');
lgd(4)=legend(p12,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(5)=legend(ah,p22,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(6)=legend(ah,p32,legstr);
title(lgd(4),'正态分布');title(lgd(5),'均匀分布');title(lgd(6),'体积平均');
set(lgd(4),'position',[0.78,0.83,0.01,0.01],'units','normalized');
set(lgd(5),'position',[0.82,0.83,0.01,0.01],'units','normalized');
set(lgd(6),'position',[0.86,0.83,0.01,0.01],'units','normalized');

subplot(2,2,3);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:3
    qt0_curve_nz=qt0(:,nz,k);
    qt0_curve_nz2=qt02(:,nz,k);
    qt0_curve_nz3=qt03(:,nz,k);
    p13(k)=plot(t1,qt0_curve_nz,linecolor{k});
    p23(k)=plot(t1,qt0_curve_nz2,linecolor2{k});
    p33(k)=plot(t1,qt0_curve_nz3,linecolor3{k});
end
axis([0,tend,0,4])
subtitle('固定床末端吸附量与平衡吸附量比值-时间曲线');
lgd(7)=legend(p13,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(8)=legend(ah,p23,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(9)=legend(ah,p33,legstr);
title(lgd(7),'正态分布');title(lgd(8),'均匀分布');title(lgd(9),'体积平均');
set(lgd(7),'position',[0.34,0.35,0.01,0.01],'units','normalized');
set(lgd(8),'position',[0.38,0.35,0.01,0.01],'units','normalized');
set(lgd(9),'position',[0.42,0.35,0.01,0.01],'units','normalized');


subplot(2,2,4);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:3
    qt0_curve_nz_real=qt0(:,nz,k)*q0(k);
    qt0_curve_nz_real2=qt02(:,nz,k)*q0(k);
    qt0_curve_nz_real3=qt03(:,nz,k)*q0(k);
    p14(k)=plot(t1,qt0_curve_nz_real*scale(k),linecolor{k});
    p24(k)=plot(t1,qt0_curve_nz_real2*scale(k),linecolor2{k});
    p34(k)=plot(t1,qt0_curve_nz_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,175])
subtitle('固定床末端吸附量-时间曲线');
lgd(10)=legend(p14,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(11)=legend(ah,p24,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(12)=legend(ah,p34,legstr);
title(lgd(10),'正态分布');title(lgd(11),'均匀分布');title(lgd(12),'体积平均');
set(lgd(10),'position',[0.78,0.35,0.01,0.01],'units','normalized');
set(lgd(11),'position',[0.82,0.35,0.01,0.01],'units','normalized');
set(lgd(12),'position',[0.86,0.35,0.01,0.01],'units','normalized');

%单张图像
figure(2);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:3
    qt0_curve=sum(qt0(:,:,k),2)./sZ;
    qt0_curve2=sum(qt02(:,:,k),2)./sZ;
    qt0_curve3=sum(qt03(:,:,k),2)./sZ;
    p11(k)=plot(t1,qt0_curve,linecolor{k});
    p21(k)=plot(t1,qt0_curve2,linecolor2{k});
    p31(k)=plot(t1,qt0_curve3,linecolor3{k});
end
axis([0,tend,0,3])
% title('固定床整体吸附量与平衡吸附量比值-时间曲线');
lgd(1)=legend(p11,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(2)=legend(ah,p21,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(3)=legend(ah,p31,legstr);
title(lgd(1),{'Normal';'distribution'});title(lgd(2),{'Uniform';'distribution'});title(lgd(3),{'Volume-';'average size'});
set(lgd(1),'position',[0.45,0.75,0.15,0.01],'units','normalized');
set(lgd(2),'position',[0.60,0.75,0.15,0.01],'units','normalized');
set(lgd(3),'position',[0.75,0.75,0.15,0.01],'units','normalized');


figure(3);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:3
    qt0_curve_real=sum(qt0(:,:,k),2)./sZ*q0(k);
    qt0_curve_real2=sum(qt02(:,:,k),2)./sZ*q0(k);
    qt0_curve_real3=sum(qt03(:,:,k),2)./sZ*q0(k);
    p12(k)=plot(t1,qt0_curve_real*scale(k),linecolor{k});
    p22(k)=plot(t1,qt0_curve_real2*scale(k),linecolor2{k});
    p32(k)=plot(t1,qt0_curve_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,180])
% title('固定床整体吸附量-时间曲线');
lgd(4)=legend(p12,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(5)=legend(ah,p22,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(6)=legend(ah,p32,legstr);
title(lgd(4),{'Normal';'distribution'});title(lgd(5),{'Uniform';'distribution'});title(lgd(6),{'Volume-';'average size'});
set(lgd(4),'position',[0.45,0.70,0.15,0.01],'units','normalized');
set(lgd(5),'position',[0.60,0.70,0.15,0.01],'units','normalized');
set(lgd(6),'position',[0.75,0.70,0.15,0.01],'units','normalized');

figure(4);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:3
    qt0_curve_nz=qt0(:,nz,k);
    qt0_curve_nz2=qt02(:,nz,k);
    qt0_curve_nz3=qt03(:,nz,k);
    p13(k)=plot(t1,qt0_curve_nz,linecolor{k});
    p23(k)=plot(t1,qt0_curve_nz2,linecolor2{k});
    p33(k)=plot(t1,qt0_curve_nz3,linecolor3{k});
end
axis([0,tend,0,4])
% title('固定床末端吸附量与平衡吸附量比值-时间曲线');
lgd(7)=legend(p13,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(8)=legend(ah,p23,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(9)=legend(ah,p33,legstr);
title(lgd(7),{'Normal';'distribution'});title(lgd(8),{'Uniform';'distribution'});title(lgd(9),{'Volume-';'average size'});
set(lgd(7),'position',[0.45,0.75,0.15,0.01],'units','normalized');
set(lgd(8),'position',[0.60,0.75,0.15,0.01],'units','normalized');
set(lgd(9),'position',[0.75,0.75,0.15,0.01],'units','normalized');


figure(5);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:3
    qt0_curve_nz_real=qt0(:,nz,k)*q0(k);
    qt0_curve_nz_real2=qt02(:,nz,k)*q0(k);
    qt0_curve_nz_real3=qt03(:,nz,k)*q0(k);
    p14(k)=plot(t1,qt0_curve_nz_real*scale(k),linecolor{k});
    p24(k)=plot(t1,qt0_curve_nz_real2*scale(k),linecolor2{k});
    p34(k)=plot(t1,qt0_curve_nz_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,175])
% title('固定床末端吸附量-时间曲线');
lgd(10)=legend(p14,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(11)=legend(ah,p24,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(12)=legend(ah,p34,legstr);
title(lgd(10),{'Normal';'distribution'});title(lgd(11),{'Uniform';'distribution'});title(lgd(12),{'Volume-';'average size'});
set(lgd(10),'position',[0.45,0.70,0.15,0.01],'units','normalized');
set(lgd(11),'position',[0.60,0.70,0.15,0.01],'units','normalized');
set(lgd(12),'position',[0.75,0.70,0.15,0.01],'units','normalized');