function Mode_=DisplayMode(jdx,jdy,Disp,Mode,ith)
	dof=0;
    Mode_=zeros(jdx*jdy*2,ith);
	for ni=1:jdx*jdy
		for nj=1:2
			if Disp(ni,nj)==0
				Mode_(ni*2-2+nj,:)=zeros(1,ith);
            else
                dof=dof+1;
				Mode_(ni*2-2+nj,:)=Mode(dof,1:ith);
			end
		end
	end
		mapdata=zeros(jdy,jdx,ith);
	for nf=1:ith;
		line=Mode_(:,nf);
		linex=line(1:2:jdx*jdy*2);
		liney=line(2:2:jdx*jdy*2);
		for i=1:jdy
			mapdata(i,:,2*nf-1)=(linex(jdx*(i-1)+1:1:jdx*i))';
		end
		for i=1:jdy
			mapdata(i,:,2*nf)=(liney(jdx*(i-1)+1:1:jdx*i))';
        end
    end
	% imagesc(mapdata(:,:,1))
	quiver(mapdata(:,:,ith),mapdata(:,:,ith+1));
	hold on;
	%�����������ݡ�
	[x,y]=meshgrid(1:jdx,1:jdy);
	plot(x,y,'k');
    [x,y]=meshgrid(1:jdy,1:jdx);
	plot(y,x,'k');
	%�����ߣ������ߡ�
	% ��֤�����Ƿ���
	axis equal;    
    axis off;
	%������ʾ��Χ��
% 	axis([1 jdx 1 jdy]);
    hold off;
end