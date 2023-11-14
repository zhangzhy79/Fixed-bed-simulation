%adsorption curve SC
if select==1
    S{1} = load('run-1_4-normality'); %正态分布
    S{2} = load('run-1_4-uniform'); %均匀分布
    S{3} = load('run-1_4-average'); %单一分布
elseif select==2
    S{1} = load('run-1_4_2-normality'); %正态分布
    S{2} = load('run-1_4_2-uniform'); %均匀分布
    S{3} = load('run-1_4_2-average'); %单一分布
else
    S{1} = load('run-1_4_3-normality'); %正态分布
    S{2} = load('run-1_4_3-uniform'); %均匀分布
    S{3} = load('run-1_4_3-average'); %单一分布
end
qt0=S{1}.qt0(:,:,select);qt02=S{2}.qt0(:,:,select);qt03=S{3}.qt0(:,:,select);q0=S{1}.q0(select);
t1=tSpan./60;scale=[1 1 1];
tend=t1(end);
nz=21;
p11=zeros(1,1);p12=zeros(1,1);p13=zeros(1,1);p14=zeros(1,1);
p21=zeros(1,1);p22=zeros(1,1);p23=zeros(1,1);p24=zeros(1,1);
p31=zeros(1,1);p32=zeros(1,1);p33=zeros(1,1);p34=zeros(1,1);
linecolor={'b','r','k'};linecolor2={'b-.','r-.','k-.'};linecolor3={'b--','r--','k--'};
legstr={'CO_{2}','CH_{4}','N_{2}'};

figure(1);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:1
    qt0_curve=sum(qt0(:,:,k),2)./sZ;
    qt0_curve2=sum(qt02(:,:,k),2)./sZ;
    qt0_curve3=sum(qt03(:,:,k),2)./sZ;
    p11(k)=plot(t1,qt0_curve,linecolor{k});
    p21(k)=plot(t1,qt0_curve2,linecolor2{k});
    p31(k)=plot(t1,qt0_curve3,linecolor3{k});
end
axis([0,tend,0,1.05])
% subtitle('固定床整体吸附量与平衡吸附量比值-时间曲线');
lgd(1)=legend(p11,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(2)=legend(ah,p21,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(3)=legend(ah,p31,legstr{select});
title(lgd(1),'Normal distribution');title(lgd(2),'Uniform distribution');title(lgd(3),'Volume-average size');
set(lgd(1),'position',[0.67,0.75,0.23,0.11],'units','normalized');
set(lgd(2),'position',[0.67,0.64,0.23,0.11],'units','normalized');
set(lgd(3),'position',[0.67,0.53,0.23,0.11],'units','normalized');


figure(2);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:1
    qt0_curve_real=sum(qt0(:,:,k),2)./sZ*q0(k);
    qt0_curve_real2=sum(qt02(:,:,k),2)./sZ*q0(k);
    qt0_curve_real3=sum(qt03(:,:,k),2)./sZ*q0(k);
    p12(k)=plot(t1,qt0_curve_real*scale(k),linecolor{k});
    p22(k)=plot(t1,qt0_curve_real2*scale(k),linecolor2{k});
    p32(k)=plot(t1,qt0_curve_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,200])
% subtitle('固定床整体吸附量-时间曲线');
lgd(4)=legend(p12,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(5)=legend(ah,p22,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(6)=legend(ah,p32,legstr{select});
title(lgd(4),'Normal distribution');title(lgd(5),'Uniform distribution');title(lgd(6),'Volume-average size');
set(lgd(4),'position',[0.67,0.75,0.23,0.11],'units','normalized');
set(lgd(5),'position',[0.67,0.64,0.23,0.11],'units','normalized');
set(lgd(6),'position',[0.67,0.53,0.23,0.11],'units','normalized');

figure(3);hold on
xlabel('time(min)');ylabel('q/q_{0}');
for k=1:1:1
    qt0_curve_nz=qt0(:,nz,k);
    qt0_curve_nz2=qt02(:,nz,k);
    qt0_curve_nz3=qt03(:,nz,k);
    p13(k)=plot(t1,qt0_curve_nz,linecolor{k});
    p23(k)=plot(t1,qt0_curve_nz2,linecolor2{k});
    p33(k)=plot(t1,qt0_curve_nz3,linecolor3{k});
end
axis([0,tend,0,1.05])
% subtitle('固定床末端吸附量与平衡吸附量比值-时间曲线');
lgd(7)=legend(p13,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(8)=legend(ah,p23,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(9)=legend(ah,p33,legstr{select});
title(lgd(7),'Normal distribution');title(lgd(8),'Uniform distribution');title(lgd(9),'Volume-average size');
set(lgd(7),'position',[0.67,0.75,0.23,0.11],'units','normalized');
set(lgd(8),'position',[0.67,0.64,0.23,0.11],'units','normalized');
set(lgd(9),'position',[0.67,0.53,0.23,0.11],'units','normalized');

figure(4);hold on
xlabel('time(min)');ylabel('q(mg/g)');
for k=1:1:1
    qt0_curve_nz_real=qt0(:,nz,k)*q0(k);
    qt0_curve_nz_real2=qt02(:,nz,k)*q0(k);
    qt0_curve_nz_real3=qt03(:,nz,k)*q0(k);
    p14(k)=plot(t1,qt0_curve_nz_real*scale(k),linecolor{k});
    p24(k)=plot(t1,qt0_curve_nz_real2*scale(k),linecolor2{k});
    p34(k)=plot(t1,qt0_curve_nz_real3*scale(k),linecolor3{k});
end
axis([0,tend,0,200])
% subtitle('固定床末端吸附量-时间曲线');
lgd(10)=legend(p14,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(11)=legend(ah,p24,legstr{select});
ah=axes('position',get(gca,'position'),'visible','off');
lgd(12)=legend(ah,p34,legstr{select});
title(lgd(10),'Normal distribution');title(lgd(11),'Uniform distribution');title(lgd(12),'Volume-average size');
set(lgd(10),'position',[0.67,0.75,0.23,0.11],'units','normalized');
set(lgd(11),'position',[0.67,0.64,0.23,0.11],'units','normalized');
set(lgd(12),'position',[0.67,0.53,0.23,0.11],'units','normalized');
