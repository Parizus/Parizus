function [Disp,connum]=SetConstraint(jdx,jdy)
    % ���ñ߽�����
    global Disp;
    Disp(1:jdx*jdy,1:2)=1;
    constraints=1:jdx:jdx*jdy;
    connum_=size(constraints);
    connum=connum_(2);
    Disp(constraints,:)=0;
end