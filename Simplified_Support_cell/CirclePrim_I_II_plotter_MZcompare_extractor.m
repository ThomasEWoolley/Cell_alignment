ccc
Names=dir('*.xlsx');
Names={Names(:).name};
%%
for kkk=2
Name=Names{kkk};

    close all
    figure('position',[0 1/3 1 1/3])
    Circle_compare_prim_I
    K(1)=k;
    Circle_compare_prim_II
    K(2)=k;
    
    save('MZ_k_nearest_tangent.mat','K')
end