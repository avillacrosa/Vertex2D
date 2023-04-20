function [Y, T] = BuildYFromX(Cell, Cells)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% BuildYFromX:										  
	%   Computes the positions of vertices for a cell using its nodal 
	%   position and its tetrahedras 
	% Input:															  
	%   Cell   : Cell struct for which X will be computed
	%   Cells  : Geo.Cells struct array
	%   XgID   : IDs of ghost nodes
	%   Set    : User defined run settings
	% Output:															  
	%   Y      : New vertex positions computed from tetrahedras
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	dim = size(Cell.X,2);
	Tris = Cell.T;
	Y = zeros(size(Tris,1), dim);
	nverts = size(Tris,1);
	for i = 1:nverts
		T = Tris(i,:);
		x = [Cells(T(1)).X; Cells(T(2)).X; Cells(T(3)).X];
		Y(i,:)=Y(i,:)+sum(x,1)/3;
	end

	prev_tri = Cell.T(1,:);
	tri_order = zeros(nverts,1);
	tri_order(1) = 1;
	for yi = 2:(length(Cell.T))
		next_tri_i = sum(ismember(Cell.T, prev_tri),2)==2;
		next_tri_i = next_tri_i & ~ismember(1:nverts,tri_order)';
		next_tri_i = find(next_tri_i);
		tri_order(yi) = next_tri_i(1);
		prev_tri = Cell.T(next_tri_i(1),:);
	end
	Y = Y(tri_order,:);
	T = Tris(tri_order,:);
end

