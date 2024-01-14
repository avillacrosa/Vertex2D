function [gT,KT,E,g,K] = KgGlobal(Geo_0, Geo_n, Geo, Set, Dofs)
	g = struct(); K = struct(); E = struct();
	%% Surface Energy
	[g.gs,K.Ks,E.ES]=KgArea(Geo_0, Geo, Set);
	%% Viscous Drag
	[g.gv,K.Kv,E.Ev]=KgVisco(Geo_n, Geo, Set);
	%% Perimeter Energy
	[g.gp,K.Kp,E.EP]=KgPeri(Geo_0, Geo, Set);
	%% Line Energy
	[g.gl,K.Kl,E.EL]=KgLine(Geo_0, Geo, Set);
	%% Propulsion
	[g.pr,K.Pr,E.Ep]=KgProp(Geo, Set);
	%% External Pressure
% 	[g.gE,K.KE,E.EE]=KgPress(Geo, Set);
    %% Sum and out    
	[gT, KT] = initializeKg(Geo, Set); 
	ET = 0;
	gnames = fieldnames(g); Knames = fieldnames(K); Enames = fieldnames(E);
%     fprintf("> Max force contributions ")
	for f = 1:length(fieldnames(g))
%         fprintf("%s %.3f ",  gnames{f}, max(abs(g.(gnames{f}))))
		gT = gT + g.(gnames{f});
		KT = KT + K.(Knames{f});
		ET = ET + E.(Enames{f});
    end
%     fprintf("\n");
%     PlotGeoF(Geo, gT)
%     PlotGeoF(Geo, g.gE)
%     1
end