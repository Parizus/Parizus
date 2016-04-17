function [dcf]=check(jdx,jdy,rmin,sn)
nelx=jdx-1;nely=jdy-1;
mapdata=reshape(sn,[nelx,nely])';
dcf=zeros(nely,nelx);
for i = 1:nelx
  for j = 1:nely
    sum=0.0; 
    for k = max(i-floor(rmin),1):min(i+floor(rmin),nelx)
      for l = max(j-floor(rmin),1):min(j+floor(rmin),nely)
       fac = rmin-sqrt((i-k)^2+(j-l)^2);
       sum = sum+max(0,fac);
       dcf(j,i) = dcf(j,i) + max(0,fac)*mapdata(l,k);
      end
    end
    dcf(j,i) = dcf(j,i)/sum;
  end
end
dcf=reshape(mapdata,1,[]);