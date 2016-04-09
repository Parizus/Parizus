% function main()
% 设置参数，杨氏模量(E)，泊松比(NU)，厚度(h)，密度(rho)
E=210e6;NU=0.3;h=0.025;rho=1;
% 设置参数，横向长度(lx)，纵向长度(ly)，横向节点数(jdx)，纵向节点数(jdy)
lx=8;ly=1;jdx=81;jdy=11;
% 设置体积进化率(ER)，体积最大添加率(AR)
ER=0.02;AR=0.01;
% 计算单元总数
elnum=(jdx-1)*(jdy-1);
% 计算目标减少体积
Vdel=round(ER*elnum);
% 进行有限元计算
% 输出各阶频率(cf)，模态矩阵(Mode)
% 节点自由度-整体自由度编号矩阵(Disp)，单元结点编号-整体节点编号矩阵(en)
% 单元刚度阵(ek)，单元质量阵(em)，自由度数(dispelnum)
[cf,Mode,Disp,en,ek,em,dispelnum]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy);
% 显示模态结果
% figure(1);
% DisplayMode(jdx,jdy,Disp,Mode,1);
% 进行单元敏度计算
sn=zeros(1,elnum);
for i=1:elnum
    sn(i)=CalculateSN(ek,em,en,Disp,i,cf,Mode,1,dispelnum);
end
% 删除低敏度单元
[nd,sortindex]=sort(sn);
sn_(sortin(1:Vdel))=0;
sn_(sortin(Vdel+1:elnum))=1;
mapdata=reshape(sn_,[jdx-1,jdy-1])';
figure(2);
% 绘制黑白图像
colormap(gray); imagesc(-mapdata); axis equal; axis tight; axis off;pause(1e-6);
% end