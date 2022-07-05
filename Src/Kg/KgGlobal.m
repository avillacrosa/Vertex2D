function [g,K,E] = KgGlobal(Geo_0, Geo_n, Geo, Set)
	g = struct(); K = struct(); E = struct();
	%% Surface Energy
	[g.gs,K.Ks,E.ES]=KgArea(Geo_0, Geo, Set);
end