%Robert Martinez
% SID: 861238333
% Date: 4/5/17
% CS171 PS1
function plotdata (filename);

data = importdata(filename);
[row, col]=size(data);
% number of features divided by number of subplots per row
p_col = ceil(col/4);
y = data(:,end);
for i=1:col-1;
        subplot(p_col,4,i);
        x = data(:,i);
        plot(x,y, '.')
        ylabel('Y output')
        x_txt = sprintf('feature %i', i);
        xlabel(x_txt)
end %for

end %function



