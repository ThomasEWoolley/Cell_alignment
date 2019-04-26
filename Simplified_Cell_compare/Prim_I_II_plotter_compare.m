ccc

Name='All_static_data'
% load('Scribble_k_nearest_neighbour.mat')
load('Wildtype_k_nearest_neighbour.mat')
% load('Wnt11R_k_nearest_neighbour.mat')
[~,bbb]=xlsfinfo(Name);
for kkk=1:length(bbb)
    close all
    figure('position',[0 1/3 1/4 1/4])
    Cell_plotter_mod_90_more_tests_prim_I_compare
%     export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Scribble_prim_I.png'],'-r300')
    export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Wildtype_prim_I.png'],'-r300')
    %     export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Wnt11R_prim_I.png'],'-r300')
    
    figure('position',[0 1/3 1/4 1/4])
    Cell_plotter_mod_90_more_tests_prim_II_compare
%     export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Scribble_prim_II.png'],'-r300')
    export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Wildtype_prim_II.png'],'-r300')
    %     export_fig(['./Pictures/',bbb{kkk},'_nearest_neighbour_vs_Wnt11R_prim_II.png'],'-r300')
end