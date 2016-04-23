for jjj=0:35
    iii=jjj+1;
    load(['example',num2str(iii),'.mat']);
    cfdata(iii,1)=cf(1);    
    cfdata(iii,2)=cf(2);
    cfdata(iii,3)=cf(3);
    elnumdata(iii)=elnum_;
end
figure(1);
plot(cfdata(:,1),'x')
hold on
plot(cfdata(:,2),'o')
plot(cfdata(:,3),'*')
plot(cfdata)
grid on;
legend('1st','2nd','3rd');
figure(2);
plot(elnumdata,'x');
hold on
plot(elnumdata);
grid on;
legend('Vf');
