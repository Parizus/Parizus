function DisplayMode(jdx,jdy,Disp,Mode,ith)
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
		mapdata=zeros(jdx,jdy,ith);
	for nf=1:ith;
		line=Mode_(:,nf);
		linex=line(1:2:jdx*jdy*2);
		liney=line(2:2:jdx*jdy*2);
		for i=1:jdy
			mapdata(i,:,2*nf)=(linex(jdx*(i-1)+1:1:jdx*i))';
		end
		for i=1:jdy
			mapdata(i,:,2*nf+1)=(liney(jdx*(i-1)+1:1:jdx*i))';
        end
    end
	% imagesc(mapdata(:,:,1))
	quiver(mapdata(:,:,ith),mapdata(:,:,ith+1));
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