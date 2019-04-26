% ccc
N=12;
edges=linspace(-90,90,N);
fs=12;

Z=xlsread(Name,kkk);
x=Z(:,3);

Ang_diff_rad=[];
Mids=find(isnan(x));

Ends=Mids-1;
Starts=[0;Mids(1:end-1)]+1;

l=1;
for j=1:length(Starts)
    
    for i=1:length(Starts(j):Ends(j))
        x=Z(Starts(j):Ends(j),3);y=Z(Starts(j):Ends(j),4);
        theta=deg2rad(Z(Starts(j):Ends(j),8));
        y=max(y)-y;
        xy_vec=[x,y];
        point=xy_vec(i,:);
        xy_vec(i,:)=[nan nan];
        k = dsearchn(xy_vec,point);
        %             Ang_diff_deg(l)=rad2deg(theta(i)-theta(k));
        Ang_diff_rad(l)=(theta(i)-theta(k));
        if isnan(Ang_diff_rad(l))
            disp('oh no')
        end
        l=l+1;
    end
    
end
%     subplot(1,3,kk)
Ang_diff_rad=mod(Ang_diff_rad,2*pi);
Ang_diff_rad=mod(Ang_diff_rad,pi);

Ang_diff_deg=rad2deg(Ang_diff_rad);



Ang_diff_rad(Ang_diff_rad>pi/2)=Ang_diff_rad(Ang_diff_rad>pi/2)-pi;
All_data{1}=Ang_diff_rad;

Ang_diff_deg(Ang_diff_deg>90)=Ang_diff_deg(Ang_diff_deg>90)-180;
All_data_deg{1}=Ang_diff_deg;


Histc(:,1)=histcounts(Ang_diff_deg,edges,'normalization','pdf');
E = length(Ang_diff_deg)/(N-1)*ones(N-1,1); % expected value (equal for uniform dist)

[h,p,stats] = chi2gof(Ang_diff_deg,'Expected',E,'Edges',edges)



%%
% close all
prob=unique(round(diff(edges),4));
% figure('position',[0 1/3 1 1/3])
g = fittype( 'exp(1/k.*cos((deg2rad(x*2)-m)))./(180*besseli(0,1/k))', 'coeff',{'m','k'} );
fo = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',[-90,0],...
    'Upper',[90,100],...
    'StartPoint',[0 1]);
xtext=-80;
ytext=1;
ax=[-90 90 0 1.2];
tt=edges(1:end-1)+diff(edges/2);
for kk=1
    [ft{kk},goof{kk}]=fit(tt',Histc(:,kk),g,fo);
    m=ft{kk}.m;
    k=ft{kk}.k;
    gg=exp(1/k.*cos((deg2rad(tt*2)-m)))./(180*besseli(0,1/k));
    
    [~,pp(kk),stats] = chi2gof(All_data_deg{kk},'Expected',gg*length(All_data_deg{kk})*prob,'Edges',edges);
    
    
%     subplot(1,2,kk)
    bar(tt,Histc(:,kk)*prob,1)
    hold on
    plot(linspace(-90,90),exp(1/k.*cos((deg2rad(linspace(-90,90)*2)-m)))./(180*besseli(0,1/k))*prob,'r')
    axis(ax)
    xticks(-90:20:90)
axis tight
    legend('off')
   xticklabels([])
yticklabels([])
set(gca,'fontsize',fs)
end

% export_fig('./Pictures/Neighbour_compare.png','-r300')