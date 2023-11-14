% 拟合kth获得thomas model突破曲线
S{1} = load('run-1_4-normality'); %正态分布
S{2} = load('run-1_4-uniform'); %均匀分布
S{3} = load('run-1_4-average'); %单一分布
volume_ms = pi*Rinter^2*Lc*(1-eb);  % 吸附剂占据的空间，单位：立方米（m^3）
ms = volume_ms*pDnsty;  % 吸附剂总质量，单位：千克（kg）
colorpoint={'r.','b.','k.'};
colorline={'r','b','k'};
figure(2);hold on
for ii=1:3
    CC01{end}=S{ii}.CC01{end};
    CC02{end}=S{ii}.CC02{end};
    CC03{end}=S{ii}.CC03{end};
    Cf=[CC01{end}(:,1) CC02{end}(:,1) CC03{end}(:,1)].*c0./M;        %单位：摩尔每立方米（mol/m^3）
    Cf(1,1)=Cf(2,1);Cf(1,2)=Cf(2,2);Cf(1,3)=Cf(2,3);
    
%     Cf(:,1)=1;Cf(:,2)=0;Cf(:,3)=0;
    
    Qv=v_L(select)./60.*1e-6;       %单位：立方米每秒（m^3/s）
    C_input1=CC01{end}(:,sZ);       %归一化，无量纲
    C_input2=CC02{end}(:,sZ);       %归一化，无量纲
    C_input3=CC03{end}(:,sZ);       %归一化，无量纲
    qf=zeros(nt,3);
    for jj=1:nt
        qf(jj,:)=DSL(Cf(jj,:).*R1.*T./1e5./M);    %单位：毫克每克（mg/g）    
    end
    if select==1
        index=(C_input1>0 & C_input1<1);
        C_input1(C_input1<1e-6)=1e-6;
        C_input=C_input1.*c0(1)./M(1);      %单位：摩尔每立方米（mol/m^3）
        C0_input=C_input1;
        
    elseif select==2
        index=(C_input2>0 & C_input2<1);
        C_input2(C_input2<1e-6)=1e-6;
        C_input=C_input2.*c0(2)./M(2);      %单位：摩尔每立方米（mol/m^3）
        C0_input=C_input2;
        
    else
        index=(C_input3>0 & C_input3<1);
        C_input3(C_input3<1e-6)=1e-6;
        C_input=C_input3.*c0(3)./M(3);      %单位：摩尔每立方米（mol/m^3）
        C0_input=C_input3;
        
    end
    
    if ii==1
        b(ii)=2.3*phir/rmean;
    elseif ii==2
        b(ii)=3.2*phir/rmean;
    else
        b(ii)=0.25;
    end
    Ct=Cf(:,select)./C_input-1;
%     Ct=1./C0_input-1;
    Ct1=Ct;
    Ct(Ct<1e-5)=1e-5;
    kth=log(Ct)./(qf(:,select).*ms./M(select)./Qv-Cf(:,select).*(tSpan'./(1+b(ii))));
    
%     kth_0=kth(index);
%     kth_0=kth(10:90);
    kth_0=kth;
%     kth_hat=mean(kth_0(40));
    kth_hat=kth(find(C_input./c0(select).*M(select)>0.6,1,'first'));
    Kth(ii)=kth_hat;

%     C_hat=1./(1+exp(kth_hat.*qf(:,select).*ms./M(select)./Qv-kth_hat.*Cf(:,select).*tSpan'));
    C_hat=1./(1+exp(kth_hat.*mean(qf(:,select)).*ms./M(select)./Qv-kth_hat.*mean(Cf(:,select)).*(tSpan'./(1+b(ii)))));
    
    plot(tSpan./60,C_hat,colorline{ii});
    
    plot(tSpan./60,C_input./c0(select).*M(select),colorpoint{ii});
end
