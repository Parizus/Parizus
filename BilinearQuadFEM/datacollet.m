for iii=1:35
    load(['example',num2str(iii),'.mat']);
    cfdata(iii,1)=cf(1);    
    cfdata(iii,2)=cf(2);
    cfdata(iii,3)=cf(3);
    elnumdata(iii)=elnum_;
end
for iii=37:64
    load(['example',num2str(iii),'.mat']);
    jjj=iii-1;
    cfdata(jjj,1)=cf(1);    
    cfdata(jjj,2)=cf(2);
    cfdata(jjj,3)=cf(3);
    elnumdata(jjj)=elnum_;
end
figure 1;
plot(cfdata(:,1),'x')
hold on
plot(cfdata(:,2),'o')
plot(cfdata(:,3),'*')
plot(cfdata)
grid on;
legend('1st','2nd','3rd');
figure 2;
plot(elnumdata,'x');
hold on
plot(elnumdata);
grid on;
legend('Vf');
