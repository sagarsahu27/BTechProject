filename = 'data.txt';
delimiterIn = ' ';
headerlinesIn =0;
train = importdata(filename,delimiterIn,headerlinesIn);
filename1 = 'sample.txt';
delimiterIn = ' ';
headerlinesIn =0;
sample = importdata(filename1,delimiterIn,headerlinesIn);
group = [3 ;1 ; 1; 0; 2;  1 ; 3 ; 0 ; 1 ; 3 ; 3 ; 2 ; 2 ; 3 ; 0;1 ; 0 ;0 ;0 ;0 ;0 ;2 ;2 ];
%grp = ['normal';'mild';'moderate';'severe'];
gscatter(group,train(:,2),group,'bgrc','xo+*');
%gscatter(train(:,1),train(:,2),group,'bgrc','xo+*');
xlabel('Severity');
ylabel('density');
class = knnclassify(sample, train(:,2),train(:,3));
[x y] = size(class);
disease = zeros(size(class));
 fid = fopen('output.txt','w');
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
