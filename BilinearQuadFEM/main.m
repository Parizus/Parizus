% ���ò���������ģ��(E)�����ɱ�(NU)�����(h)���ܶ�(rho)
E=210e6;NU=0.3;h=0.025;rho=1;
% ���ò��������򳤶�(lx)�����򳤶�(ly)������ڵ���(jdx)������ڵ���(jdy)
% lx=8;ly=1;jdx=321;jdy=41;
lx=8;ly=1;jdx=321;jdy=41;
% �������������(ER)�������������(AR)��Ŀ���Ż����(Vf)
ER=0.05;ARm=0.02;Vf=0.5;rmin=0.3;
% ���㵥Ԫ����
elnum=(jdx-1)*(jdy-1);
% ����Ŀ��������
Vdel=0;
Vaddm=round(ARm*elnum);
Vfdel=round(Vf*elnum);
sn_(1,1:elnum)=1;
sn=zeros(1,elnum);
cyclenum=1;
TimeData(cyclenum,:)=clock;
while(Vdel<=Vfdel)
    Vdel=Vdel+round(ER*elnum);
    % ��������Ԫ����
    % �������Ƶ��(cf)��ģ̬����(Mode)
    % �ڵ����ɶ�-�������ɶȱ�ž���(Disp)����Ԫ�����-����ڵ��ž���(en)
    % ��Ԫ�ն���(ek)����Ԫ������(em)�����ɶ���(dispelnum)
    [cf,Mode,Disp,en,ek,em,dispelnum]=BilinearQuadSolve(E,NU,h,rho,lx,ly,jdx,jdy,sn_);
    % ��ʾģ̬���
    % figure(1);
    % DisplayMode(jdx,jdy,Disp,Mode,1);
    % ���е�Ԫ���ȼ���
    fprintf('%4.0f %d',clock,cyclenum);
    fprintf('\n');
    for i=1:elnum
        sn(i)=CalculateSN(ek,em,en,Disp,i,cf,Mode,1,dispelnum,sn_(i));
    end
    sn=check(jdx,jdy,rmin,sn);
    % ɾ�������ȵ�Ԫ
    [nd,sortindex]=sort(sn);
    sn_(sortindex(1:Vdel))=0;
    % ��Ӹ����ȵ�Ԫ
    countadd=elnum-Vdel-sum(sum(sn_(sortindex(Vdel+1:elnum))),2);
    if (countadd<=Vaddm)
        sn_(sortindex(Vdel+1:elnum))=1;
    else
        count=0;i=elnum;
        while (count<=Vaddm)
            if (sn_(sortindex(i))==0)
                sn_(sortindex(i))=1;
                count=count+1;
            end
            i=i-1;
        end
        countadd=Vaddm;
    end
    mapdata=reshape(sn_,[jdx-1,jdy-1])';
    figure(2);
    % ���ƺڰ�ͼ��
    colormap(gray); imagesc(-mapdata); axis equal; axis tight; axis off;pause(1e-6);
    elnum=sum(sum(sn_),2);
    save(['example',num2str(cyclenum)]);
    cyclenum=cyclenum+1;
    TimeData(cyclenum,:)=clock;
%     pause;
end