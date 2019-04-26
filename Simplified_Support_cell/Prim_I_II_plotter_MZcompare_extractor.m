ccc
Names=dir('*.xlsx');
Names={Names(:).name};
%%
for kkk=2%1:length(Names)
Name=Names{kkk};

    close all
    figure('position',[0 1/3 1 1/3])
    Support_cells_mod_90_prim_I
    K(1)=k;
    Support_cells_mod_90_prim_II
    K(2)=k;
    
    save('MZ_k_nearest_neighbour.mat','K')
end