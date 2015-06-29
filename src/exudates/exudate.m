BW = imread('m.jpg');
imshow(BW);
gra =BW;
gra(:,:,1) = medfilt2(gra(:,:,1));
hisimg = adapthisteq(gra(:,:,1));
%hisimg = 1.2 * hisimg;
figure;imshow(hisimg);
 
se = strel('disk',15);
climg = imclose(hisimg,se);
%BW1 = edge(climg,'sobel',.45);
%imshow(climg);
 figure; imshow(climg);
b = graythresh(climg);
binimg = im2bw(climg,b+0.4); %.73
imshow(binimg);
[M N]= size(climg);
tmpimg = hisimg;
r =uint16(5*M*N/1000000);
r = double(r*1000);
display(r);
 figure; imshow(binimg);
 s = bwareaopen(binimg,r);
 t = im2bw(gra(:,:,2),0.4);
u = t-s;
imshow(u);
[M N]= size(u);
for i =1:M,
    for j=1:N,
        if(u(i,j)==1)
            gra(i,j,1) = 0;
            gra(i,j,2) = 255;
            gra(:,:,3) = 0;
        end
    end
end
imshow(gra);