function g = Assembleg(g,ge,nY)
	dim=2;
	idofg = zeros(length(nY)*dim, 1);
	
	for I=1:length(nY) % loop on number of vertices of triangle
    	idofg((I-1)*dim+1:I*dim) = (nY(I)-1)*dim+1:nY(I)*dim;% global dof
	end
	
	g(idofg)=g(idofg)+ge;
end