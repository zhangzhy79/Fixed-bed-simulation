function [ pl, ql, pr, qr ] = pdeBCca(xl, ul, xr, ur, t) 
global w
global Cinlet; % c0 is changed with t 
global tSpan; 
cNow = pchip(tSpan, Cinlet, t); 
pl = cNow - ul; 
ql = 1/w; 
pr = 0; 
qr = 1;  

end 
