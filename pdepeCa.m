function [ca_dim,errMax]=pdepeCa(CDFlist,DaL_temp,w_temp,ZSpan,tSpan,select)
global yi DaL w cm0 cdflist
cdflist=CDFlist;
ca_dim{1}=zeros(size(cm0(:,:,1)));ca_dim{2}=zeros(size(cm0(:,:,2)));ca_dim{3}=zeros(size(cm0(:,:,3)));
errMax=zeros(1,3);
for yi=select
    %求解床层质量守恒方程，得到床层浓度矩阵ca_dim(t,Z)
    DaL=DaL_temp(yi);w=w_temp;
    ca_dim{yi} = svPDEca(ZSpan, tSpan);  % 求解床层质量守恒方程，得到床层浓度矩阵ca_dim1(t,Z)
    ca_dim{yi}(ca_dim{yi}<0)=0;
    
    aErr = abs(cm0(:,:,yi) - ca_dim{yi});
    tMax = max(aErr);
    errMax(yi) = max(tMax);
    cm0(:,:,yi) = ca_dim{yi};%% =ca_dim
end
end
