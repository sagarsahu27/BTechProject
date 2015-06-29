
clc;clear;
I=imread('27.png'); % Read an image
figure; imshow(I)
IG = rgb2gray(I);
[M,N] = size(IG);
G(:,:,2) = I(:,:,2);
G(:,:,1) = 0;
G(:,:,3) = 0;
Y = rgb2gray(G);
figure; imshow(Y)
sa = 2.0;
rt = mim(Y,sa);
figure; imshow(rt)
[tt1,e1,cmtx] = myThreshold(rt);

ms = 45;    
mk = msk(IG,ms);
k = nnz(mk);
figure; imshow(mk)

rt2 = 255*ones(M,N);
for i=1:M
    for j=1:N
        if rt(i,j)>=tt1 & mk(i,j)==255
            rt2(i,j)=0;
        end
    end
end
figure; imshow(rt2)
J = im2bw(rt2); 
figure; imshow(J)
J= ~J;
[Label,Num] = bwlabel(J);
Lmtx = zeros(Num+1,1);
for i=1:M
    for j=1:N
        Lmtx(double(Label(i,j))+1) = Lmtx(double(Label(i,j))+1) + 1;
    end
end
sLmtx = sort(Lmtx);
cp = 950;
for i=1:M
    for j=1:N
        if (Lmtx(double(Label(i,j)+1)) > cp) & (Lmtx(double(Label(i,j)+1)) ~= sLmtx(Num+1,1))
            J(i,j) = 0;
        else
            J(i,j) = 1;
        end
    end
end
for i=1:M
    for j=1:N
        if mk(i,j)==0
            J(i,j)=1;
        end
    end
end
J = 1 - J;

figure; imshow(J);
count = nnz(J);
display(count);
res = count * 100/ k;
display(res);
fid = fopen('sample.txt', 'wt');
fprintf(fid, '%12.8f \n', res);
fclose(fid);
classifyData;