ccc
Name='NEW_MZ_Results';
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
sort(Starts)
sort(Ends)


%%

N=12;
edges=linspace(-90,90,N);
fs=12;

Z=xlsread(Name,1);

l=1;
x=Z(:,6);y=Z(:,7);theta=deg2rad(Z(:,17));L=Z(:,15);
y=max(y)-y;
p=x+1i*y+[-L.*exp(1i*theta) L.*exp(1i*theta)]/2;
p1=x+1i*y+L.*exp(1i*theta);

for j=1:length(Starts)
    subplot(2,7,j)
    plot(x(Starts(j):Ends(j)),y(Starts(j):Ends(j)),'.','markersize',20);
    
    hold on
    % for i=1:14
    %     text(x(i),y(i),num2str(i))
    % end
    plot([real(p(Starts(j):Ends(j),1)) real(p(Starts(j):Ends(j),2))]',[imag(p(Starts(j):Ends(j),1)) imag(p(Starts(j):Ends(j),2))]')
    plot([real(p(Starts(j):Ends(j),2))]',[imag(p(Starts(j):Ends(j),2))]','dk','markersize',5);
    axis equal
    axis tight
    %     view([0 -90])
end


