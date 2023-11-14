%% 主程序
clc
clear
global cm0
run('AdsorptionParameters.m');      % 导入多组分吸附参数
% run('AdsorptionParametersSingleComponent.m');      % 导入单组分吸附参数
adone = initadp(rmean,phir);       % 初始化质量分数表（initadp0：单峰分布，initadp：正态分布，initadp1：均匀分布）

% cm0 =ones(nt,sZ,3);                 % 初始气体浓度为1
cm0 =zeros(nt,sZ,3);                 % 初始气体浓度为0
cm0(:,:,select)=1;
% load('cm0_set5_301_21_3.mat');      % 载入初始床层浓度矩阵
qt0 = zeros(nt,sZ,3);
errMax=1e30;
errTol=5e-6;
nItr = 0;
errRec=[];

cdflist1 = zeros(numx(1),numx(2)+1,nt,sZ); % 数密度函数分布表，该表用于记录给定时间nt，空间位置sZ下，满足对应粒径numx(1)和吸附量numx(2)条件下颗粒的质量分数。
cdflist2 = zeros(numx(1),numx(3)+1,nt,sZ);
cdflist3 = zeros(numx(1),numx(4)+1,nt,sZ);
CDFlist = zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1,nt,sZ);


if isempty(gcp('nocreat'))  %如果并行未开启
        parpool(CoreNum);       %开启7个并行工作池
end

while (((errMax > errTol)&&(nItr <50)))
    nItr = nItr + 1;
    nItr
    errMax
    Qt0=zeros(nt,sZ,3);%Nt=nt;TSpan=tSpan;Initdis=initdis;C0=c0;

    parfor k = 1:sZ
        %% 考虑粒径分布
        ct0 = cm0(:,k,:);
        [qq, cdf] = PBMmy(ct0, tSpan, adone, ParametersOfPBMmy);
        Qt0(:,k,:) = qq;
        for j=1:nt
            CDFlist(:,:,:,:,j,k)=cdf{j};
        end
    end
    
    for k = 1:sZ
        for j=1:nt
            cdflist1(:,:,j,k)=sum(sum(CDFlist(:,:,:,:,j,k),3),4);
            cdflist2(:,:,j,k)=sum(sum(CDFlist(:,:,:,:,j,k),2),4);
            cdflist3(:,:,j,k)=sum(sum(CDFlist(:,:,:,:,j,k),2),3);
        end
    end
    qt0=Qt0;
    
    %求解床层质量守恒方程，得到床层浓度矩阵ca_dim(t,Z)
    [ca_dim,errmax]=pdepeCa(CDFlist,DaL_temp,w_temp,ZSpan,tSpan,select);
    errRec=[errRec;errmax];
    errMax=max(errmax,[],'all');
    
    cm0(:,:,1) = ca_dim{1};%% =ca_dim
    CC01{nItr}=ca_dim{1};
    cm0(:,:,2) = ca_dim{2};%% =ca_dim
    CC02{nItr}=ca_dim{2};
    cm0(:,:,3) = ca_dim{3};%% =ca_dim
    CC03{nItr}=ca_dim{3};
end

delete(gcp)

Ca = cm0;
%%
Cat = Ca(:,sZ);
LC = Lc*100; % cm
zSpan = linspace(0, LC,sZ);
% dazMTZ = fundzMTZ(Ca, 0, LC, 0); % 寻找传质区长度
datetime=datestr(datetime(now,'ConvertFrom','datenum'));
save([datetime(1:11) '.mat'])