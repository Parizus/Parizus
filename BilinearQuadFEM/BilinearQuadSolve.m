function [cf,Mode,Disp]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy,ith)
	% 设置参数，杨氏模量(E)，泊松比(NU)，厚度(h)，密度(rho),计算多少阶模态(ith)
	% E=210e6;NU=0.3;h=0.025;rho=20000;
    % lx=5,ly=5,jdx=6,jdy=6;
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
	end;
	[Disp,connum]=SetConstraint(jdx,jdy);
	% 设置自由度编号
	dof=0;
	for ni=1:jdx*jdy
		for nj=1:2
			if Disp(ni,nj)~=0
				dof=dof+1;
				Disp(ni,nj)=dof;
			end
		end
	end
	dispelnum=jdx*jdy-connum;
	%system stiffness matrix
	k(1:2*dispelnum,1:2*dispelnum)=0;
	%system mass matrix
	m(1:2*dispelnum,1:2*dispelnum)=0;
	% 计算单元尺寸，单元长度(el)，单元高度(eh)
	el=lx/(jdx-1);
	eh=ly/(jdy-1);
	% 设置材料参数，杨氏模量(E)，泊松比(NU)，厚度(h)，密度(rho)
	% 	E=210e6;NU=0.3;h=0.025;p=1;rho=20000;
	% 计算单元刚度矩阵
	% compute element stifness matrix
	% 计算单元质量矩阵
	% compute element mass matrix
	% 其中所有的单元有着相同的刚度矩阵和质量矩阵
	% in this case, all elements have the same element stifness and mass matrix
	ek=CalculateEK(E,NU,h,el,eh);
	em=CalculateEM(h,rho,el,eh);
	% 建立整体刚度矩阵和质量矩阵
	% built system stifness and mass matrix.
	index(1:8)=0; % vector sontaining system dofs of nodes in each element.
	for loopi=1:(jdx-1)*(jdy-1)
		for zi=1:4
			index((zi-1)*2+1)=Disp(en(loopi,zi),1);
			index((zi-1)*2+2)=Disp(en(loopi,zi),2);
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
	% cf=tempd;
	[nd,sortindex]=sort(tempd);
	Mode=v(:,sortindex);
	mode_number=1:ith;
	frequency(mode_number)=sqrt(nd(mode_number))/(2*pi);
	cf=frequency(mode_number);
    DisplayMode(jdx,jdy,Disp,Mode,ith);
end