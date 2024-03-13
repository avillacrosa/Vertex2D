function [Y, T] = ReorderYs(Cell)
	Tris = Cell.T;
	nverts = size(Tris,1);
    % nverts = length(Tris);
	Y = Cell.Y;
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