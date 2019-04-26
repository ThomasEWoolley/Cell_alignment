ccc

Name='All_static_data'
load('Scribble_k_nearest_tangent.mat')
% load('Wildtype_k_nearest_tangent.mat')
% load('Wnt11R_k_nearest_tangent.mat')
[~,bbb]=xlsfinfo(Name);
for kkk=1:length(bbb)
    close all
    figure('position',[0 1/3 1 1/3])
    Circle_compare_prim_I_compare
    Circle_compare_prim_II_compare
    
    %     export_fig(['./Pictures/',bbb{kkk},'_nearest_tangent_vs_Scribble.png'],'-r300')
export_fig(['./Pictures/',bbb{kkk},'_nearest_tangent_vs_Wildtype.png'],'-r300')
%     export_fig(['./Pictures/',bbb{kkk},'_nearest_tangent_vs_Wnt11R.png'],'-r300')
end