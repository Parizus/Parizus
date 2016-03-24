function cf=BilinearQuadSolve(E,NU,h,p,rho,lx,ly,jdx,jdy)
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
ek=BilinearQuadEK(E,NU,h,el,eh);
em=BilinearQuadEM(h,rho,el,eh);
% 建立整体刚度矩阵和质量矩阵
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
% cf=tempd;
[nd,sortindex]=sort(tempd);
v=v(:,sortindex);
mode_number=1:connum(2);
frequency(mode_number)=sqrt(nd(mode_number))/(2*pi);
cf=frequency(mode_number);
end
function w = BilinearQuadEK(E,NU,h,el,eh)
	syms s t;
	x1=0;y1=0;x2=el;y2=0;x3=el;y3=eh;x4=0;y4=eh;
	p=2;
% 定义形函数(四节点四边形等参单元)
% define the shape function(Four node quadrilateral isoparametric element)
N1 = (1- s)*(1-t)/4;
N2 = (1+s)*(1-t)/4;
N3 = (1+s)*(1+t)/4;
N4 = (1- s)*(1+t)/4;
% 局部坐标与整体坐标变换
% a transformation of coordinates from the subdomains' local nodes to the domain's global nodes
x = N1*x1 + N2*x2 + N3*x3 + N4*x4;
y = N1*y1 + N2*y2 + N3*y3 + N4*y4;
% 对局部坐标求微分
% differentiates of above transformation with respect to subdomains' local coordinates.
xs = diff(x,s);
xt = diff(x,t);
ys = diff(y,s);
yt = diff(y,t);
% 雅可比行列式的值
% Jacobian determinant
J = xs*yt - ys*xt;
% 形函数对局部坐标求微分
% differentiates of shape function with respect to subdomains' local coordinates.
N1s = diff(N1,s);
N2s = diff(N2,s);
N3s = diff(N3,s);
N4s = diff(N4,s);
N1t = diff(N1,t);
N2t = diff(N2,t);
N3t = diff(N3,t);
N4t = diff(N4,t);
% 求没有除以雅可比行列式的B矩阵
% calculate matrix B
B11 = yt*N1s - ys*N1t;
B12 = 0;
B13 = yt*N2s - ys*N2t;
B14 = 0;
B15 = yt*N3s - ys*N3t;
B16 = 0;
B17 = yt*N4s - ys*N4t;
B18 = 0;
B21 = 0;
B22 = xs*N1t - xt*N1s;
B23 = 0;
B24 = xs*N2t - xt*N2s;
B25 = 0;
B26 = xs*N3t - xt*N3s;
B27 = 0;
B28 = xs*N4t - xt*N4s;
B31 = xs*N1t - xt*N1s;
B32 = yt*N1s - ys*N1t;
B33 = xs*N2t - xt*N2s;
B34 = yt*N2s - ys*N2t;
B35 = xs*N3t - xt*N3s;
B36 = yt*N3s - ys*N3t;
B37 = xs*N4t - xt*N4s;
B38 = yt*N4s - ys*N4t;
B = [B11 B12 B13 B14 B15 B16 B17 B18 ;
B21 B22 B23 B24 B25 B26 B27 B28 ;
B31 B32 B33 B34 B35 B36 B37 B38];
if p == 1
	D = (E/(1-NU*NU))*[1, NU, 0 ; NU, 1, 0 ; 0, 0, (1-NU)/2];
elseif p == 2
	D = (E/(1+NU)/(1-2*NU))*[1-NU, NU, 0 ; NU, 1-NU, 0 ; 0, 0, (1-2*NU)/2];
end
% transpose(B)*D*B/J
BD = transpose(B)*D*B/J;
% 积分，并乘以厚度
% integral,plus the thickness;
r = int(int(BD, t, -1, 1), s, -1, 1);
w = h*r;
end
function w = BilinearQuadEM(h,rho,el,eh)
	x1=0;y1=0;x2=el;y2=0;x3=el;y3=eh;x4=0;y4=eh;
	s = 1/2 *(-(x2 - x4)* (y1 - y3) + (x1 - x3)* (y2 - y4));
% s = 1/2 *(-(pos(3) - pos(7))* (pos(2) - pos(6)) + (pos(1) - pos(5))* (pos(4) - pos(8)));
M = rho*h*s/4;
w = M*eye(8);
end