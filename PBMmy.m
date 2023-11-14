function [qt0, xyzcdf] = PBMmy(ct0, tSpan, adone, ParametersOfPBMmy)
%adone�ǿ������ٷֱ�
% global numx deltax K c0 nt q0 T R1 M M_C p_C eff_re ep rc Dc rmean
%% ��������ߴ磬������
numx = ParametersOfPBMmy{1};
deltax = ParametersOfPBMmy{2};
K = ParametersOfPBMmy{3};
c0 = ParametersOfPBMmy{4};
nt = ParametersOfPBMmy{5};
q0 = ParametersOfPBMmy{6};
T = ParametersOfPBMmy{7};
R1 = ParametersOfPBMmy{8};
M = ParametersOfPBMmy{9};
M_C = ParametersOfPBMmy{10};
p_C = ParametersOfPBMmy{11};
eff_re = ParametersOfPBMmy{12};
ep = ParametersOfPBMmy{13};
rc = ParametersOfPBMmy{14};
Dc = ParametersOfPBMmy{15};
rmean = ParametersOfPBMmy{16};

for i=1:1:3
    ct0(:,1,i) = ct0(:,1,i).*c0(i);  % ct0Ϊ��һ����Ũ�ȣ�����c0��ԭΪ��ʵŨ��,g/m3
end

deltat=1e-1; % 1e-1s
Q=zeros(nt,3);
xyzcdf{1,nt}=[];
xyzcdf{1}=adone;

k1 = 1;
t = 0;

while (t<tSpan(nt))
    t = t + deltat;    % s
    %% ƽ������������
    cNow=zeros(1,3);
    for jj=1:1:3
        cNow(jj)=pchip(tSpan, ct0(:,1,jj), t); % mg/L
    end
    pe=cNow./M.*R1.*T./1e5;           % bar
    qe=DSL(pe);                    % mg/g
    %     �㵽����Ũ�Ⱥ�С��qe��ú�С��deltax2��С���Ӷ�deltatС
    o = [3.454 3.73 3.575 2.63];        % LJ����ƽ����루CO2��CH4��N2��He����ai
    Dm = DmCa(pe,p_C,M,M_C,T,o);
    Dp=[1.55 0.7123 0.701].*1e-5;
    
    %% ��������
    dim=4;
    adsorption_rate=cell([1 dim]);
    adsorption_rate{1}=zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1);
    ad_r=zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1);
    for yi=1:1:3
        for i=1:numx(1)
            ri=rmean+deltax(1)*(i-(numx(1)+1)/2);
            KLDF=1/K(yi)/(ri^2/3/eff_re(yi)/Dm(yi)+ri^2/15/ep/Dp(yi)+rc^2/15/K(yi)/Dc(yi));
            for j=1:numx(yi+1)+1
                qj=deltax(yi+1)*(j-1);
                if yi==1
                    ad_r(i,j,:,:)=KLDF*(qe(yi)-qj);
                elseif yi==2
                    ad_r(i,:,j,:)=KLDF*(qe(yi)-qj);
                else
                    ad_r(i,:,:,j)=KLDF*(qe(yi)-qj);
                end
            end
        end
        adsorption_rate{yi+1}=ad_r;
    end
    %%
    G_temp=zeros(1,3);
    for yi=1:1:3
        G_temp(yi)=max(abs(adsorption_rate{yi+1}),[],'all');
    end
    deltat_temp=0.6.*deltax(2:4)./G_temp;
    G=max(G_temp,[],'all');
    
    if G>0
        deltat=min(deltat_temp(deltat_temp>0),[],'all');
        if deltat>(tSpan(2)-tSpan(1))
            deltat=(tSpan(2)-tSpan(1));%����deltat����
        end
        %% ��ֵ���PB���̣��õ���һ�׶ε����ܶȺ����ֲ�adtwo
        adtwo=sd_adp(adone,adsorption_rate,deltat,deltax);
    else
        deltat=tSpan(2)-tSpan(1);
        adtwo=adone;
    end
    
    if t >= tSpan(k1+1)     %t����ʱ��ڵ������һ������������
        adtk=(adtwo*(tSpan(k1+1)-(t-deltat))+adone*(t-tSpan(k1+1)))/deltat;
        A=size(adtk);
        
        i=1:numx(1);
        ri=rmean+deltax(1)*(i'-(numx(1)+1)/2);
        %% ����CO2������
        adtk_wt=sum(sum(adtk,3),4);
        adtk_m=adtk_wt.*ri.^3/sum(adtk_wt.*ri.^3,'all');   %����������������ֲ�
        q1=zeros(numx(1),numx(2)+1);
        for i=1:numx(1)
            for j=1:numx(2)+1
                qj=deltax(2)*(j-1);
                q1(i,j)=adtk_m(i,j)*qj;
            end
        end
        Q(k1+1,1)=sum(q1,'all');
        %% ����CH4������
        adtk_wt=reshape(sum(sum(adtk,2),4),A(1),A(3));
        adtk_m=adtk_wt.*ri.^3/sum(adtk_wt.*ri.^3,'all');   %����������������ֲ�
        q2=zeros(numx(1),numx(3)+1);
        for i=1:numx(1)
            for j=1:numx(3)+1
                qj=deltax(3)*(j-1);
                q2(i,j)=adtk_m(i,j)*qj;
            end
        end
        Q(k1+1,2)=sum(q2,'all');
        %% ����N2������
        adtk_wt=reshape(sum(sum(adtk,2),3),A(1),A(4));
        adtk_m=adtk_wt.*ri.^3/sum(adtk_wt.*ri.^3,'all');   %����������������ֲ�
        q3=zeros(numx(1),numx(4)+1);
        for i=1:numx(1)
            for j=1:numx(4)+1
                qj=deltax(4)*(j-1);
                q3(i,j)=adtk_m(i,j)*qj;
            end
        end
        Q(k1+1,3)=sum(q3,'all');
        
        k1 = k1 + 1;
        xyzcdf{k1}=adtk/sum(adtk,'all');
    end
    adone=adtwo;
end

qt0 = Q./q0; %��һ��
a=size(qt0,1);
if a<nt
    qt0(a+1:nt,1)=qt0(a,1);
    qt0(a+1:nt,2)=qt0(a,2);
    qt0(a+1:nt,3)=qt0(a,3);
    for j=a+1:nt
        xyzcdf{j}=xyzcdf{a};
    end
end
end
