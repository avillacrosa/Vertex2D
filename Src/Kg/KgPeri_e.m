function [gs,Ks]=KgPeri_e(y1,y2)
	l = y1-y2;
	L = norm(l);

	dLdy = l'*[1 -1]/L;
	g = 
end

