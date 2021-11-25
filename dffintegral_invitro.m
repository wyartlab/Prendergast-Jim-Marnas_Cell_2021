function output = dffintegral_invitro(nframes,freq,light)

%selection of the cells with ROIs 
% background 

output=struct('M', [], 'rois', [], 'rois_background', [], 'dff', [], 'raw', [], 'dff_background', [], 'raw_background',[],'amplitude1', [], 'time1', [],'amplitude2', [], 'time2', [],'amplitude3', [], 'time3', [],'adj', [], 'adj_background',[], 'delay1', [], 'timetopeak1', [],'delay2', [], 'timetopeak2', [],'delay3', [], 'timetopeak3', [], 'stand_d', [], 'dfftau1', [], 'dfftau2', [], 'dfftau3', [], 'alldfftau', []);

% removed from initialisation : 'allfreq_background',[], 'allfreq',[], 

%freq in Hz
%light in frames -> you have to put here the time (in frames) corresponding to the exact frame where
%the first light flash appears when you stimulate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
disp ('Choose image acquisition file')
[image, folder] = uigetfile('*.*');
imagefile = strcat(folder, image);

% If you want to manually select image to choose ROIs from, uncomment below

disp ('Choose image to select ROIs - make sure to inverse contrast before so that you easily draw ROIs')
[file2, folder2]= uigetfile('*.*');
StanDev = strcat(folder2, file2);

% Here you convert your files using multitiff2M function for your movie (M)
% and your STD image (M_std)

M=multitiff2M(imagefile,1:nframes);
x_dim = length(M(1,:,1));
y_dim = length(M(:,1,1));
M_std = multitiff2M([StanDev],1);

output.M=M;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Starting selecting the ROIs corresponding to the cells (rois) and
% background (rois_background)

figure;I=imread(StanDev);imshow(I);
disp('Choose first set of ROIs')
rois = getROIcell;
close all

figure;I=imread(StanDev);imshow(I);
disp('Choose second set of ROIs for the background (same number of ROIs than for the first set)')
rois_background = getROIcell;
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate mask from rois

% for cells of interest:

if isempty(rois)
    dff = [];
    raw = [];
    Mask = [];
    int = [];
else

for i=1:size(rois,2) 
    Mask{i} = roipoly(imread(imagefile),rois{i}(:,1),rois{i}(:,2));
end

% for background cells:

if isempty(rois_background)
    dff_background = [];
    raw_background = [];
    Mask_background = [];
    int_background = [];
else
    
for i=1:size(rois_background,2)
    Mask_background{i} = roipoly(imread(imagefile),rois_background{i}(:,1),rois_background{i}(:,2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Registration of the movie to align all frames to the first reference
% Frame -- FIY a translation in X and Y is used here

% Click to define here the rectangle where your cells of interest are 
% located [xmin ymin width height]

Answer=0;
ref=1;

while Answer==0
disp('now it is time to pick a SMALL rectangle in the center of the image to perform the registration')
fig = figure(1);
hold off
imagesc(M_std);
axis equal
rect = floor(getrect(fig));
rectindX = [rect(1):(rect(1)+rect(3))];
rectindY = [rect(2):(rect(2)+rect(4))];
template = M(rectindY, rectindX, ref);

bigrectX=1:size(M,2);
bigrectY=1:size(M,1);

% Initialize the registered movie Mr to be registered and the offset

Mr = M;
Xoffset=[];
Yoffset=[];
TransXY=zeros(length(1:nframes),2);
h=waitbar(0,'Percentage of processed frames'); 
for i=1:size(M,3)
    waitbar(i/size(M,3),h);
    out = normxcorr2(template,M(bigrectY,bigrectX,i));
    imshow(out);
    size(out);
    [~,ind] = max(abs(out(:)));
    [Yp,Xp] = ind2sub(size(out),ind);
    % bottom right corner matters
    Yoffset = (Yp-size(template,1))-(rect(2))+1;
    Xoffset = (Xp-size(template,2))-(rect(1))+1;
    
    TransXY(i,:)=[Yoffset,Xoffset];
    % [BW,xi,yi] = roipoly(M(:,:,1));
    se = translate(strel(1), [-Yoffset -Xoffset]);
    Mr(:,:,i) = imdilate(M(:,:,i),se);
end
close(h)

%create avi file and check ROIs

M2avi_color_ROIs(Mr,'Gr_avi', rois);
Answer=input('Is it ok?''1 if yes, 0 if no\n');
end

%Correction to avoid having -Inf after motion correction

Mr(Mr<0)=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Using corrected frames: calculate dff, find a threshold
% minima, fit polynomial to minima, subtract dff trace from polynomial
% function, calculate integral normalized per roi per minute

% Cells of interest:

% Calculate dff for rois

[dff, raw] = calc_dff(Mr, Mask, size(rois,2));

output.dff = dff;
output.raw=raw;
output.rois=rois;

% Look for baseline with minimum points on the DFF curve
 
for i=1:size(rois,2)
    
    [min, ind] = lmin(dff(:,i),10);
    [fit_cells, gof_cells, out_cells] = fit(ind', min', 'poly2', 'Normalize', 'on');
    base (:,i) = feval(fit_cells, [1:nframes])';
    adj(:,i) = dff(:,i)-base(:,i);
    int(:,i) = trapz(adj(:,i));
    int(:,i) = int(:,i)/nframes*freq*60;
    
end
    int = int';
end

% Cells of background:

% Calculate dff for rois

[dff_background, raw_background] = calc_dff(Mr, Mask_background, size(rois_background,2));
   
output.dff_background = dff_background;
output.raw_background=raw_background;
output.rois_background=rois_background;

% Look for baseline with minimum points on the DFF curve

for i=1:size(rois_background,2)
  
    [min_background, ind_background] = lmin(dff_background(:,i),100);
    [fit_background, gof_background, out_background] = fit(ind_background', min_background', 'poly2', 'Normalize', 'on');
    base_background (:,i) = feval(fit_background, [1:nframes])';
    adj_background(:,i) = dff_background(:,i)-base_background(:,i);
    int_background(:,i) = trapz(adj_background(:,i));
    int_background(:,i) = int_background(:,i)/nframes*freq*60;

   end

    int_background = int_background';
    
end

% Generate png/fig for mask of rois for cells of interest and background

figure; imshow(StanDev);
for i=1:length(rois)
    patch(rois{1,i}(:,1),rois{1,i}(:,2),'m','FaceAlpha',0.55);
    text(rois{1,i}(1,1),rois{1,i}(1,2),num2str(i),'Color','b');
    hold on;
end
for i=1:length(rois_background)
    patch(rois_background{1,i}(:,1),rois_background{1,i}(:,2),'g','FaceAlpha',0.55);
    text(rois_background{1,i}(1,1),rois_background{1,i}(1,2),num2str(i),'Color','b');
    hold on;
end
title('ROIs magenta cells and green background','FontSize', 18);
rois = strcat(folder, 'ROIs');
saveas(gcf, rois,'fig'); 
saveas(gcf, rois,'png');
close all

output.adj=adj;
output.adj_background=adj_background;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Creates a figure showing the dff of cells of interest and background

figure(10);

for i=1:size(dff_background,2)
    subplot(2,1,1);plot([1:1:nframes],dff_background(:,i),'k');
    xlabel('Time in frames')
    ylabel('dff of background')
    hold off
end

sd_dff = {};
stand_d = [];
sd_window = [];

for i=1:size(dff,2)
    hold on;
    subplot(2,1,2); plot([1:1:nframes],dff(:,i),'r');
    xlabel('Time in frames')
    ylabel('dff for cells')
    hold on;
    puff1 = light+63.7;
    puff2 = puff1+320;
    puff3 = puff2+320;
    ypuff(:,1)=ones(1,1001);
    ypuff(:,2)=[0:0.1:100];
    plot([puff1 puff1],[ypuff],'b');
    hold on;
    plot([puff2 puff2],[ypuff],'b');
    hold on;
    plot([puff3 puff3],[ypuff],'b');
    hold off

% Use the dff figure to select points to calculate the standard deviation
% of each ROI

disp('pick two spots to calculate the standard deviation')

sd_window(:,:,i) = ginput;
sd_dff{i} = dff(round(sd_window(1,1,i)):round(sd_window(2,1,i)));
stand_d(i,1) = std(sd_dff{i});

clear baseline
close all

end

% If the movie is a control movie for spontaneous activity, use the 
% dff figure already generated to select points corresponding to
% 1) the start of the stimulation, 2) the start of the response,
% 3) the max peak of the response, 4) the beggining of the decay
% and 5) the end of the decay 

response1=[];
time1=[];
delay1=[];
timetopeak1=[];
amplitude1=[];
dfftau1={};

response2=[];
time2=[];
delay2=[];
timetopeak2=[];
amplitude2=[];
dfftau2={};

response3=[];
time3=[];
delay3=[];
timetopeak3=[];
amplitude3=[];
dfftau3={};
        
control_movie = input('Is it a control movie for spontaneous activity? (1 = Yes, 2 = No): ');

if control_movie == 1
    for i=1:size(dff,2)  
        hold on;
        subplot(2,1,2); plot([1:1:nframes],dff(:,i),'r');
        xlabel('Time in frames')
        ylabel('dff for cells')
        hold on;
        puff1 = light+63.7;
        puff2 = puff1+320;
        puff3 = puff2+320;
        ypuff(:,1)=ones(1,1001);
        ypuff(:,2)=[0:0.1:100];
        plot([puff1 puff1],[ypuff],'b');
        hold on;
        plot([puff2 puff2],[ypuff],'b');
        hold on;
        plot([puff3 puff3],[ypuff],'b');
        hold off
        
        %%%%%% Puff 1 %%%%%%
        
        disp('pick first response 5 spots with start stim, response start, response peak, start end, and end of the decay')
        
        response1(:,:,i) = ginput;
        time1(i,1) = round(response1(1,1,i));
        time1(i,2) = round(response1(2,1,i));
        time1(i,3) = round(response1(3,1,i));
        time1(i,4) = round(response1(4,1,i));
        time1(i,5) = round(response1(5,1,i));

        delay1(i,:)=time1(i,2)-time1(i,1);
        timetopeak1(i,:)=time1(i,3)-time1(i,2);

        amplitude1(i,1)=dff(round(response1(1,1,i)));
        amplitude1(i,2)=dff(round(response1(2,1,i)));
        amplitude1(i,3)=dff(round(response1(3,1,i)));
        amplitude1(i,4)=dff(round(response1(4,1,i)));
        amplitude1(i,5)=dff(round(response1(5,1,i)));

        if amplitude1(i,3)-amplitude1(i,1) > stand_d(i,1)*3
        dfftau1{i} = dff(time1(i,4):time1(i,5));
        else
        time1(i,5) = NaN;
        dfftau1{i} = NaN;
        end
    
        %%%%%% Puff 2 %%%%%%
        
        display('pick second response 5 spots with start stim, response start, response peak, start end, and end of the decay')
        
        response2(:,:,i) = ginput;
        time2(i,1) = round(response2(1,1,i));
        time2(i,2) = round(response2(2,1,i));
        time2(i,3) = round(response2(3,1,i));
        time2(i,4) = round(response2(4,1,i));
        time2(i,5) = round(response2(5,1,i));

        delay2(i)=time2(i,2)-time2(i,1);
        timetopeak2(i)=time2(i,3)-time2(i,2);

        amplitude2(i,1)=dff(round(response2(1,1,i)));
        amplitude2(i,2)=dff(round(response2(2,1,i)));
        amplitude2(i,3)=dff(round(response2(3,1,i)));
        amplitude2(i,4)=dff(round(response2(4,1,i)));
        amplitude2(i,5)=dff(round(response2(5,1,i)));

        if amplitude2(i,3)-amplitude2(i,1) > stand_d(i,1)*3
            dfftau2{i} = dff(time2(i,4):time2(i,5));
        else
            time2(i,5) = NaN;
            dfftau2{i} = NaN;
        end
    
        %%%%%% Puff 3 %%%%%%
        
        disp('pick third response 5 spots with start stim, response start, response peak, start end, and end of the decay')
        
        response3(:,:,i) = ginput;
        time3(i,1) = round(response3(1,1,i));
        time3(i,2) = round(response3(2,1,i));
        time3(i,3) = round(response3(3,1,i));
        time3(i,4) = round(response3(4,1,i));
        time3(i,5) = round(response3(5,1,i));

        delay3(i)=time3(i,2)-time3(i,1);
        timetopeak3(i)=time3(i,3)-time3(i,2);

        amplitude3(i,1)=dff(round(response3(1,1,i)));
        amplitude3(i,2)=dff(round(response3(2,1,i)));
        amplitude3(i,3)=dff(round(response3(3,1,i)));
        amplitude3(i,4)=dff(round(response3(4,1,i)));
        amplitude3(i,5)=dff(round(response3(5,1,i)));

        if amplitude3(i,3)-amplitude3(i,1) > stand_d(i,1)*3
            dfftau3{i} = dff(time3(i,4):time3(i,5));
        else
            time3(i,5) = NaN;
            dfftau3{i} = NaN;
        end
    clear baseline
    close all
    end
else
    clear baseline
    close all
end

clear baseline
close all

% If your movie is a movie with puffs, it uses specific dff figure for
% the regions around each puff to select points corresponding to
% 1) the start of the stimulation, 2) the start of the response,
% 3) the max peak of the response, 4) the beggining of the decay 
% and 5) the end of the decay and thus for the 3 puffs
% Delay, time to peak, amplitude and tau variables are made from those
% points for each puff

if control_movie == 2

    clear baseline;
    close all

    for i=1:size(dff,2)
        
        %%%%%% Puff 1 %%%%%%

        subplot(2,1,1);plot([light+5:1:light+300],dff_background(light+5:1:light+300,i),'k');
        xlabel('Time in frames')
        ylabel('dff of background')

        hold on;
        subplot(2,1,2); plot([light+5:1:light+300],dff(light+5:1:light+300,i),'r');
        xlabel('Time in frames')
        ylabel('dff for cells')
        hold on;
        puff1 = light+63.7;
        ypuff(:,1)=ones(1,1001);
        ypuff(:,2)=[0:0.1:100];
        plot([puff1 puff1],[ypuff],'b');
        hold off

        disp('pick first response 5 spots with start stim, response start, response peak, start end, and end of the decay')
        
        response1(:,:,i) = ginput;
        time1(i,1) = round(response1(1,1,i));
        time1(i,2) = round(response1(2,1,i));
        time1(i,3) = round(response1(3,1,i));
        time1(i,4) = round(response1(4,1,i));
        time1(i,5) = round(response1(5,1,i));

        delay1(i)=time1(i,2)-time1(i,1);
        timetopeak1(i)=time1(i,3)-time1(i,2);

        amplitude1(i,1)=dff(round(response1(1,1,i)));
        amplitude1(i,2)=dff(round(response1(2,1,i)));
        amplitude1(i,3)=dff(round(response1(3,1,i)));
        amplitude1(i,4)=dff(round(response1(4,1,i)));
        amplitude1(i,5)=dff(round(response1(5,1,i)));

        if amplitude1(i,3)-amplitude1(i,1) > stand_d(i,1)*3
            dfftau1{i} = dff(time1(i,4):time1(i,5));
        else
            time1(i,5) = NaN;
            dfftau1{i} = NaN;
        end

        clear baseline;
        close all

        %%%%%% Puff 2 %%%%%%

        subplot(2,1,1);plot([light+325:1:light+620],dff_background(light+325:1:light+620,i),'k');
        xlabel('Time in frames')
        ylabel('dff of background')

        hold on;
        subplot(2,1,2); plot([light+325:1:light+620],dff(light+325:1:light+620,i),'r');
        xlabel('Time in frames')
        ylabel('dff for cells')
        hold on;
        puff2 = puff1+320;
        ypuff(:,1)=ones(1,1001);
        ypuff(:,2)=[0:0.1:100];
        plot([puff2 puff2],[ypuff],'b');
        hold off

        display('pick second response 5 spots with start stim, response start, response peak, start end, and end of the decay')
      
        response2(:,:,i) = ginput;
        time2(i,1) = round(response2(1,1,i));
        time2(i,2) = round(response2(2,1,i));
        time2(i,3) = round(response2(3,1,i));
        time2(i,4) = round(response2(4,1,i));
        time2(i,5) = round(response2(5,1,i));

        delay2(i)=time2(i,2)-time2(i,1);
        timetopeak2(i)=time2(i,3)-time2(i,2);

        amplitude2(i,1)=dff(round(response2(1,1,i)));
        amplitude2(i,2)=dff(round(response2(2,1,i)));
        amplitude2(i,3)=dff(round(response2(3,1,i)));
        amplitude2(i,4)=dff(round(response2(4,1,i)));
        amplitude2(i,5)=dff(round(response2(5,1,i)));

        if amplitude2(i,3)-amplitude2(i,1) > stand_d(i,1)*3
            dfftau2{i} = dff(time2(i,4):time2(i,5));
        else
            time2(i,5) = NaN;
            dfftau2{i} = NaN;
        end

        clear baseline;
        close all

        %%%%%% Puff 3 %%%%%%

        subplot(2,1,1);plot([light+645:1:light+940],dff_background(light+645:1:light+940,i),'k');
        xlabel('Time in frames')
        ylabel('dff of background')

        hold on;
        subplot(2,1,2); plot([light+645:1:light+940],dff(light+645:1:light+940,i),'r');
        xlabel('Time in frames')
        ylabel('dff for cells')
        hold on;
        puff3 = puff2+320;
        ypuff(:,1)=ones(1,1001);
        ypuff(:,2)=[0:0.1:100];
        plot([puff3 puff3],[ypuff],'b');
        hold off

        disp('pick third response 5 spots with start stim, response start, response peak, start end, and end of the decay')

        response3(:,:,i) = ginput;
        time3(i,1) = round(response3(1,1,i));
        time3(i,2) = round(response3(2,1,i));
        time3(i,3) = round(response3(3,1,i));
        time3(i,4) = round(response3(4,1,i));
        time3(i,5) = round(response3(5,1,i));

        delay3(i)=time3(i,2)-time3(i,1);
        timetopeak3(i)=time3(i,3)-time3(i,2);

        amplitude3(i,1)=dff(round(response3(1,1,i)));
        amplitude3(i,2)=dff(round(response3(2,1,i)));
        amplitude3(i,3)=dff(round(response3(3,1,i)));
        amplitude3(i,4)=dff(round(response3(4,1,i)));
        amplitude3(i,5)=dff(round(response3(5,1,i)));

        if amplitude3(i,3)-amplitude3(i,1) > stand_d(i,1)*3
            dfftau3{i} = dff(time3(i,4):time3(i,5));
        else
            time3(i,5) = NaN;
            dfftau3{i} = NaN;
        end
        clear baseline;
        close all
    end
    else
    clear baseline;
    close all
end

clear baseline;
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Bring all the dfftau values together

alldfftau = [dfftau1;dfftau2;dfftau3];

clear baseline;
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate a figure to save the dff plot with the puffs


Fig = figure('Position', get(0, 'Screensize'));
for i=1:size(dff,2); 
    subplot((round(size(dff,2)/2)),3,i);
    plot([1:1:nframes]/freq,dff(:,i),'r');
    hold on
    xlabel('Time in seconds');
    ylabel('DFF for cells');
    ypuff(:,1)=ones(1,1001);
    ypuff(:,2)=[0:0.1:100];
    plot([puff1/freq puff1/freq],[ypuff],'b');
    hold on
    plot([puff2/freq puff2/freq],[ypuff],'b');
    hold on
    plot([puff3/freq puff3/freq],[ypuff],'b');
    hold off
end
suptitle('cells correctedDFF');
vccd = strcat(folder, 'cells correctedDFF');
saveas(gcf,vccd,'fig');
saveas(gcf,vccd,'png');

output.time1=time1;
output.time2=time2;
output.time3=time3;
output.amplitude1=amplitude1;
output.amplitude2=amplitude2;
output.amplitude3=amplitude3;
output.delay1=delay1;
output.delay2=delay2;
output.delay3=delay3;
output.timetopeak1=timetopeak1;
output.timetopeak2=timetopeak2;
output.timetopeak3=timetopeak3;
output.stand_d=stand_d;
output.dfftau1=dfftau1;
output.dfftau2=dfftau2;
output.dfftau3=dfftau3;
output.alldfftau=alldfftau;

save(strcat(folder,'Analysis','.mat'),'output');

clear baseline;
close all
 end