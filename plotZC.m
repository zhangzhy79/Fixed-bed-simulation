figure(1)
hold on 
Ca=cm0;
tend = nt;
dt = floor(nt/100);
select1=1;
index=[0.25 0.25 0.28];
mid=[38 45 33];
tem=[80 90 70];
ind=3;
for k=1: dt :tend 
    plot(zSpan,Ca(k,:,select1),'r');
    if k<=mid(ind)
        text(zSpan(ceil((k/tend)^index(ind)*sZ))-0.5*zSpan(2),Ca(k,ceil((k/tend)^index(ind)*sZ),select1)+0.02,[num2str(tSpan(k)),'s'],'FontSize',7,'Color','blue');
    end
    if k>mid(ind) && k<tem(ind)
        text(zSpan(end),Ca(k,end,select1),[num2str(tSpan(k)),'s'],'FontSize',7,'Color','blue');
    end
    if k==tend
        text(zSpan(end),Ca(k,end,select1),[num2str(tSpan(k)),'s'],'FontSize',7,'Color','blue');
    end
%   legend('Calculation'); 
end
xlabel('L/cm');
ylabel('C/C_{0}'); 
% title('fix-bed');
axis([0,zSpan(end),0,1])
hold off 
%%%% 