function [ ca_dim ] =   svPDEca(ZSpan, tSpan) 
   mPDE = 0; 
   u = pdepe(mPDE, @pdeCFSca, @pdeICca, @pdeBCca, ZSpan, tSpan); 
%    ca_dim = abs(u(:,:,1)); 
    ca_dim = u(:,:,1);
end 
