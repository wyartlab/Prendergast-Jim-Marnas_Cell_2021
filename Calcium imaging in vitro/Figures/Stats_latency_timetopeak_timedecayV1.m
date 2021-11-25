function output = Stats_latency_timetopeak_timedecayV1()

clear 
close all

output=struct('hypothesis_kstest2',[],'p_value_kstest2',[],'stats_kstest2',[],'hypothesis_kstest2_timedecay',[],'p_value_kstest2_timedecay',[],'stats_kstest2_timedecay',[]);

freq = 5; %Your frequency in Hertz;
n = 3; %Number of frames to add before and after for your peak amplitude

%%% Data for latency and timetopeak %%%

%Takes all your content cells output and extract all the peak amplitude and
%put them in "amplis_afterallpuff_content"

disp('Select ALL your "content" outputs')
[content, folder_content] = uigetfile('*.*','MultiSelect','on');
nTrials_content = size(content,2);

for i = 1:nTrials_content;
    contentData(i,1) = load(fullfile(folder_content, content{i}));
    for j = 1:size(contentData(i).output.dff,2)
        dff_content{i,j} = contentData(i).output.dff(:,j);
        if isnan(contentData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time1(j,1)-(2*n):1:contentData(i).output.time1(j,1),j));
            amplispuff_peak1_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time1(j,3)-n:1:contentData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content(i,j) = NaN;
            delay_peak1_content(i,j) = NaN;
        else
            amplis_peak1_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time1(j,1)-(2*n):1:contentData(i).output.time1(j,1),j));
            amplispuff_peak1_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time1(j,3)-n:1:contentData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content(i,j) = contentData(i).output.time1(j,3)/freq - contentData(i).output.time1(j,2)/freq;
            delay_peak1_content(i,j) = contentData(i).output.time1(j,2)/freq - contentData(i).output.time1(j,1)/freq;
        end
        if isnan(contentData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time2(j,1)-(2*n):1:contentData(i).output.time2(j,1),j));
            amplispuff_peak2_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time2(j,3)-n:1:contentData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content(i,j) = NaN;
            delay_peak2_content(i,j) = NaN;
        else
            amplis_peak2_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time2(j,1)-(2*n):1:contentData(i).output.time2(j,1),j));
            amplispuff_peak2_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time2(j,3)-n:1:contentData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content(i,j) = contentData(i).output.time2(j,3)/freq - contentData(i).output.time2(j,2)/freq;
            delay_peak2_content(i,j) = contentData(i).output.time2(j,2)/freq - contentData(i).output.time2(j,1)/freq;
        end
        if isnan(contentData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time3(j,1)-(2*n):1:contentData(i).output.time3(j,1),j));
            amplispuff_peak3_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time3(j,3)-n:1:contentData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content(i,j) = NaN;
            delay_peak3_content(i,j) = NaN;
        else
            amplis_peak3_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time3(j,1)-(2*n):1:contentData(i).output.time3(j,1),j));
            amplispuff_peak3_content(i,j) = mean(contentData(i).output.dff(contentData(i).output.time3(j,3)-n:1:contentData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content(i,j) = contentData(i).output.time3(j,3)/freq - contentData(i).output.time3(j,2)/freq;
            delay_peak3_content(i,j) = contentData(i).output.time3(j,2)/freq - contentData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content(amplis_peak1_content == 0) = NaN;
amplis_peak2_content(amplis_peak2_content == 0) = NaN;
amplis_peak3_content(amplis_peak3_content == 0) = NaN;
amplispuff_peak1_content(amplispuff_peak1_content == 0) = NaN;
amplispuff_peak2_content(amplispuff_peak2_content == 0) = NaN;
amplispuff_peak3_content(amplispuff_peak3_content == 0) = NaN;
timetopeak_peak1_content(timetopeak_peak1_content == 0) = NaN;
timetopeak_peak2_content(timetopeak_peak2_content == 0) = NaN;
timetopeak_peak3_content(timetopeak_peak3_content == 0) = NaN;
delay_peak1_content(delay_peak1_content == 0) = NaN;
delay_peak2_content(delay_peak2_content == 0) = NaN;
delay_peak3_content(delay_peak3_content == 0) = NaN;
amplis_afterpuff1_content = amplispuff_peak1_content - amplis_peak1_content;
amplis_afterpuff2_content = amplispuff_peak2_content - amplis_peak2_content;
amplis_afterpuff3_content = amplispuff_peak3_content - amplis_peak3_content;
amplis_afterallpuff_content = [amplis_afterpuff1_content;amplis_afterpuff2_content;amplis_afterpuff3_content];
delay_content = [delay_peak1_content;delay_peak2_content;delay_peak3_content];
timetopeak_content = [timetopeak_peak1_content;timetopeak_peak2_content;timetopeak_peak3_content];


%Takes all your content cells 2 output and extract all the peak amplitude and
%put them in "amplis_afterallpuff_content2"

disp('Select ALL your "content2" outputs')
[content2, folder_content2] = uigetfile('*.*','MultiSelect','on');
nTrials_content2 = size(content2,2);

for i = 1:nTrials_content2;
    content2Data(i,1) = load(fullfile(folder_content2, content2{i}));
    for j = 1:size(content2Data(i).output.dff,2)
        dff_content2{i,j} = content2Data(i).output.dff(:,j);
        if isnan(content2Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time1(j,1)-(2*n):1:content2Data(i).output.time1(j,1),j));
            amplispuff_peak1_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time1(j,3)-n:1:content2Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content2(i,j) = NaN;
            delay_peak1_content2(i,j) = NaN;
        else
            amplis_peak1_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time1(j,1)-(2*n):1:content2Data(i).output.time1(j,1),j));
            amplispuff_peak1_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time1(j,3)-n:1:content2Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content2(i,j) = content2Data(i).output.time1(j,3)/freq - content2Data(i).output.time1(j,2)/freq;
            delay_peak1_content2(i,j) = content2Data(i).output.time1(j,2)/freq - content2Data(i).output.time1(j,1)/freq;
        end
        if isnan(content2Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time2(j,1)-(2*n):1:content2Data(i).output.time2(j,1),j));
            amplispuff_peak2_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time2(j,3)-n:1:content2Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content2(i,j) = NaN;
            delay_peak2_content2(i,j) = NaN;
        else
            amplis_peak2_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time2(j,1)-(2*n):1:content2Data(i).output.time2(j,1),j));
            amplispuff_peak2_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time2(j,3)-n:1:content2Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content2(i,j) = content2Data(i).output.time2(j,3)/freq - content2Data(i).output.time2(j,2)/freq;
            delay_peak2_content2(i,j) = content2Data(i).output.time2(j,2)/freq - content2Data(i).output.time2(j,1)/freq;
        end
        if isnan(content2Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time3(j,1)-(2*n):1:content2Data(i).output.time3(j,1),j));
            amplispuff_peak3_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time3(j,3)-n:1:content2Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content2(i,j) = NaN;
            delay_peak3_content2(i,j) = NaN;
        else
            amplis_peak3_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time3(j,1)-(2*n):1:content2Data(i).output.time3(j,1),j));
            amplispuff_peak3_content2(i,j) = mean(content2Data(i).output.dff(content2Data(i).output.time3(j,3)-n:1:content2Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content2(i,j) = content2Data(i).output.time3(j,3)/freq - content2Data(i).output.time3(j,2)/freq;
            delay_peak3_content2(i,j) = content2Data(i).output.time3(j,2)/freq - content2Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content2(amplis_peak1_content2 == 0) = NaN;
amplis_peak2_content2(amplis_peak2_content2 == 0) = NaN;
amplis_peak3_content2(amplis_peak3_content2 == 0) = NaN;
amplispuff_peak1_content2(amplispuff_peak1_content2 == 0) = NaN;
amplispuff_peak2_content2(amplispuff_peak2_content2 == 0) = NaN;
amplispuff_peak3_content2(amplispuff_peak3_content2 == 0) = NaN;
timetopeak_peak1_content2(timetopeak_peak1_content2 == 0) = NaN;
timetopeak_peak2_content2(timetopeak_peak2_content2 == 0) = NaN;
timetopeak_peak3_content2(timetopeak_peak3_content2 == 0) = NaN;
delay_peak1_content2(delay_peak1_content2 == 0) = NaN;
delay_peak2_content2(delay_peak2_content2 == 0) = NaN;
delay_peak3_content2(delay_peak3_content2 == 0) = NaN;
amplis_afterpuff1_content2 = amplispuff_peak1_content2 - amplis_peak1_content2;
amplis_afterpuff2_content2 = amplispuff_peak2_content2 - amplis_peak2_content2;
amplis_afterpuff3_content2 = amplispuff_peak3_content2 - amplis_peak3_content2;
amplis_afterallpuff_content2 = [amplis_afterpuff1_content2;amplis_afterpuff2_content2;amplis_afterpuff3_content2];
delay_content2 = [delay_peak1_content2;delay_peak2_content2;delay_peak3_content2];
timetopeak_content2 = [timetopeak_peak1_content2;timetopeak_peak2_content2;timetopeak_peak3_content2];


%%% Data for time decay %%%

%Takes all your content_td cells output and extract the time decay

disp('Select ALL your "content_td" outputs')
[content_td, folder_content_td] = uigetfile('*.*','MultiSelect','on');
nTrials_content_td = size(content_td,2);

for i = 1:nTrials_content_td;
    content_tdData(1,i) = load(fullfile(folder_content_td, content_td{i}));
    for j = 1:size(content_tdData(i).fitExpo.decay,1)
        time_decay1_content_td(i,j) = content_tdData(i).fitExpo.decay(j,1);
        time_decay2_content_td(i,j) = content_tdData(i).fitExpo.decay(j,2);
        time_decay3_content_td(i,j) = content_tdData(i).fitExpo.decay(j,3);
    end
end

time_decay1_content_td(time_decay1_content_td == 0) = NaN;
time_decay2_content_td(time_decay2_content_td == 0) = NaN;
time_decay3_content_td(time_decay3_content_td == 0) = NaN;
time_decay_content_td = [time_decay1_content_td;time_decay2_content_td;time_decay3_content_td];


%Takes all your content2_td cells output and extract the time decay

disp('Select ALL your "content2_td" outputs')
[content2_td, folder_content2_td] = uigetfile('*.*','MultiSelect','on');
nTrials_content2_td = size(content2_td,2);

for i = 1:nTrials_content2_td;
    content2_tdData(1,i) = load(fullfile(folder_content2_td, content2_td{i}));
    for j = 1:size(content2_tdData(i).fitExpo.decay,1)
        time_decay1_content2_td(i,j) = content2_tdData(i).fitExpo.decay(j,1);
        time_decay2_content2_td(i,j) = content2_tdData(i).fitExpo.decay(j,2);
        time_decay3_content2_td(i,j) = content2_tdData(i).fitExpo.decay(j,3);
    end
end

time_decay1_content2_td(time_decay1_content2_td == 0) = NaN;
time_decay2_content2_td(time_decay2_content2_td == 0) = NaN;
time_decay3_content2_td(time_decay3_content2_td == 0) = NaN;
time_decay_content2_td = [time_decay1_content2_td;time_decay2_content2_td;time_decay3_content2_td];



%%%%% Statistics for latency and timetopeak %%%%%

[h,p,ks2stat] = kstest2(delay_content(:),delay_content2(:));
hypothesis_kstest2(1,:) = h;
p_value_kstest2(1,:) = p;
stats_kstest2(:,:,1) = ks2stat;

[h,p,ks2stat] = kstest2(timetopeak_content(:),timetopeak_content2(:));
hypothesis_kstest2(2,:) = h;
p_value_kstest2(2,:) = p;
stats_kstest2(:,:,2) = ks2stat;

output.hypothesis_kstest2=hypothesis_kstest2;
output.p_value_kstest2=p_value_kstest2;
output.stats_kstest2=stats_kstest2;

%%%%% Statistics fro time decay %%%%%

[h,p,ks2stat] = kstest2(time_decay_content_td(:),time_decay_content2_td(:));
hypothesis_kstest2_timedecay(1,:) = h;
p_value_kstest2_timedecay(1,:) = p;
stats_kstest2_timedecay(:,:,1) = ks2stat;

output.hypothesis_kstest2_timedecay=hypothesis_kstest2_timedecay;
output.p_value_kstest2_timedecay=p_value_kstest2_timedecay;
output.stats_kstest2_timedecay=stats_kstest2_timedecay;


%Save the final structure

save(strcat(folder_content,'Stats_latency_timetopeak_timedecay','.mat'),'output');

clear baseline
close all

end