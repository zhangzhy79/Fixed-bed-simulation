%%%% 
% surf(zSpan,tSpan,Ca); 
% colormap(hot) 
% xlabel('L'),ylabel('t'),zlabel('C/C_0') 
% axis([0,LC,0,t,0,1]) 
% view([59,22]) 
LC = Lc*100; % cm
zSpan = linspace(0, LC,sZ);
circle_time=[];
if isempty(circle_time)
    ca_dim_temp{1}=ca_dim{1};
    ca_dim_temp{2}=ca_dim{2};
    ca_dim_temp{3}=ca_dim{3};   
else
    ca_dim_temp{1}=CC01{circle_time};
    ca_dim_temp{2}=CC02{circle_time};
    ca_dim_temp{3}=CC03{circle_time};
end

scale=2;
figure(3)
for ii=1:3
    subplot(2,2,ii);
    surf(zSpan,tSpan/60,ca_dim_temp{ii});
    if ii==1
        title('CO2床层浓度图像');
    elseif ii==2
        title('CH4床层浓度图像');
    else
        title('N2床层浓度图像');
    end
    colormap(hot)
    xlabel('L/cm'),ylabel('t/min'),zlabel('C/C_0') 
    axis([0,LC,0,tSpan(end)/60/scale,0,1.5]) 
    view([80,35]) 
end

if length(select)==1
    figure(4)
    surf(zSpan,tSpan/60,ca_dim_temp{select});
%     if select==1
%         title('CO2床层浓度图像');
%     elseif select==2
%         title('CH4床层浓度图像');
%     else
%         title('N2床层浓度图像');
%     end
    colormap(hot)
    xlabel('L/cm'),ylabel('t/min'),zlabel('C/C_0') 
    axis([0,LC,0,tSpan(end)/60/scale,0,1.5]) 
    view([76,35]) 
end


 
