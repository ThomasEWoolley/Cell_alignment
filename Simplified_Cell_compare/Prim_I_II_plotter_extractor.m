ccc

Name='All_static_data'
[~,bbb]=xlsfinfo(Name);
%%
for kkk=6%1:length(bbb)
    bbb(kkk)
    close all
    figure('position',[0 1/3 1 1/3])
    Cell_plotter_mod_90_more_tests_prim_I
    K(1)=k;
    Cell_plotter_mod_90_more_tests_prim_II
    K(2)=k;
%     save('Scribble_k_nearest_neighbour.mat','K')
%     save('Wildtype_k_nearest_neighbour.mat','K')
    save('Wnt11R_k_nearest_neighbour.mat','K')
end