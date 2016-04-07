% function main()
% ���ò���������ģ��(E)�����ɱ�(NU)�����(h)���ܶ�(rho)
E=210e6;NU=0.3;h=0.025;rho=1;
% ���ò��������򳤶�(lx)�����򳤶�(ly)������ڵ���(jdx)������ڵ���(jdy)
lx=8;ly=1;jdx=161;jdy=21;
elnum=(jdx-1)*(jdy-1);
% ��������Ԫ����
% �������Ƶ��(cf)��ģ̬����(Mode)
% �ڵ����ɶ�-�������ɶȱ�ž���(Disp)����Ԫ�����-����ڵ��ž���(en)
% ��Ԫ�ն���(ek)����Ԫ������(em)�����ɶ���(dispelnum)
[cf,Mode,Disp,en,ek,em,dispelnum]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy);
% ��ʾģ̬���
% figure(1);
% DisplayMode(jdx,jdy,Disp,Mode,1);
% ���е�Ԫ���ȼ���
sn=zeros(1,elnum);
for i=1:elnum
    sn(i)=CalculateSN(ek,em,en,Disp,i,cf,Mode,1,dispelnum);
end
mapdata=reshape(sn,[jdx-1,jdy-1])';
figure(2);
colormap(gray); imagesc(mapdata); axis equal; axis tight; axis off;pause(1e-6);
% end