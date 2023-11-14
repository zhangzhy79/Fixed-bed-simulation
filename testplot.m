cdflist_temp{1}=cdflist1;
cdflist_temp{2}=cdflist2;
cdflist_temp{3}=cdflist3;
k1=sZ;r1=1:numx(1);%q1=1:numx(2)+1;
figure(1);
i=1:numx(1);
ri=rmean+deltax(1)*(i'-(numx(1)+1)/2);% (m)
ri=ri.*1e3;% (mm)
t_s=[1 16 301];
LineColor={'y','b','r','m'};
% DAR=[0.5 40 60;0.5 2 2000;0.5 2 2000];%正态
% DAR=[0.5 40 40;0.5 2 1000;0.5 2 1000];%均匀
DAR=[0.5 40 200;0.5 2 5000;0.5 2 5000];%单一
m=1;
for t1=1:nt
    if t1 == t_s(m)
        for ii=1:3
%             if ii>1
%                 continue
%             end
            subplot(3,1,ii);hold on
            set(gca,'DataAspectRatio',DAR(ii,:))
            grid on
            z=zeros(numx(1),numx(ii+1)+1);
            for l=1:k1
                z=z+cdflist_temp{ii}(:,:,t1,l);% (100%)
            end
            z=z/k1;
            z=z/deltax(1)/deltax(ii+1);
            j=1:numx(ii+1)+1;
            qj=deltax(ii+1)*(j-1);
            LineSpec=LineColor{m};
            contour3(ri,qj,z',70+m,LineSpec);
            axis([ri(1)/2,ri(end)+ri(1)/2,0,qj(end),0,1.5*max(z,[],'all')])
            xlabel('R\times 10^{-3}m');ylabel('q/mg\cdotg^{-1}');zlabel('\omega/g\cdotmg^{-1}\cdotm^{-1}');
            if m==length(t_s)
                lgd(3)=legend('t=0s','t=450s','t=9000s');
                set(lgd(3),'position',[0.75,0.55,0.15,0.01],'units','normalized');
            end
            view(75,4);
            h3d = rotate3d; 
            set(h3d,'ActionPreCallback','set(gcf,''windowbuttonmotionfcn'',@align_axislabel)'); 
            set(h3d,'ActionPostCallback','set(gcf,''windowbuttonmotionfcn'','''')');
            set(gcf, 'ResizeFcn', @align_axislabel)
            align_axislabel([], gca)
        end
        m=m+1;
    end
    if m>length(t_s)
        break
    end
%     pause(0.05);
end

%view(60,13);

figure(2)
m=1;
for t1=1:nt
    if t1 == t_s(m)
        for ii=1:1
            hold on
            grid on
            z=zeros(numx(1),numx(ii+1)+1);
            for l=1:k1
                z=z+cdflist_temp{ii}(:,:,t1,l);% (100%)
            end
            z=z/k1;
            z=z/deltax(1)/deltax(ii+1);
            j=1:numx(ii+1)+1;
            qj=deltax(ii+1)*(j-1);
            LineSpec=LineColor{m};
            if m==1
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,2)*qj(index)+deltax(ii+1)*[0 0.01],[z(:,index) zeros(size(z(:,index)))]',70+m,LineSpec);
                h.EdgeColor="#EDB120";
            elseif  m==length(t_s)
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,3)*qj(index)+deltax(ii+1)*[-0.01 0 0.01],[zeros(size(z(:,1))) z(:,index) zeros(size(z(:,1)))]',70+m,LineSpec);
            else
                [~,h]=contour3(ri,qj,z',70+m,LineSpec);
            end
            axis([ri(1)/2,ri(end)+ri(1)/2,0,qj(end),0,1.5*max(z,[],'all')])
            xlabel('R\times 10^{-3}/m');ylabel('q/mg\cdotg^{-1}');zlabel('\omega/g\cdotmg^{-1}\cdotm^{-1}');
            if m==length(t_s)
                lgd(3)=legend('t=0s','t=450s','t=9000s');
                set(lgd(3),'position',[0.75,0.65,0.15,0.01],'units','normalized');
            end
            view(60,13);
        end
        m=m+1;
    end
    if m>length(t_s)
        break
    end
%     pause(0.05);
end
set(gca,'DataAspectRatio',DAR(1,:))
h3d = rotate3d; 
set(h3d,'ActionPreCallback','set(gcf,''windowbuttonmotionfcn'',@align_axislabel)'); 
set(h3d,'ActionPostCallback','set(gcf,''windowbuttonmotionfcn'','''')');
set(gcf, 'ResizeFcn', @align_axislabel)
align_axislabel([], gca)

figure(3)
m=1;
for t1=1:nt
    if t1 == t_s(m)
        for ii=2:2
            hold on
            grid on
            z=zeros(numx(1),numx(ii+1)+1);
            for l=1:k1
                z=z+cdflist_temp{ii}(:,:,t1,l);% (100%)
            end
            z=z/k1;
            z=z/deltax(1)/deltax(ii+1);
            j=1:numx(ii+1)+1;
            qj=deltax(ii+1)*(j-1);
            LineSpec=LineColor{m};
            if m==1
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,2)*qj(index)+deltax(ii+1)*[0 0.01],[z(:,index) zeros(size(z(:,index)))]',70+m,LineSpec);
                h.EdgeColor="#EDB120";
            elseif  m==length(t_s)
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,3)*qj(index)+deltax(ii+1)*[-0.01 0 0.01],[zeros(size(z(:,1))) z(:,index) zeros(size(z(:,1)))]',70+m,LineSpec);
            else
                [~,h]=contour3(ri,qj,z',70+m,LineSpec);
            end
            axis([ri(1)/2,ri(end)+ri(1)/2,0,qj(end),0,1.5*max(z,[],'all')])
            xlabel('R\times 10^{-3}/m');ylabel('q/mg\cdotg^{-1}');zlabel('\omega/g\cdotmg^{-1}\cdotm^{-1}');
            if m==length(t_s)
                lgd(3)=legend('t=0s','t=450s','t=9000s');
                set(lgd(3),'position',[0.75,0.65,0.15,0.01],'units','normalized');
            end
            view(60,13);
        end
        m=m+1;
    end
    if m>length(t_s)
        break
    end
%     pause(0.05);
end
set(gca,'DataAspectRatio',DAR(2,:))
h3d = rotate3d; 
set(h3d,'ActionPreCallback','set(gcf,''windowbuttonmotionfcn'',@align_axislabel)'); 
set(h3d,'ActionPostCallback','set(gcf,''windowbuttonmotionfcn'','''')');
set(gcf, 'ResizeFcn', @align_axislabel)
align_axislabel([], gca)

figure(4)
m=1;
for t1=1:nt
    if t1 == t_s(m)
        for ii=3:3
            hold on
            grid on
            z=zeros(numx(1),numx(ii+1)+1);
            for l=1:k1
                z=z+cdflist_temp{ii}(:,:,t1,l);% (100%)
            end
            z=z/k1;
            z=z/deltax(1)/deltax(ii+1);
            j=1:numx(ii+1)+1;
            qj=deltax(ii+1)*(j-1);
            LineSpec=LineColor{m};
            if m==1
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,2)*qj(index)+deltax(ii+1)*[0 0.01],[z(:,index) zeros(size(z(:,index)))]',70+m,LineSpec);
                h.EdgeColor="#EDB120";
            elseif  m==length(t_s)
                [len,~]=size(z(:,1));
                [~,index]=max(z(round(len/2),:),[],2);
                [~,h]=contour3(ri,ones(1,3)*qj(index)+deltax(ii+1)*[-0.01 0 0.01],[zeros(size(z(:,1))) z(:,index) zeros(size(z(:,1)))]',70+m,LineSpec);
            else
                [~,h]=contour3(ri,qj,z',70+m,LineSpec);
            end
%             [~,h]=contour3(ri,qj,z',70+m,LineSpec);
%             if m==1
%                 h.EdgeColor="#EDB120";
%             end
            axis([ri(1)/2,ri(end)+ri(1)/2,0,qj(end),0,1.5*max(z,[],'all')])
            xlabel('R\times 10^{-3}/m');ylabel('q/mg\cdotg^{-1}');zlabel('\omega/g\cdotmg^{-1}\cdotm^{-1}');
            if m==length(t_s)
                lgd(3)=legend('t=0s','t=450s','t=9000s');
                set(lgd(3),'position',[0.75,0.65,0.15,0.01],'units','normalized');
            end
            view(60,13);
        end
        m=m+1;
    end
    if m>length(t_s)
        break
    end
%     pause(0.05);
end
set(gca,'DataAspectRatio',DAR(3,:))
h3d = rotate3d; 
set(h3d,'ActionPreCallback','set(gcf,''windowbuttonmotionfcn'',@align_axislabel)'); 
set(h3d,'ActionPostCallback','set(gcf,''windowbuttonmotionfcn'','''')');
set(gcf, 'ResizeFcn', @align_axislabel)
align_axislabel([], gca)
axislabel_translation_slider;


