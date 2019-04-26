ccc
Name='All_static_data'
[~,bbb]=xlsfinfo(Name);
for kkk=1:length(bbb)
    close all
    figure('position',[0 1/3 1 1/3])
    Circle_compare_prim_I
    Circle_compare_prim_II
    
    export_fig(['./Pictures/',bbb{kkk},'_nearest_tangent.png'],'-r300')
end