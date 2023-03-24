function Set = InitSet(Set)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% SetDefault:														  %
	%   Adds to the Set struct all the default fields not given in the	  %
	%   user input file. This is done by defining a default Set struct    %
	%   (DSet)  and then adding to the Set struct the missing fields.     %
	% Input:															  %
	%   Set : User input set struct										  %
	% Output:															  %
	%   Set : User input set struct with added default fields             %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DSet = struct();
    %% ============================ Time ==================================
    DSet.tend						= 200;
    DSet.Nincr						= 200;
    %% ============================ Mechanics =============================
    DSet.lambdaA					= 0.5;
	DSet.lambdaP					= 0.5;
	DSet.lambdaL					= 0.5;
	DSet.v0                         = 1; 
	%% ============================ Viscosity =============================
    DSet.nu							= 0.05;
    %% =========================== Remodelling ============================
    DSet.Remodelling				= true;
    DSet.RemodelTol					= .5e-6;
    DSet.RemodelingFrequency		= 2;
	%% TODO FIXME: DEFINE UNITS FOR THIS?
	DSet.DivideFreq                 = 1; 
    %% ============================ Solution ==============================
    DSet.tol						= 1e-10;
    DSet.MaxIter					= 200;
    %% ================= Boundary Condition and loading setting ===========
    DSet.BC							= nan;
    DSet.BCStart					= inf;
    DSet.BCStop 					= -inf;
	%% =========================== PostProcessing =========================
    DSet.diary						= false;
	%% ====================== Add missing fields to Set ===================
	Set  = AddDefault(Set, DSet);
	DSet = Set;
	%% ========================= Derived variables ========================
	DSet.nu0                        = DSet.nu;
	DSet.dt0                        = DSet.tend/DSet.Nincr;
	DSet.dt                         = DSet.dt0;
	DSet.MaxIter0					= DSet.MaxIter;
	%% ====================== Add missing fields to Set ===================
	Set = AddDefault(Set, DSet);
end