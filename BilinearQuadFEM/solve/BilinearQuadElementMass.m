function w = BilinearQuadElementMass(h,rho,pos)
	x1=0;y1=0;x2=el;y2=0;x3=el;y3=eh;x4=0;y4=eh;	
	s = 1/2 *(-(x2 - x4)* (y1 - y3) + (x1 - x3)* (y2 - y4));
	% s = 1/2 *(-(pos(3) - pos(7))* (pos(2) - pos(6)) + (pos(1) - pos(5))* (pos(4) - pos(8)));
	M = rho*h*s/4;
	w = M*eye(8);