function [ c,f,s ] = pdeCFSca(x, t, u, Dudx)

global DaL eb c0 ep;
global R1 T w;
global tSpan nt;
global ZSpan sZ;
global cdflist
global K Dc rc pDnsty yi numx deltax p cm0  rmean M M_C o p_C eff_re F C Lc

dt=tSpan(end)/(nt-1);dx=ZSpan(end)/(sZ-1);
t_1=floor(t/dt+1);t_2=ceil(t/dt+1);
x_1=floor(x/dx+1);x_2=ceil(x/dx+1);
t_temp=t/dt+1;x_temp=x/dx+1;
adt11=cdflist(:,:,:,:,t_1,x_1);
adt12=cdflist(:,:,:,:,t_1,x_2);
adt21=cdflist(:,:,:,:,t_2,x_1);
adt22=cdflist(:,:,:,:,t_2,x_2);
if t_1==t_2 && x_1==x_2
    adt=adt11;
elseif t_1==t_2 && x_1~=x_2
    S=abs(x_1-x_2);
    S1=abs(x_temp-x_2);
    S2=abs(x_temp-x_1);
    adt=(S1*adt11+S2*adt12)/S;
elseif t_1~=t_2 && x_1==x_2
    S=abs(t_1-t_2);
    S1=abs(t_temp-t_2);
    S2=abs(t_temp-t_1);
    adt=(S1*adt11+S2*adt21)/S;
else
    S=abs(t_2-t_1)*abs(x_2-x_1);
    S11=abs(t_2-t_temp)*abs(x_2-x_temp);
    S12=abs(t_2-t_temp)*abs(x_1-x_temp);
    S21=abs(t_1-t_temp)*abs(x_2-x_temp);
    S22=abs(t_1-t_temp)*abs(x_1-x_temp);
    adt=(S11*adt11+S12*adt12+S21*adt21+S22*adt22)/S;
end

A=size(adt);
if yi==1
    adt_wt=reshape(sum(sum(adt,3),4),A(1),A(2));
elseif yi==2
    adt_wt=reshape(sum(sum(adt,2),4),A(1),A(3));
else
    adt_wt=reshape(sum(sum(adt,2),3),A(1),A(4));
end
%% 计算吸附量
i=1:numx(1);
ri=rmean+deltax(1)*(i'-(numx(1)+1)/2);
adt_m=adt_wt.*ri.^3/sum(adt_wt.*ri.^3,'all');   %计算颗粒质量分数分布
adt_r=adt_m./sum(adt_m,2);

q=zeros(numx(1),numx(yi+1)+1);
q2=zeros(numx(1),numx(yi+1)+1);
for i=1:numx(1)
    for j=1:numx(yi+1)+1
        qj=deltax(yi+1)*(j-1);
        q(i,j)=adt_r(i,j)*qj;
        q2(i,j)=adt_m(i,j)*qj;
    end
end
q_r=sum(q,2);           %不同粒径吸附量
q_m=sum(q2,'all');      %总吸附量

%% 计算平衡吸附量
ct0=zeros(size(cm0));
for i=1:1:3
    if x_1~=x_2
        ct0(:,1,i) = (cm0(:,x_1,i).*abs(x_temp-x_2)+cm0(:,x_2,i).*abs(x_temp-x_1))./abs(x_1-x_2).*c0(i);  % cm0为迭代前归一化的浓度，乘以c0还原为真实浓度,g/m3
    else
        ct0(:,1,i) = cm0(:,x_1,i).*c0(i);
    end
end
c_temp=zeros(1,3);
for jj=1:1:3
    c_temp(jj)=pchip(tSpan, ct0(:,1,jj), t); % mg/L = g/m3
end
p_e=c_temp./M.*R1.*T./1e5;           % bar
c_temp(yi)=u*c0(yi);
p_e(yi)=c_temp(yi)./M(yi).*R1.*T./1e5;
totalp=sum(p_e)+p_C;

q_e=DSL(p_e);
Dm = DmCa(p_e,p_C,M,M_C,T,o);
Dp=[1.55 0.7123 0.701].*1e-5;

ii=1:numx(1);
ri=rmean+deltax(1)*(ii-(numx(1)+1)/2);
kldf=1./K(yi)./(ri.^2./3./eff_re(yi)./Dm(yi)+ri.^2./15./ep./Dp(yi)+rc^2./15./K(yi)./Dc(yi));

%计算加权等效kldf
kldf_e=1/(sum(sum(adt_wt,2)./kldf'));
pp=kldf_e.*(q_e(yi)-q_m).*pDnsty./c0(yi);

Ld = (1 - eb)/eb;

c = 1;
f = DaL*Dudx;
% s = -w*(p(yi)/totalp)*Dudx - Ld*pp;%
s = -F/(eb*C*Lc)*Dudx - Ld*pp;% 等价于 s = -w*Dudx - Ld*pp;
end
