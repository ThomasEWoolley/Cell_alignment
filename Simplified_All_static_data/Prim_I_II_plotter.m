ccc
Name='091918 TIME COURSE for ALIGNMENT analysis';
% Name='All_static_data'
[~,bbb]=xlsfinfo(Name);
for kkk=1:length(bbb)
    close all
    figure('position',[0 1/3 1/4 1/4])
    Cell_plotter_mod_90_more_tests_prim_I
    export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_prim_I.png'],'-r300')
    
%     figure('position',[0 1/3 1/4 1/4])
%     Cell_plotter_mod_90_more_tests_prim_II
%     export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_prim_II.png'],'-r300')
    
end