% function cf=BilinearQuadSolve(E,NU,h,p,rho,lx,ly,jdx,jdy)
% elnum__the totle number of element
% jdx(jdy)__the number of nodes in horizontal(vertical) direction
% element node
elnum=(jdx-1)*(jdy-1);
en(1:elnum,1:4)=0;
for	ni=1:jdx-1
    for nj=1:jdy-1
        en(ni+(nj-1)*(jdx-1),1)=ni+(nj-1)*jdx;
        en(ni+(nj-1)*(jdx-1),2)=ni+1+(nj-1)*jdx;
        en(ni+(nj-1)*(jdx-1),4)=ni+nj*jdx;
        en(ni+(nj-1)*(jdx-1),3)=ni+1+nj*jdx;
    end
end
disp(1:jdx*jdy,1:2)=1;
constraints=1:jdx:jdx*jdy;
connum=size(constraints);
disp(constraints,:)=0;
dof=0;
for ni=1:jdx*jdy
    for nj=1:2
        if disp(ni,nj)~=0
            dof=dof+1;
            disp(ni,nj)=dof;
        end
    end
end
dispelnum=jdx*jdy-connum(2);
%system stiffness matrix
k(1:2*dispelnum,1:2*dispelnum)=0;
%system mass matrix
m(1:2*dispelnum,1:2*dispelnum)=0;
% ���㵥Ԫ�ߴ磬��Ԫ����(el)����Ԫ�߶�(eh)
el=lx/(jdx-1);
eh=ly/(jdy-1);
% ���ò��ϲ���������ģ��(E)�����ɱ�(NU)�����(h)���ܶ�(rho)
% 	E=210e6;NU=0.3;h=0.025;p=1;rho=20000;
% ���㵥Ԫ�նȾ���
% compute element stifness matrix
% ���㵥Ԫ��������
% compute element mass matrix
% �������еĵ�Ԫ������ͬ�ĸնȾ������������
% in this case, all elements have the same element stifness and mass matrix
ek=BilinearQuadEK(E,NU,h,el,eh);
em=BilinearQuadEM(h,rho,el,eh);
% ��������նȾ������������
% built system stifness and mass matrix.
index(1:8)=0; % vector sontaining system dofs of nodes in each element.
for loopi=1:(jdx-1)*(jdy-1)
    for zi=1:4
        index((zi-1)*2+1)=disp(en(loopi,zi),1);
        index((zi-1)*2+2)=disp(en(loopi,zi),2);
    end
    for i=1:8
        for j=1:8
            if(index(i)*index(j)~=0)
                k(index(i),index(j))=k(index(i),index(j))+ek(i,j);
                m(index(i),index(j))=m(index(i),index(j))+em(i,j);
            end
        end
    end
end

%solve eigenvalue problem
[v,d] = eig(k,m);
tempd=diag(d);
cf=tempd;
% 	[nd,sortindex]=sort(tempd);
% 	v=v(:,sortindex);
% 	mode_number=1:connum;
% 	frequency(mode_number)=sqrt(nd(mode_number))/(2*pi);
% 	cf=frequency(mode_number);
% end