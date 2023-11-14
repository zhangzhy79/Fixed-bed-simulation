% 拟合b0,b1获得thomas model突破曲线
S{1} = load('run-1_4-normality'); %正态分布
S{2} = load('run-1_4-uniform'); %均匀分布
S{3} = load('run-1_4-average'); %单一分布
colorpoint={'r.','b.','k.'};
colorline={'r','b','k'};
figure(3);hold on
for ii=1:3
    CC01{end}=S{ii}.CC01{end};
    CC02{end}=S{ii}.CC02{end};
    CC03{end}=S{ii}.CC03{end};
    Cf=[CC01{end}(:,1) CC02{end}(:,1) CC03{end}(:,1)].*c0./M;        %单位：摩尔每立方米（mol/m^3）
    Cf(1,1)=Cf(2,1);
    C_input1=CC01{end}(:,sZ);       %归一化，无量纲
    C_input2=CC02{end}(:,sZ);       %归一化，无量纲
    C_input3=CC03{end}(:,sZ);       %归一化，无量纲

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
    Ct=Cf(:,select)./C_input-1;
%     Ct=1./C0_input-1;
    Ct1=Ct;
    Ct=Ct(4:find(C0_input>=0.9,1,'first'));
    index2=Ct<=Ct(1);
    Ct(Ct<1e-5)=1e-5;
    
    Y=log(Ct(index2));
    A=[ones(sum(index2),1) tSpan(index2')'];
%     A=[ones(sum(index2),1) tSpan(index2')' (tSpan(index2').^2)'];
    b_hat=(A'*A)\A'*Y;
    
    C_hat=1./(1+exp(b_hat(1)+b_hat(2).*tSpan'));
%     C_hat=1./(1+exp(b_hat(1)+b_hat(2).*tSpan'+b_hat(3).*(tSpan.^2)'));
    
    plot(tSpan./60,C_hat,colorline{ii});
    
    plot(tSpan./60,C_input./c0(select).*M(select),colorpoint{ii});
    axis([0 40 0 1])
end