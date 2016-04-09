function [Disp,connum]=SetConstraint(jdx,jdy)
    % 设置边界条件
    Disp(1:jdx*jdy,1:2)=1;
%     constraints=1:jdx:jdx*jdy;
%     constraints=[constraints,jdx:jdx:jdx*jdy];
    constraints=[(jdy-1)/2*jdx+1,(jdy-1)/2*jdx+jdx];
    connum_=size(constraints);
    connum=connum_(2);
    Disp(constraints,:)=0;
end