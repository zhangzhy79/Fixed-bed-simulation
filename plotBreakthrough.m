LC = Lc*100; % cm
zSpan = linspace(0, LC,sZ);
n=length(CC01);
f1=[];z=sZ;

select=1;

if select==1
    for circle_z=1:sZ
        ca_dim_temp{1}=CC01{end};
        ca_dim_temp{2}=CC02{end};
        ca_dim_temp{3}=CC03{end};
        scale=1;
        figure(2)
        delete(f1);
        for ii=1:3
            subplot(2,2,ii);
            plot(tSpan/60,ca_dim_temp{ii}(:,circle_z))
            xlabel('t/min'),ylabel('C/C_0')
            axis([0,tSpan(end)/60/scale,0,1.5])
            subplot(2,2,4);
            hold on
            f1(ii)=plot(tSpan/60,ca_dim_temp{ii}(:,circle_z));
            xlabel('t/min'),ylabel('C/C_0')
            axis([0,tSpan(end)/60/scale,0,1.5])
        end
        subplot(2,2,4);
        hold on
        ca_dim_sum=(ca_dim_temp{1}(:,circle_z)+ca_dim_temp{2}(:,circle_z)+ca_dim_temp{3}(:,circle_z))/3;
        f1(4)=plot(tSpan/60,ca_dim_sum);
        pause(0.5)
    end
elseif select==2
    for circle_time=1:n
        ca_dim_temp{1}=CC01{circle_time};
        ca_dim_temp{2}=CC02{circle_time};
        ca_dim_temp{3}=CC03{circle_time};
        scale=1;
        figure(2)
        delete(f1);
        for ii=1:3
            subplot(2,2,ii);
            plot(tSpan/60,ca_dim_temp{ii}(:,z))
            xlabel('t/min'),ylabel('C/C_0')
            axis([0,tSpan(end)/60/scale,0,1.5])
            subplot(2,2,4);
            hold on
            f1(ii)=plot(tSpan/60,ca_dim_temp{ii}(:,z));
            xlabel('t/min'),ylabel('C/C_0')
            axis([0,tSpan(end)/60/scale,0,1.5])
        end
        subplot(2,2,4);
        hold on
        ca_dim_sum=(ca_dim_temp{1}(:,z)+ca_dim_temp{2}(:,z)+ca_dim_temp{3}(:,z))/3;
        f1(4)=plot(tSpan/60,ca_dim_sum);
        pause(0.2)
    end
elseif select==3
    ca_dim_temp{1}=CC01{end};
    ca_dim_temp{2}=CC02{end};
    ca_dim_temp{3}=CC03{end};
    scale=1;
    figure(3)
    hold on
    color={'b','r','k'};
    for ii=1:3
        plot(tSpan/60,ca_dim_temp{ii}(:,z),color{ii});
        xlabel('t/min'),ylabel('C/C_0')
        axis([0,tSpan(end)/60/scale,0,1.5])
    end
    legend('CO2','CH4','N2');
    title('固定床吸附穿透曲线');
else 
    ca_dim_temp{1}=cm0(:,:,1);
    ca_dim_temp{2}=cm0(:,:,2);
    ca_dim_temp{3}=cm0(:,:,3);
    scale=1;
    figure(3)
    hold on
    color={'b','r','k'};
    for ii=1:3
        plot(tSpan/60,ca_dim_temp{ii}(:,z),color{ii});
        xlabel('t/min'),ylabel('C/C_0')
        axis([0,tSpan(end)/60/scale,0,1.5])
    end
    legend('CO2','CH4','N2');
    title('固定床吸附穿透曲线');
end
