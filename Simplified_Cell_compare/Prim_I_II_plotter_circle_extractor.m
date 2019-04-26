ccc

Name='All_static_data'
[~,bbb]=xlsfinfo(Name);
for kkk=6%1:length(bbb)
    bbb(kkk)
    close all
    figure('position',[0 1/3 1 1/3])
    Circle_compare_prim_I
    K(1)=k;
    Circle_compare_prim_II
    K(2)=k;
%     save('Scribble_k_nearest_tangent.mat','K')
%     save('Wildtype_k_nearest_tangent.mat','K')
    save('Wnt11R_k_nearest_tangent.mat','K')
end