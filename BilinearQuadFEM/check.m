function sn=check(en,sn,rmin,lx,ly,jdx,jdy,nelx,nely,elnum)
% 计算节点敏度
    dof=zeros(jdx*jdy,2);
    for i=1:elnum
        for j=1:4
            dof(en(i,j),1)=dof(en(i,j))+sn(i);
            dof(en(i,j),2)=dof(en(i,j),2)+1;
        end
    end
    dof_=reshape(dof(:,1)./dof(:,2),[jdx,jdy])';
    % 计算单元尺寸，单元长度(el)，单元高度(eh)
    el=lx/(jdx-1);
    eh=ly/(jdy-1);
    % 计算过滤后的单元敏度
    rminl=floor(rmin/el);
    rminh=floor(rmin/eh);
    snt=zeros(nelx,nely);
    count=snt;
    for i=1:nelx
        for j=1:nely
            for ii=max(1,(i-rminl+1)):min(jdx,(i+rminl))
                for jj=max(1,(j-rminh)):min(jdy,(j+rminh+1))
                    dic=sqrt(((abs(i-ii+0.5))*el)^2+((abs(j-jj+0.5))*eh)^2);
                    if dic<=rmin
                        snt(i,j)=snt(i,j)+dof_(jj,ii)*(rmin-dic);
                        count(i,j)=count(i,j)+(rmin-dic);
                    end
                end 
            end
        end
    end
    sn=snt./count;
    a000=sn;
    sn=reshape(sn,1,[]);
end