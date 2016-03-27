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
		%产生网格数据。
		[x,y]=meshgrid(0:max(jdx,jdy));
		%画横线，画竖线。
		plot(x,y,'k',y,x,'k');
		% 保证网格是方格。
		axis equal;
		%设置显示范围。
		axis([0 jdx 0 jdy]);
	end
end