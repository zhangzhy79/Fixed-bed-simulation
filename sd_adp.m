function xyzcdfnew = sd_adp(xyzcdf0,gr,deltat,deltax)
%numerical solution of population balance with size-dependent growth rate
%xyzcdf0:initial number distribution, N dimension 
%gr: growth rate, 1*N
% global deltat deltax
cdfsize=size(xyzcdf0);
ndim=length(cdfsize);
xyzcdfnew=xyzcdf0;
res=1e-70;
% for i=1:length(deltax)
%     res=min(res);
% end
% res=res*1e-3;
for dim=1:ndim
    if dim>1
        %每次将第i维移到最前，然后对该维数作数值积分
        intemp=[dim 1:dim-1 dim+1:ndim];
        xyztemp=permute(xyzcdfnew, intemp);
        grtemp=permute(gr{dim},intemp);
    else
        intemp=1:ndim;
        xyztemp=xyzcdfnew;
        grtemp=gr{dim};
    end
    
    %将xyztemp和gr头尾扩展，使数值解形式能够用于其头和尾
    onebsize=cdfsize(intemp);
    dxyzcdfnew=zeros(onebsize);
    onebsize(1)=onebsize(1)+3;
    xyzoneb=zeros(onebsize);
    xyzoneb(3:onebsize(1)-1,:)=xyztemp(1:end,:);
    xyzoneb(onebsize(1),:)=xyztemp(end,:);
    
    gr2size=cdfsize(intemp);
    gr2size(1)=gr2size(1)+2;
    gr2=zeros(gr2size);
   % gr2(1,:)=grtemp(1,:);
    gr2(2:(gr2size(1)-1),:)=grtemp(1:end,:);
    
    ratiox=deltat/deltax(dim);
    
    for k=1:cdfsize(dim)
        phin=(xyzoneb(k+2,:)-xyzoneb(k+1,:)+res)./(xyzoneb(k+3,:)-xyzoneb(k+2,:)+res);
        phinp=(xyzoneb(k+1,:)-xyzoneb(k,:)+res)./(xyzoneb(k+2,:)-xyzoneb(k+1,:)+res);
        fphin=(abs(phin)+phin)./(1+abs(phin));
        fphinp=(abs(phinp)+phinp)./(1+abs(phinp));
        fn=(xyzoneb(k+2,:)-xyzoneb(k+1,:));
        fnn=(xyzoneb(k+3,:)-xyzoneb(k+2,:));
        dxyzcdfnew(k,:)=dxyzcdfnew(k,:)-ratiox*(abs(gr2(k+1,:)).*xyzoneb(k+2,:)-(gr2(k,:)+abs(gr2(k,:)))/2.*xyzoneb(k+1,:)-(-gr2(k+2,:)+abs(-gr2(k+2,:)))/2.*xyzoneb(k+3,:))-...
            0.5*ratiox*(gr2(k+1,:).*(1-gr2(k+1,:)*ratiox).*fnn.*fphin-gr2(k,:).*(1-gr2(k,:)*ratiox).*fn.*fphinp);
        %dxyzcdfnew(k,:)
    end
    %将增量矩阵的维数顺序还原后加到初值上
    xyzcdfnew=xyzcdfnew+permute(dxyzcdfnew,[2:dim 1 dim+1:ndim]);
end


end