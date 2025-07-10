X = imread('coco.tif');
X = X(:,:,1);

%2a
Xp2 = imnoise(X,'salt & pepper',0.2);
Xp4 = imnoise(X,'salt & pepper',0.4);
Xp6 = imnoise(X,'salt & pepper',0.6);
subplot(2,2,1);
imshow(X);
subplot(2,2,2);
imshow(Xp2);
subplot(2,2,3);
imshow(Xp4);
subplot(2,2,4);
imshow(Xp6);

%2c
figure;

Xr23 = medianfilter(Xp2,3); % get I_result
subplot(3,3,1);
imshow(Xr23);
peak23 = peak_psnr(Xr23,X); %compute psnr
title(strcat('w=3 p=2 psnr=',int2str(peak23)));

%repeat for different w,p

Xr25 = medianfilter(Xp2,5);
subplot(3,3,2);
imshow(Xr25);
peak25 = peak_psnr(Xr25,X);
title(strcat('w=5 p=2 psnr=',int2str(peak25)));

Xr27 = medianfilter(Xp2,7);
subplot(3,3,3);
imshow(Xr27);
peak27 = peak_psnr(Xr27,X);
title(strcat('w=7 p=2 psnr=',int2str(peak27)));

Xr43 = medianfilter(Xp4,3);
subplot(3,3,4);
imshow(Xr43);
peak43 = peak_psnr(Xr43,X);
title(strcat('w=3 p=4 psnr=',int2str(peak43)));
Xr45 = medianfilter(Xp4,5);
subplot(3,3,5);
imshow(Xr45);
peak45 = peak_psnr(Xr45,X);
title(strcat('w=5 p=4 psnr=',int2str(peak45)));
Xr47 = medianfilter(Xp4,7);
subplot(3,3,6);
imshow(Xr47);
peak47 = peak_psnr(Xr47,X);
title(strcat('w=7 p=4 psnr=',int2str(peak47)));

Xr63 = medianfilter(Xp6,3);
subplot(3,3,7);
imshow(Xr63);
peak63 = peak_psnr(Xr63,X);
title(strcat('w=3 p=6 psnr=',int2str(peak63)));
Xr65 = medianfilter(Xp6,5);
subplot(3,3,8);
imshow(Xr65);
peak65 = peak_psnr(Xr65,X);
title(strcat('w=5 p=6 psnr=',int2str(peak65)));
Xr67 = medianfilter(Xp6,7);
subplot(3,3,9);
imshow(Xr67);
peak67 = peak_psnr(Xr67,X);
title(strcat('w=7 p=6 psnr=',int2str(peak67)));

%2d
figure;

Xr29 = adaptmedian(Xp2,9);
subplot(3,1,1);
imshow(Xr29);
peak29 = peak_psnr(Xr29,X);
title(strcat('wmax=9 p=2 psnr=',int2str(peak29)));
Xr49 = adaptmedian(Xp4,9);
subplot(3,1,2);
imshow(Xr49);
peak49 = peak_psnr(Xr49,X);
title(strcat('wmax=9 p=4 psnr=',int2str(peak49)));
Xr69 = adaptmedian(Xp6,9);
subplot(3,1,3);
imshow(Xr69);
peak69 = peak_psnr(Xr69,X);
title(strcat('wmax=9 p=6 psnr=',int2str(peak69)));

%2e
%We can deal with the boundary pixels in the following ways:
%1: we can adjust the windows centered about boundary pixels so as to
%only include pixels within the domain (I did this in my original
%implementation).
%2: we can adjust the windows centered about boundary pixels so that the
%window is instead centered about the nearest pixel that isn't on the
%boundary; this would result in several boundary pixels sharing the same
%window but that's alright since its only a few pixels and it eliminates
%the noise for the most part.

%2f
Xv2 = imnoise(X,'gaussian',0,0.05);
Xv4 = imnoise(X,'gaussian',0,0.1);
Xv6 = imnoise(X,'gaussian',0,0.2);
figure;
subplot(2,2,1);
imshow(X);
subplot(2,2,2);
imshow(Xv2);
subplot(2,2,3);
imshow(Xv4);
subplot(2,2,4);
imshow(Xv6);

figure;

Xvr2 = adaptmedian(Xv2,9);
subplot(3,1,1);
imshow(Xvr2);
peakv2 = peak_psnr(Xvr2,X);
title(strcat('wmax=9 v=0.05 psnr=',int2str(peakv2)));
Xvr4 = adaptmedian(Xv4,9);
subplot(3,1,2);
imshow(Xvr4);
peakv4 = peak_psnr(Xvr4,X);
title(strcat('wmax=9 v=0.1 psnr=',int2str(peakv4)));
Xvr6 = adaptmedian(Xv6,9);
subplot(3,1,3);
imshow(Xvr6);
peakv6 = peak_psnr(Xvr6,X);
title(strcat('wmax=9 v=0.2 psnr=',int2str(peakv6)));

%commenting on the denoised gaussian noise images: it appears that the
%denoising algorithm we are using has little to no effect on the noise.
%This makes sense since all of the pixels are changed by a bit on average 
%rather than changing a few select pixels by a lot; the algorithm we use
%takes advantage of the salt and pepper noise by using a median but this
%does not work with the evenly spread noise of the gaussian distribution.