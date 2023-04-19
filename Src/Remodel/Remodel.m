function [Geo_0, Geo_n, Geo] = Remodel(Geo_0, Geo_n, Geo, Dofs, Set)
	[Geo_0, Geo_n, Geo] = T1transition(Geo_0, Geo_n, Geo, Dofs, Set);
% 	[Geo_0, Geo_n, Geo] = Division(Geo_0, Geo_n, Geo, Dofs, Set);
end