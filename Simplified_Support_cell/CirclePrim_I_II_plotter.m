ccc
Names=dir('*.xlsx');
Names={Names(:).name};
%%
for kkk=1:length(Names)
Name=Names{kkk};

    close all
    figure('position',[0 1/3 1/4 1/4])
    Circle_compare_prim_I
    export_fig(['./Pictures/',Names{kkk}(1:end-5),'_nearest_tangent_prim_I.png'],'-r300')
    
    figure('position',[0 1/3 1/4 1/4])
    Circle_compare_prim_II
    export_fig(['./Pictures/',Names{kkk}(1:end-5),'_nearest_tangent_prim_II.png'],'-r300')
end