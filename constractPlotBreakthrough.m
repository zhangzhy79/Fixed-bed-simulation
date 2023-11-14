% S{1} = load('06-Jun-2023'); %正态分布
% S{2} = load('07-Jun-2023'); %均匀分布
% S{3} = load('09-Jun-2023'); %单一分布
S{1} = load('run-1_4-normality'); %正态分布
S{2} = load('run-1_4-uniform'); %均匀分布
S{3} = load('run-1_4-average'); %单一分布
LC = Lc*100; % cm
scale=1;
zSpan = linspace(0, LC,sZ);
z=sZ;
ca_dim_temp{1}=S{1}.CC01{end};
ca_dim_temp{2}=S{1}.CC02{end};
ca_dim_temp{3}=S{1}.CC03{end};
ca_dim_temp2{1}=S{2}.CC01{end};
ca_dim_temp2{2}=S{2}.CC02{end};
ca_dim_temp2{3}=S{2}.CC03{end};
ca_dim_temp3{1}=S{3}.CC01{end};
ca_dim_temp3{2}=S{3}.CC02{end};
ca_dim_temp3{3}=S{3}.CC03{end};

color={'b','r','k'};color2={'b-.','r-.','k-.'};color3={'b--','r--','k--'};
legstrSelect={'CO_{2}','CH_{4}','N_{2}'};
legstr=cell(size(select));
it=1;
for ii=select
    legstr{it}=legstrSelect{ii};
    it=it+1;
end

figure(3)
hold on
% if length(select)==1
%     title('Breakthrough curves for the Single-Component on binder-free zeolite 4A at 313K and 5 bar pressure');
% elseif length(select)==3
%     title('Breakthrough curves for the ternary mixture of CO_{2}/CH_{4}/N_{2} on binder-free zeolite 4A at 313K and 5 bar pressure');
% else
%     title('Breakthrough curves for the Multi-Component on binder-free zeolite 4A at 313K and 5 bar pressure');
% end

xlabel('t/min'),ylabel('C/C_{0}')
axis([0,tSpan(end)/60/scale,0,1.5])
P1=[];P2=[];P3=[];it=1;
for ii=select
    P1(it)=plot(tSpan/60,ca_dim_temp{ii}(:,z),color{ii});
    P2(it)=plot(tSpan/60,ca_dim_temp2{ii}(:,z),color2{ii}); 
    P3(it)=plot(tSpan/60,ca_dim_temp3{ii}(:,z),color3{ii});
    it=it+1;
end

lgd(1)=legend(P1,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(2)=legend(ah,P2,legstr);
ah=axes('position',get(gca,'position'),'visible','off');
lgd(3)=legend(ah,P3,legstr);
title(lgd(1),{'Normal';'distribution'});title(lgd(2),{'Uniform';'distribution'});title(lgd(3),{'Volume-';'average size'});
% set(lgd(1),'position',[0.45,0.45,0.15,0.01],'units','normalized');
% set(lgd(2),'position',[0.60,0.45,0.15,0.01],'units','normalized');
% set(lgd(3),'position',[0.75,0.45,0.15,0.01],'units','normalized');
set(lgd(1),'position',[0.50,0.85,0.15,0.01],'units','normalized');
set(lgd(2),'position',[0.65,0.85,0.15,0.01],'units','normalized');
set(lgd(3),'position',[0.80,0.85,0.15,0.01],'units','normalized');