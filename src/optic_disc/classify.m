filename = 'data.txt';
delimiterIn = ' ';
headerlinesIn =0;
'reading Data'
train = importdata(filename,delimiterIn,headerlinesIn);
%train
filename1 = 'sample.txt';
pause;
delimiterIn = ' ';
headerlinesIn =0;
sample = importdata(filename1,delimiterIn,headerlinesIn);
'training algorithm'
pause;
%size(train)
group = train(:,3);
%grp = ['normal';'mild';'moderate';'severe'];
gscatter(train(:,1),train(:,2),group,'bgrc','xo+*');
xlabel('Area of optic Disc');
ylabel('density');
'plotting data'
pause;
'Classify given sample data'
class = knnclassify(sample, train(:,2),train(:,3));
[x y] = size(class);
disease = zeros(size(class));
 fid = fopen('output.txt','w');
 ' writting output '
 pause;
for i = 1:x
    if(class(i)==0)
        disease= 'normal';
    end
    if(class(i)==1)
        disease= 'mild';
    end
    if(class(i)==2)
        disease= 'moderate';
    end
    if(class(i)==3)
        disease= 'severe';
    end
   
fprintf(fid,'%s\n',disease);


end
fclose(fid);
%dlmwrite('output.txt',class,'-append');
