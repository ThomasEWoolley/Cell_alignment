ccc
Names=dir('*.xlsx');
Names={Names(:).name};
load('MZ_k_nearest_neighbour.mat')
%%
for kkk=[1:length(Names)]
Name=Names{kkk};

    close all
    figure('position',[0 1/3 1 1/3])
    Support_cells_mod_90_prim_I_MZcompare
    Support_cells_mod_90_prim_II_MZcompare
    
    export_fig(['./Pictures/',Names{kkk}(1:end-5),'_nearest_neighbour_MZcompare.png'],'-r300')
end