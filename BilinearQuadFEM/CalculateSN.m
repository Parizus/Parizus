function sn = CalculateSN(ek,em,en,Disp,ith,cf,Mode,Modenum,dispelnum,sn_)
%system stiffness matrix
k=sparse(2*dispelnum,2*dispelnum);
%system mass matrix
m=sparse(2*dispelnum,2*dispelnum);
index(1:8)=0; % vector sontaining system dofs of nodes in each element.
loopi=ith;
for zi=1:4
    index((zi-1)*2+1)=Disp(en(loopi,zi),1);
    index((zi-1)*2+2)=Disp(en(loopi,zi),2);
end
for i=1:8
    for j=1:8
        if(index(i)*index(j)~=0)
            k(index(i),index(j))=ek(i,j);
            m(index(i),index(j))=em(i,j);
        end
    end
end
% if 2*abs(cf(1)-cf(2))/(cf(1)+cf(2))<=0.01
if abs(cf(1)-cf(2))<=5
    if (sn_==1)
        sn=Mode(:,Modenum)'*(k-cf(Modenum)^2/3*m)*Mode(:,Modenum)/2/cf(1);
        sn2=Mode(:,2)'*(k-cf(2)^2/3*m)*Mode(:,2)/2/cf(2);
        sn=(sn+sn2)/2;
    elseif(sn_==0)
        sn=-Mode(:,Modenum)'*m*Mode(:,Modenum)/6*cf(Modenum);
        sn2=-Mode(:,2)'*m*Mode(:,2)/6*cf(2);
        sn=(sn+sn2)/2;
    end
else
    if (sn_==1)
        sn=Mode(:,Modenum)'*(k-cf(Modenum)^2/3*m)*Mode(:,Modenum)/2/cf(Modenum);
    elseif(sn_==0)
        sn=-Mode(:,Modenum)'*m*Mode(:,Modenum)/6*cf(Modenum);
    end
end

