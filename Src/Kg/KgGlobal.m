function [gT,KT,E] = KgGlobal(Geo_0, Geo_n, Geo, Set)
	g = struct(); K = struct(); E = struct();
	%% Surface Energy
	[g.gs,K.Ks,E.ES]=KgArea(Geo_0, Geo, Set);
	%% Viscous Drag
	[g.gv,K.Kv,E.Ev]=KgVisco(Geo_n, Geo, Set);
	%% Perimeter Energy
% 	[g.gp,K.Kp,E.EP]=KgPeri(Geo_0, Geo, Set);
	%% Line Energy
% 	[g.gl,K.Kl,E.EL]=KgLine(Geo_0, Geo, Set);
	%% Sum and out
	gT = zeros(size(g.gs)); KT = zeros(size(K.Ks)); ET = 0;
	gnames = fieldnames(g); Knames = fieldnames(K); Enames = fieldnames(E);
	for f = 1:length(fieldnames(g))
		gT = gT + g.(gnames{f});
		KT = KT + K.(Knames{f});
		ET = ET + E.(Enames{f});
	end
end