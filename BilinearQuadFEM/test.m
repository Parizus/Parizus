[nd,sortindex]=sort(sn);
sn_(sortin(1:Vdel))=0;
sn_(sortin(Vdel+1:elnum))=1;
mapdata=reshape(sn_,[jdx-1,jdy-1])';
figure(2);
colormap(gray); imagesc(-mapdata); axis equal; axis tight; axis off;pause(1e-6);