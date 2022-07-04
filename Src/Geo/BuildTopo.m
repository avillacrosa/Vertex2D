function X = BuildTopo(nx, ny)
	x = 0:(nx-1);
	y = 0:(ny-1);
	[x,y] = meshgrid(x,y);
	x=reshape(x,size(x,1)*size(x,2),1);
    y=reshape(y,size(y,1)*size(y,2),1);
    X=[x y];
end