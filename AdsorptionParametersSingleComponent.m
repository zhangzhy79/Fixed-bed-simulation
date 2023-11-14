%% 参数设置
% 该脚本用于设置吸附固定床参数及吸附气体参数
%% 网格划分设置
global nt sZ tSpan ZSpan
% 以下参数用于设置时间与空间的网格划分
t_m = 150;      % 模拟时间，单位：分钟（min）
t = t_m*60;     % 模拟时间，单位：秒（s）
nt = t_m*2+1;   % 划分时间点数量（每30秒记录一次数据）
sZ = 21;        % 划分空间点数量（仅考虑一维轴向）
tSpan = linspace(0, t, nt); % 时间网格点（具体）
ZSpan = linspace(0, 1, sZ); % 空间网格点（归一化）
%% 固定床及吸附剂参数设置
global Lc ep eb T R1 rc rp pDnsty tao rmean
% 固定床参数设置
Lc = 0.0646;        % 床层轴向长度，单位：米（m）
Dinter = 0.0282;    % 吸附柱内直径，单位：米（m）0.0282
Rinter = Dinter/2;  % 吸附柱内半径，单位：米（m）
eb = 0.47;          % 床层空隙率
T = 313.15;         % 温度，单位：开尔文（K）
R1 = 8.314;         % 气体常数，单位：焦耳每摩尔每开尔文（J/(mol*K)）
volume_ms = pi*Rinter^2*Lc*(1-eb);  % 吸附剂占据的空间，单位：立方米（m^3）
volume_empty = pi*Rinter^2*Lc*eb;   % 空隙占据的空间，单位：立方米（m^3）
% 吸附剂参数设置
ep = 0.35;          % 吸附剂颗粒的孔隙率
rc = 0.5e-6;        % 晶体半径，单位：米（m）
rp = 3.61e-7;       % 平均孔径，单位：米（m）
pDnsty = 1.109e3;   % 颗粒表观密度，单位：千克每立方米（kg/m^3）
tao = 3;            % 弯曲度
ms = volume_ms*pDnsty;  % 吸附剂总质量，单位：千克（kg）
% 吸附剂微观尺寸参数设置
rmean = 8e-4;       % 颗粒平均半径，单位：米（m）
phir = 0.3*rmean;   % 颗粒半径方差
%% 吸附质参数设置
global M M_C p p_C totalp 
% 三元气体组分（二氧化碳（CO2，下标：1），甲烷（CH4，下标：2），氮气（N2，下标：3））
select=[3];                         % 参与吸附的组分
% 以及载气氦气（He）的吸附参数设置
% 气体基本参数设置
M = [44 16 28];                     % CO2，CH4，N2的摩尔质量，单位：克每摩尔（g/mol）
M_C = 2;                            % 载气He的摩尔质量，单位：克每摩尔（g/mol）
% 气体流量参数设置
v_L = [0 0 59.6];                % CO2，CH4，N2的流量，单位：毫升每分钟（mL/min）
v = v_L*1e-6/60/pi/Rinter^2;        % CO2，CH4，N2的流速，单位：米每秒（m/s）
v_L_C = 24.6;                        % He的流量，单位：毫升每分钟（mL/min）
% 气体分压参数设置
p_initial = [0 0 3.5];       % CO2，CH4，N2的初始分压，单位：巴（bar）
p_C_initial = 3.5;                 % 载气He的初始分压，单位：巴（bar）
% 等体积流量下的压强（总压强：5bar）
totalp = 5;                                         % 总压强，单位：巴（bar）
v_L_total = sum([p_initial.*v_L p_C_initial*v_L_C])/totalp; % 总流量，单位：毫升每分钟（mL/min）
v_C = v_L_total*1e-6/60/pi/Rinter^2;                % He的流速，单位：米每秒（m/s）
p = p_initial.*v_L/v_L_total;                       % CO2，CH4，N2在床内的分压，单位：巴（bar）
p_C = p_C_initial*v_L_C/v_L_total;                  % 载气He在床内的分压，单位：巴（bar）
%% 吸附动力学参数设置
global o Dc Dp K eff_re
% 多元气体组分（二氧化碳（CO2，下标：1），甲烷（CH4，下标：2），氮气（N2，下标：3），氦气（He，下标：4）））
% 各气体相互之间以及各气体与吸附剂之间的吸附动力学参数设置
o = [3.454 3.73 3.575 2.63];        % LJ势能平衡距离（CO2，CH4，N2，He），单位：埃（A）
% 气体扩散系数设置
Dc = [1.10 0.0745 1.5].*1e-13;      % 晶内扩散率，单位：平方米每秒（m^2/s）
Dp = [1.55 0.7123 0.701].*1e-5;     % 有效大孔扩散率，单位：平方米每秒（m^2/s）
K = [763 34 16];                    % 无因次亨利定律的平衡常数
% 雷诺数修正参数设置与计算
nu=[8.369 17.071 15.753]*1e-6;      % 运动粘滞系数，单位：平方米每秒（m^2/s）
v_m=[26.7 25.14 18.5 2.67];         % 分子扩散体积，单位：立方厘米每摩尔（cm^3/mol）
rou=[1.97 0.78 1.26];               % 气体密度，单位：千克每立方米（kg/m^3 = g/L）
eta=[14.932 11.067 17.805]*1e-6;    % 动力粘度，单位：帕斯卡秒（Pa*s）
% 计算气体扩散率
D=zeros(1,3);                       % 气体扩散率，单位：平方米每秒（m^2/s）
for ii=1:3
    D(ii)=D_m(M(ii),M_C,v_m(ii),v_m(4),totalp*1e5,T);   
end
% 计算修正参数
sc=nu./D;                                   % 施密特数
re=rou.*v.*(Dinter)./eta;                   % 雷诺数
eff_re=(2+0.6.*sc.^(1/3).*re.^(0.5))./2;    % 修正参数
%% 吸附等温模型参数设置
global c0 q0
c0 = p*1e5/R1/T.*M;                         % CO2，CH4，N2初始气相浓度，单位：毫克每升（mg/L = g/m^3）
q0 = DSL(p);                                % CO2，CH4，N2平衡吸附量，单位：毫克每克（mg/g）
%% 初始质量分数网格参数设置
global numx deltax
numx = [39 6 9 9];                          % 粒径r（下标：1）、吸附量q1、q2、q3 （下标：2、3、4）网格数，即r、q的分布区间
deltax = [4e-5 34 1.315 1.115];             % 粒径r（下标：1，单位：米（m））的间距和吸附量q1、q2、q3（下标：2、3、4，单位：毫克每克（mg/g））的间距
deltax(2) = q0(1)/5;deltax(3:4)=q0(2:3)/2;  % 修正间距以取得更好的精度
%% 床层浓度计算参数设置
global DaL_temp w_temp Cinlet F C
DL = [1.47 3.72 3.71]*1e-5;                 % 轴向质量分散系数，单位：平方米每秒（m^2/s）
v_total = v_L_total*1e-6/60/pi/Rinter^2;    % 气体流速，单位：米每秒（m/s）
F = sum([p_initial*1e5.*v_L*1e-6/60 p_C_initial*1e5*v_L_C*1e-6/60])/(R1*T*pi*Rinter^2);	% 总摩尔通量，单位：摩尔每平方米每秒（mol/(m^2*s)）
C = totalp*1e5/(R1*T);                      % 总摩尔浓度，单位：摩尔每立方米（mol/m^3）
DaL_temp = DL./(Lc.*Lc);                    % 归一化，床层高度为1，单位：每秒（1/s），不同组分的Dal取值不同
w_temp = v_total./(eb.*Lc);                 % 归一化，床层高度为1，单位：每秒（1/s），间隙流速w=空床流速v/空隙率
Cinlet = ones(nt,1);                        % 归一化，进气浓度
%% 其他参数设置
ParametersOfPBMmy = {numx deltax K c0 nt q0 T R1 M M_C p_C eff_re ep rc Dc rmean};  % PBMmy并行工作池参数
CoreNum = 7;        % 设定机器CPU核心数量