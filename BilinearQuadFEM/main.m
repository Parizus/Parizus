% 设置参数，杨氏模量(E)，泊松比(NU)，厚度(h)，密度(rho)
E=10e6;NU=0.3;h=1;rho=1;
% 设置参数，横向长度(lx)，纵向长度(ly)，横向节点数(jdx)，纵向节点数(jdy)
% lx=8;ly=1;jdx=321;jdy=41;
% lx=8;ly=1;jdx=161;jdy=21;
lx=8;ly=1;jdx=81;jdy=11;
% 设置体积进化率(ER)，体积最大添加率(AR)，目标优化体积(Vf)
ER=0.015;ARm=0.015;Vf=0.5;rmin=0.075;
% 计算单元总数
nelx=jdx-1;nely=jdy-1;
elnum=nelx*nely;
% 计算目标减少体积和最大增加体积
Vaddm=round(ARm*elnum/4)*4;
Vfdel=round(Vf*elnum/4)*4;
% 设置变量
sn_(1,1:elnum)=1;
sn=zeros(1,elnum);
cyclenum=0;
elnum_=elnum;
change=1;
cfdata=zeros(1,200);
% 记录开始时间
Starttime=clock;
while((elnum_>=(nelx*nely-Vfdel))&&(change>=0.0001))
    if elnum_>=(nelx*nely-Vfdel)
        Vtar=elnum_-round(ER*elnum_/4)*4;
    end
    % 进行有限元计算
    % 输出各阶频率(cf)，模态矩阵(Mode)
    % 节点自由度-整体自由度编号矩阵(Disp)，单元结点编号-整体节点编号矩阵(en)
    % 单元刚度阵(ek)，单元质量阵(em)，自由度数(dispelnum)
    [cf,Mode,Disp,en,ek,em,dispelnum]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy,sn_);
    % 显示模态结果
    % figure(1);
    % DisplayMode(jdx,jdy,Disp,Mode,1);
    % 进行单元敏度计算
    for i=1:elnum
        sn(i)=CalculateSN(ek,em,en,Disp,i,cf,Mode,1,dispelnum,sn_(i));
    end
    sn=check(en,sn,rmin,lx,ly,jdx,jdy,nelx,nely,elnum);
    if cyclenum>1
        sn=(sn+snold)/2;
    else
        snold=sn;
    end
    snold=sn;
    %     删除低敏度单元
    [nd,sortindex]=sort(sn);
    adel=sn(sortindex(elnum-Vtar));
    aadd=adel;
    countadd=0;
    for i=1:elnum
        if sn_(i)==0
            if sn(i)>adel;
                countadd=countadd+1;
            end
        end
    end
    if countadd>Vaddm;
        count=0;
        for i=elnum:-1:1
            j=sortindex(i);
            if sn_(j)==0
                count=count+1;
                a0000=count;
                if count==Vaddm+1
                    aadd=sn(j);
                    break;
                end
            end
        end
        count=0;
        for i=1:1:elnum
            j=sortindex(i);
            if sn_(j)==1
                count=count+1;
                a0001=count;
                if count==elnum_-Vtar+Vaddm
                    adel=sn(j);
                    break;
                end
            end
        end
    end
    for i=1:elnum
        if sn_(i)==1
            if sn(i)<=adel;
                sn_(i)=0;
            end
        elseif sn_(i)==0
            if sn(i)>aadd;
                sn_(i)=1;
            end
        end
    end
    mapdata=reshape(sn_,[nelx,nely])';
    figure(2);
    % 绘制黑白图像
    colormap(gray); imagesc(-mapdata); axis equal; axis tight; axis off;
    elnum_=sum(sum(sn_),2);
    % 输出控制
    c=clock;
    save(['example',num2str(cyclenum)]);
    % 循环数加一
    cyclenum=cyclenum+1;
    % 记录基频数据，计算error
    cfdata(cyclenum)=cf(1);
    if cyclenum>10;
        change=abs(sum(cfdata(cyclenum-9:cyclenum-5))-sum(cfdata(cyclenum-4:cyclenum)))/sum(cfdata(cyclenum-4:cyclenum));
    end
    % 输出时间，保存图像
    fprintf('%d %d %d %d %d %d %6.2f\n',c(1:5),cyclenum,cf(1));
    saveas(2,num2str(cyclenum),'jpg');
    TimeData=clock;
    % pause;
end