function RunV3(Geo, Mat, Set)

    Set = SetDefault(Set);
    Geo = InitGeo(Geo, Set);

    PostProcessingVTK(Geo, Set, 0);
end
