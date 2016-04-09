function sn = CalculateSN(ek,em,en,Disp,ith,cf,Mode,Modenum,dispelnum)
	%system stiffness matrix
	k(1:2*dispelnum,1:2*dispelnum)=0;
	%system mass matrix
	m(1:2*dispelnum,1:2*dispelnum)=0;
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
sn=Mode(:,Modenum)'*(k-cf(Modenum)^2/3*m)*Mode(:,Modenum)/2/cf(Modenum);