e=210e6;NU=0.3;h=0.025;p=1;rho=20000;
ijmn(:,1)=[1,2,5,4];
ijmn(:,2)=[2,3,6,5];
pos(1,:)=[0,0,0.25,0,0.25,0.25,0,0.25]；
pos(2,:)=[0.2500,0,0.5,0,0.5,0.25,0.25,0.25]
BilinearQuadElementStiffness2(E,NU,h,pos(1,1),pos(1,2),pos(1,3),pos(1,4),pos(1,5),pos(1,6),pos(1,7),pos(1,8),p)
BilinearQuadElementStiffness2(E,NU,h,pos(2,1),pos(2,2),pos(2,3),pos(2,4),pos(2,5),pos(2,6),pos(2,7),pos(2,8),p)
m1=BilinearQuadElementMass(h,rho,pos(1,1),pos(1,2),pos(1,3),pos(1,4),pos(1,5),pos(1,6),pos(1,7),pos(1,8))
m2=BilinearQuadElementMass(h,rho,pos(2,1),pos(2,2),pos(2,3),pos(2,4),pos(2,5),pos(2,6),pos(2,7),pos(2,8))