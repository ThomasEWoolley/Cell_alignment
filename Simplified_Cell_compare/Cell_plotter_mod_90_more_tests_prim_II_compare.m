% ccc
% kkk=2
N=12;
edges=linspace(-90,90,N);
fs=12;


Z=xlsread(Name,kkk);
x=Z(:,19);

Ang_diff_rad=[];
Mids=find(isnan(x));

Ends=Mids-1;
Starts=[0;Mids(1:end-1)]+1;

l=1;
for j=1:length(Starts)
    
    for i=1:length(Starts(j):Ends(j))
        x=Z(Starts(j):Ends(j),19);y=Z(Starts(j):Ends(j),20);
        theta=deg2rad(Z(Starts(j):Ends(j),24));
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
g = fittype( ['exp(1/(',num2str(K(2)),'+k).*cos((deg2rad(x*2)-m)))./(180*besseli(0,1/(',num2str(K(2)),'+k)))'], 'coeff',{'m','k'} );
fo = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',[-90,-K(2)],...
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
    gg=exp(1/(K(2)+k).*cos((deg2rad(tt*2)-m)))./(180*besseli(0,1/(K(2)+k)));
    
    [~,pp(kk),stats] = chi2gof(All_data_deg{kk},'Expected',gg*length(All_data_deg{kk})*prob,'Edges',edges);
    
    
    %     subplot(1,2,2)
    bar(tt,Histc(:,kk)*prob,1)
    hold on
    plot(linspace(-90,90),exp(1/(K(2)+k).*cos((deg2rad(linspace(-90,90)*2)-m)))./(180*besseli(0,1/(K(2)+k)))*prob,'r')
    axis(ax)
    xticks(-90:20:90)
    axis tight
    legend('off')
    xlabel('Nearest neighbour angle difference in degrees','interpreter','latex')
    ylabel('probability','interpreter','latex')
    ci = confint(ft{1});
%     text(xtext,ytext,{['Uniform distribution p value ',num2str(round(p(kk),3,'significant'))];...
%         ['Von Mises distribution p value ',num2str(round(pp(kk),3,'significant'))];...
%         ['Von Mises distribution R^2 value ',num2str(round(goof{kk}.rsquare,4,'significant'))]},'fontsize',fs)
%     text(25,ytext,{['Mean= ',num2str(round(m,3,'significant'))];...
%         ['k= ',num2str(round(k,3,'significant')),'  [',num2str(round(ci(1,2),3,'significant')),',',num2str(round(ci(2,2),3,'significant')),']']},'fontsize',fs)
    set(gca,'fontsize',fs)
end