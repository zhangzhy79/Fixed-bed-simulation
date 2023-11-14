% 计算多组分气体扩散率
function Dm = DmCa(pe,p_C,M,M_C,T,o)
    totalp=sum(pe)+p_C;
    D12 = 1.883e-7*T^1.7*(1/M(1)+1/M(2))^0.5/(totalp*1e2*(1/2*(o(1)+o(2)))^2);	% 1bar=1e2 kPa
    D13 = 1.883e-7*T^1.7*(1/M(1)+1/M(3))^0.5/(totalp*1e2*(1/2*(o(1)+o(3)))^2);
    D23 = 1.883e-7*T^1.7*(1/M(2)+1/M(3))^0.5/(totalp*1e2*(1/2*(o(2)+o(3)))^2);
    D14 = 1.883e-7*T^1.7*(1/M(1)+1/M_C)^0.5/(totalp*1e2*(1/2*(o(1)+o(4)))^2);	% 1bar=1e2 kPa
    D24 = 1.883e-7*T^1.7*(1/M(2)+1/M_C)^0.5/(totalp*1e2*(1/2*(o(2)+o(4)))^2);
    D34 = 1.883e-7*T^1.7*(1/M(3)+1/M_C)^0.5/(totalp*1e2*(1/2*(o(3)+o(4)))^2);
    y = pe./totalp;                          % 气体组分所占摩尔分数
    y_C=1-sum(y,'all');                     % 载气组分所占摩尔分数
    Dm1 = (1-y(1))/(y(2)/D12+y(3)/D13+y_C/D14);
    Dm2 = (1-y(2))/(y(1)/D12+y(3)/D23+y_C/D24);
    Dm3 = (1-y(3))/(y(1)/D13+y(2)/D23+y_C/D34);
    Dm = [Dm1 Dm2 Dm3];                     % 分子扩散率
end