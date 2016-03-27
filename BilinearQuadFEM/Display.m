function Display(lx,ly,jdx,jdy,disp,Mode,ith)
	dof=0;
    Mode_=zeros(jdx*jdy,ith);
	for ni=1:jdx*jdy
		for nj=1:2
			if disp(ni,nj)==0
				Mode_=[Mode_;zeros(1,ith)];
			else
				dof=dof+1;
				Mode_=[Mode_;Mode(dof)];
			end
		end
	end
	for nf=1:ith
		mapdata=zeros(jdx,jdy,nf);
		line=Mode(:,nf);
		linex=line(1:2:ith);
		liney=line(2:2:ith);
		for i=1:jdy
			mapdata(i,:,nf)=(linex(jdx*i-9:1:jdx*i))';
		end
		for i=1:jdy
			mapdata(i,:,nf)=(liney(jdx*i-9:1:jdx*i))';
		end
		% imagesc(mapdata(:,:,1))
		quiver(mapdata(:,:,1),mapdata(:,:,2));
		hold on;
		%�����������ݡ�
		[x,y]=meshgrid(0:max(jdx,jdy));
		%�����ߣ������ߡ�
		plot(x,y,'k',y,x,'k');
		% ��֤�����Ƿ���
		axis equal;
		%������ʾ��Χ��
		axis([0 jdx 0 jdy]);
	end
end