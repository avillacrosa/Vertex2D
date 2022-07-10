clear; close all;
Set = struct();
Set.nu = 0.05;
Set.dt = 1;


Geo = struct(); Geo.Cells = struct();
Geo.Cells(1).X = [0 0];
Geo.Cells(1).Y = [0 -1; 1 0; 0 1; -1 0];
Geo.Cells(1).globalIds = [1 2 3 4];
Geo.Cells(1).cglobalIds = 5;
Geo.Cells(1).Peri = ComputeCellPeri(Geo.Cells(1));
Geo.numY = 4;
Geo.nCells = 1;

Geo_0 = Geo; Geo_n = Geo;

dofs = 1:(4*2);
% [gp, KP, Ep] = KgPeri(Geo_0, Geo, Set);
% [gv, KV, Ev] = KgVisco(Geo_n, Geo, Set);
% K = KP + KV;
% g = gp + gv;
dy = -KP(dofs, dofs)\gp(dofs);
