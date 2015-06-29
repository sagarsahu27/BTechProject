filen = '2.png';
%filen = 'input.jpg';
a = imread(filen);
figure; imshow(a);
xz='image read'
pause;
%gra = rgb2hsi(a);
gra =a;
gra(:,:,1) = medfilt2(gra(:,:,1));
hisimg = adapthisteq(gra(:,:,1));
%hisimg = 1.2 * hisimg;
figure;imshow(hisimg);
xz='image enhance'
 pause;
se = strel('disk',15);
climg = imclose(hisimg,se);
%BW1 = edge(climg,'sobel',.6);
%imshow(climg);
 figure; imshow(climg);
 xz='Close operation applied'
 pause;
b = graythresh(climg);
binimg = im2bw(climg,b+0.5); %.73
%imshow(binimg);
[M N]= size(climg);
tmpimg = hisimg;
r =uint16(5*M*N/1000000);
r = double(r*1000);
display(r);
 figure; imshow(binimg);
 xz='segmentation done'
 pause;
 s = bwareaopen(binimg,r);
 figure; imshow(s);
xz= 'optic disc localisation done'
 pause;
for i =1:M,
    for j=1:N,
        if(s(i,j)==1)
            tmpimg(i,j) = 0;
             a(i,j,3) = 255;
             a(i,j,2) = 0;
        end
    end
end

figure; imshow(a);
xz='Mapping done'
pause;
IG = rgb2gray(a);
ms = 45;    
mk = msk(IG,ms);

eyepix = nnz(mk);
odpix = nnz(s);
od2eye = odpix*100/eyepix;
display('OD to Eye ratio is '); display(od2eye);
fid = fopen('sample.txt', 'wt');
fprintf(fid, '%6.2f  \n',od2eye);
fclose(fid);
xz='Calculation Done'
pause;
xz='Calling classifier'
classify;