function cf=BilinearQuadSolve(M,K)

L=M.^0.5;
K_=(L^-1)'*K*L^-1;
lambda=eig(K_);
% circular frequency
cf=lambda.^0.5;