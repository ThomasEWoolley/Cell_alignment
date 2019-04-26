ccc

Name='All_static_data'
[~,bbb]=xlsfinfo(Name);
for kkk=1:length(bbb)
    close all
    figure('position',[0 1/3 1 1/3])
    Cell_plotter_mod_90_more_tests_prim_I
    Cell_plotter_mod_90_more_tests_prim_II
    
    export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour.png'],'-r300')
end