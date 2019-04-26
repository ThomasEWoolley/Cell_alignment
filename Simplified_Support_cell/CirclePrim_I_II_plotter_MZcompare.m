ccc
Names=dir('*.xlsx');
Names={Names(:).name};
load('MZ_k_nearest_tangent.mat')
%%
for kkk=[1:length(Names)]
Name=Names{kkk};

    close all
    figure('position',[0 1/3 1 1/3])
    Circle_compare_prim_I_MZcompare
    Circle_compare_prim_II_MZcompare
    
    export_fig(['./Pictures/',Names{kkk}(1:end-5),'_nearest_tangent_MZcompare.png'],'-r300')
end