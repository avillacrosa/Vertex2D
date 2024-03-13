close all; clear; clc;
% clear; clc;
addpath(genpath('Src'));

% [Geo, Mat, Set] = Compress;
% [Geo, Mat, Set] = Large;
% [Geo, Mat, Set] = Proliferation;
% [Geo, Mat, Set] = Propulsion;
% [Geo, Mat, Set] = PropulsionGlass;
% [Geo, Mat, Set] = PBC;
% [Geo, Mat, Set] = noPBC;
[Geo, Mat, Set] = confi;
RunVX(Geo, Mat, Set);
