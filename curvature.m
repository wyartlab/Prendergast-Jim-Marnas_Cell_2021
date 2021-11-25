clear all; 
disp ('Choose image acquisition file')
[image folder] = uigetfile('*.*');
imagefile = strcat(folder, image);
figure;I=imread(imagefile);imshow(I);

I=imread(imagefile);
imshow(I);
[x,y]=ginput; 
vertices= [x,y];

K = LineCurvature2D(vertices);

A = [x.^2+y.^2,x,y,ones(size(x))];
[U,S,V] = svd(A,0);
a = V(1,4); b = V(2,4);
c = V(3,4); d = V(4,4);
xc = -b/(2*a); yc = -c/(2*a);
r = sqrt(xc^2+yc^2-d/a);
curv = 1/r;

save analysis
close all;
% 
% 
% young = NaN(79,3);
% old = NaN(79,3);
% for i=1:79;
%     if a(i,1) == 0 & a(i,2) == 5;
%         young(i,1)=a(i,3);
%     end;
%      if a(i,1) == 1 & a(i,2) == 5;
%         young(i,2)=a(i,3);
%     end;
%      if a(i,1) == 2 & a(i,2) == 5;
%         young(i,3)=a(i,3);
%     end;
%     
%     if a(i,1) == 0 & a(i,2) == 19;
%         old(i,1)=a(i,3);
%     end;
%      if a(i,1) == 1 & a(i,2) == 19;
%         old(i,2)=a(i,3);
%     end;
%      if a(i,1) == 2 & a(i,2) == 19;
%         old(i,3)=a(i,3);
%     end;
% end;
% figure;subplot(1,2,1);boxplot(young);hold on; plotSpread(young); hold off; subplot(1,2,2);boxplot(old); hold on; plotSpread(old);