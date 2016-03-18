function y = BilinearQuadAssemble(K,k,ijmn)
%BilinearQuadAssemble   This function assembles the element 
%                       stiffness matrix k of the bilinear 
%                       quadrilateral element with nodes i, j, 
%                       m, and n into the global stiffness 
%                       matrix K.
%                       This function returns the global stiffness  
%                       matrix K after the element stiffness matrix  
%                       k is assembled.
% ����Ԫ�ն��������64��Ԫ�طֱ��������ն�����
for i=1:4
	for j=1:4
		K(2*ijmn(i)-1,2*ijmn(j)-1)=K(2*ijmn(i)-1,2*ijmn(j)-1) + k(2*i-1,2*j-1);
		K(2*ijmn(i)-1,2*ijmn(j))=K(2*ijmn(i)-1,2*ijmn(j)) + k(2*i-1,2*j);
		K(2*ijmn(i),2*ijmn(j)-1)=K(2*ijmn(i),2*ijmn(j)-1) + k(2*i,2*j-1);
		K(2*ijmn(i),2*ijmn(j))=K(2*ijmn(i),2*ijmn(j)) + k(2*i,2*j);
    end
end
y = K;