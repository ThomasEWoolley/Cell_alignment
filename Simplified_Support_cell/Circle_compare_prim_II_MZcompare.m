% ccc
% kkk=4;
% addpath('C:\Users\Thomas Woolley - Ad\Dropbox\Stowers_projects\Alignment\Circstat')

[~, text_data] =xlsread(Name,1);
text_data(1,:)=[];
Labels=unique(text_data(:,2));
Label_index_P1=[];
for i=1:length(Labels)
    if ~isempty(strfind(Labels{i},'P2'))
        Label_index_P1=[Label_index_P1;i];
    end
end

Starts=[];
Ends=[];
for i=Label_index_P1'
    SF=strfind(text_data(:,2),Labels{i});
    SF = cellfun(@(x) ~isempty(x), SF, 'UniformOutput', 0);
    SF = find([SF{:}] == 1);
    Starts=[Starts,SF(1)];
    Ends=[Ends,SF(end)];
end
Starts=sort(Starts);
Ends=sort(Ends);



N=12;
% figure('position',[0 1/3 1 1/3])
edges=linspace(-90,90,N);
xtext=-80;
ytext=0.4;
tt=edges(1:end-1)+diff(edges/2);
prob=unique(round(diff(edges),4));
ax=[-90 90 0 0.5];
fs=12;

Z=xlsread(Name,1);
x=Z(:,6);y=Z(:,7);
theta=deg2rad(Z(:,17));
y=max(y)-y;
l=1;

kk=1;
for j=1:length(Starts)
    
    if Ends(j)>Starts(j)
        xx=x(Starts(j):Ends(j));
        yy=y(Starts(j):Ends(j));
        thth=theta(Starts(j):Ends(j));
        
        eout=fit_ellipse([xx],[yy]);
        phi=eout.phi;
        R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];
        a=eout.a;b=eout.b;X0=eout.X0;Y0=eout.Y0;
        theta_r         = linspace(0,2*pi);
        ellipse_x_r     = X0 + a*cos( theta_r );
        ellipse_y_r     = Y0 + b*sin( theta_r );
        re = R * [ellipse_x_r;ellipse_y_r];
        dx= -a*sin( theta_r );
        dy= b*cos( theta_r );
        rotated_diff = R * [dx;dy];
        at=atan2(rotated_diff(2,:),rotated_diff(1,:));
        
        for i=1:length(xx)
            xy_vec=[xx,yy];
            point=xy_vec(i,:);
            k = dsearchn(re',point);
            Ang_diff_rad(l)=(at(k)-thth(i));
            
            l=l+1;
        end
        
    end
end

Ang_diff_rad=mod(Ang_diff_rad,2*pi);
Ang_diff_rad=mod(Ang_diff_rad,pi);
Ang_diff_rad(Ang_diff_rad>pi/2)=Ang_diff_rad(Ang_diff_rad>pi/2)-pi;

Ang_diff_deg=rad2deg(Ang_diff_rad);
All_data_deg{kk}=Ang_diff_deg;

Histc(:,kk)=histcounts(Ang_diff_deg,edges,'normalization','pdf');
g = fittype( ['exp(1/(',num2str(K(2)),'+k).*cos((deg2rad(x*2)-m)))./(180*besseli(0,1/(',num2str(K(2)),'+k)))'], 'coeff',{'m','k'} );
fo = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',[-90,-K(2)],...
    'Upper',[90,100],...
    'StartPoint',[0 1]);


[ft{kk},goof{kk}]=fit(tt',Histc(:,kk),g,fo);
m=ft{kk}.m;
k=ft{kk}.k;
gg=exp(1/(K(2)+k).*cos((deg2rad(tt*2)-m)))./(180*besseli(0,1/(K(2)+k)));
[~,pp(kk),stats] = chi2gof(All_data_deg{kk},'Expected',gg*length(All_data_deg{kk})*prob,'Edges',edges);



subplot(1,2,2)
bar(tt,Histc(:,kk)*prob,1)
E = length(Ang_diff_deg)/(N-1)*ones(N-1,1); % expected value (equal for uniform dist)
[h,p(kk),stats] = chi2gof(Ang_diff_deg','Expected',E,'Edges',edges')
hold on
plot(linspace(-90,90),exp(1/(K(2)+k).*cos((deg2rad(linspace(-90,90)*2)-m)))./(180*besseli(0,1/(K(2)+k)))*prob,'r')
axis(ax)
legend('off')
xlabel([{'Angle difference between cell and'};{'nearest ellipse tangent in degrees'}],'interpreter','latex')
ylabel('probability','interpreter','latex')
    ci = confint(ft{1});
    text(xtext,ytext,{['Uniform distribution p value ',num2str(round(p(kk),3,'significant'))];...
        ['Von Mises distribution p value ',num2str(round(pp(kk),3,'significant'))];...
        ['Von Mises distribution R^2 value ',num2str(round(goof{kk}.rsquare,4,'significant'))]},'fontsize',fs)
    text(25,ytext,{['Mean= ',num2str(round(m,3,'significant'))];...
        ['k= ',num2str(round(k,3,'significant')),'  [',num2str(round(ci(1,2),3,'significant')),',',num2str(round(ci(2,2),3,'significant')),']']},'fontsize',fs)
    set(gca,'fontsize',fs)
