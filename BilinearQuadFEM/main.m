% ���ò���������ģ��(E)�����ɱ�(NU)�����(h)���ܶ�(rho)
E=10e6;NU=0.3;h=1;rho=1;
% ���ò��������򳤶�(lx)�����򳤶�(ly)������ڵ���(jdx)������ڵ���(jdy)
lx=8;ly=1;jdx=321;jdy=41;
% lx=8;ly=1;jdx=161;jdy=21;
% �������������(ER)�������������(AR)��Ŀ���Ż����(Vf)
ER=0.02;ARm=0.02;Vf=0.5;rmin=0.075;
% ���㵥Ԫ����
nelx=jdx-1;nely=jdy-1;
elnum=nelx*nely;
% ����Ŀ��������
Vaddm=round(ARm*elnum/4)*4;
Vfdel=round(Vf*elnum/4)*4;
sn_(1,1:elnum)=1;
sn=zeros(1,elnum);
cyclenum=1;
elnum_=elnum;
TimeData(cyclenum,:)=clock;
while(elnum_>=(nelx*nely-Vfdel))
% for i=1:50
    Vtar=elnum_-round(ER*elnum_/4)*4;
    % ��������Ԫ����
    % �������Ƶ��(cf)��ģ̬����(Mode)
    % �ڵ����ɶ�-�������ɶȱ�ž���(Disp)����Ԫ�����-����ڵ��ž���(en)
    % ��Ԫ�ն���(ek)����Ԫ������(em)�����ɶ���(dispelnum)
    [cf,Mode,Disp,en,ek,em,dispelnum]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy,sn_);
    % ��ʾģ̬���
    % figure(1);
    % DisplayMode(jdx,jdy,Disp,Mode,1);
    % ���е�Ԫ���ȼ���
    for i=1:elnum
        sn(i)=CalculateSN(ek,em,en,Disp,i,cf,Mode,1,dispelnum,sn_(i));
    end
    a001=sn;
%     a000=sn;
    sn=check(en,sn,rmin,lx,ly,jdx,jdy,nelx,nely,elnum);
    if cyclenum>1
        sn=(sn+snold)/2;
    else
        snold=sn;
    end
    snold=sn;
    % ɾ�������ȵ�Ԫ
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
        for i=elnum:1
            count=0;
            j=sortindex(i);
            if sn_(j)==0
                count=count+1;
                if count==Vaddm+1
                    aadd=sn(count);
                end
            end
        end
        for i=1:elnum
            count=0;
            j=sortindex(i);
            if sn_(j)==1
                count=count+1;
                if count==elnum_-Vtar+Vaddm
                    adel=sn(count);
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
    % ���ƺڰ�ͼ��
    colormap(gray); imagesc(-mapdata); axis equal; axis tight; axis off;
    elnum_=sum(sum(sn_),2);
    % �������
    c=clock;
    fprintf('%d %d %d %d %d %d %6.2f\n',c(1:5),cyclenum,cf(1));
    save(['example',num2str(cyclenum)]);
    saveas(2,num2str(cyclenum),'jpg');
    cyclenum=cyclenum+1;
    TimeData(cyclenum,:)=clock;
%     pause;
end