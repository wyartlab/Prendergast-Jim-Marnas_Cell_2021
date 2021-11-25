function output = Analyse_dose_responseV3()

clear 
close all

output=struct('mean_aCSF25',[],'mean_content25',[],'mean_aCSF50',[],'mean_content50',[],'mean_aCSF100',[],'mean_content100',[],'median_aCSF25',[],'median_content25',[],'median_aCSF50',[],'median_content50',[],'median_aCSF100',[],'median_content100',[],'hypothesis_kstest2',[],'p_value_kstest2',[],'stats_kstest2',[]);

freq = 5; %Your frequency in Hertz;
n = 3; %Number of frames to add before and after for your peak amplitude

%%%%% ALL YOUR aCSF DATA (ALL CONCENTRATIONS)%%%%%


disp('Select ALL your "aCSF25" outputs')
[aCSF25, folder_aCSF25] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF25 = size(aCSF25,2);

for i = 1:nTrials_aCSF25;
    aCSF25Data(i,1) = load(fullfile(folder_aCSF25, aCSF25{i}));
    for j = 1:size(aCSF25Data(i).output.dff,2)
        dff_aCSF25{i,j} = aCSF25Data(i).output.dff(:,j);
        if isnan(aCSF25Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time1(j,1)-(2*n):1:aCSF25Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time1(j,3)-n:1:aCSF25Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF25(i,j) = NaN;
            delay_peak1_aCSF25(i,j) = NaN;
        else
            amplis_peak1_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time1(j,1)-(2*n):1:aCSF25Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time1(j,3)-n:1:aCSF25Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF25(i,j) = aCSF25Data(i).output.time1(j,3)/freq - aCSF25Data(i).output.time1(j,2)/freq;
            delay_peak1_aCSF25(i,j) = aCSF25Data(i).output.time1(j,2)/freq - aCSF25Data(i).output.time1(j,1)/freq;
        end
        if isnan(aCSF25Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time2(j,1)-(2*n):1:aCSF25Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time2(j,3)-n:1:aCSF25Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF25(i,j) = NaN;
            delay_peak2_aCSF25(i,j) = NaN;
        else
            amplis_peak2_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time2(j,1)-(2*n):1:aCSF25Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time2(j,3)-n:1:aCSF25Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF25(i,j) = aCSF25Data(i).output.time2(j,3)/freq - aCSF25Data(i).output.time2(j,2)/freq;
            delay_peak2_aCSF25(i,j) = aCSF25Data(i).output.time2(j,2)/freq - aCSF25Data(i).output.time2(j,1)/freq;
        end
        if isnan(aCSF25Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time3(j,1)-(2*n):1:aCSF25Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time3(j,3)-n:1:aCSF25Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF25(i,j) = NaN;
            delay_peak3_aCSF25(i,j) = NaN;
        else
            amplis_peak3_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time3(j,1)-(2*n):1:aCSF25Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF25(i,j) = mean(aCSF25Data(i).output.dff(aCSF25Data(i).output.time3(j,3)-n:1:aCSF25Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF25(i,j) = aCSF25Data(i).output.time3(j,3)/freq - aCSF25Data(i).output.time3(j,2)/freq;
            delay_peak3_aCSF25(i,j) = aCSF25Data(i).output.time3(j,2)/freq - aCSF25Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF25(amplis_peak1_aCSF25 == 0) = NaN;
amplis_peak2_aCSF25(amplis_peak2_aCSF25 == 0) = NaN;
amplis_peak3_aCSF25(amplis_peak3_aCSF25 == 0) = NaN;
amplispuff_peak1_aCSF25(amplispuff_peak1_aCSF25 == 0) = NaN;
amplispuff_peak2_aCSF25(amplispuff_peak2_aCSF25 == 0) = NaN;
amplispuff_peak3_aCSF25(amplispuff_peak3_aCSF25 == 0) = NaN;
timetopeak_peak1_aCSF25(timetopeak_peak1_aCSF25 == 0) = NaN;
timetopeak_peak2_aCSF25(timetopeak_peak2_aCSF25 == 0) = NaN;
timetopeak_peak3_aCSF25(timetopeak_peak3_aCSF25 == 0) = NaN;
delay_peak1_aCSF25(delay_peak1_aCSF25 == 0) = NaN;
delay_peak2_aCSF25(delay_peak2_aCSF25 == 0) = NaN;
delay_peak3_aCSF25(delay_peak3_aCSF25 == 0) = NaN;
amplis_afterpuff1_aCSF25 = amplispuff_peak1_aCSF25 - amplis_peak1_aCSF25;
amplis_afterpuff2_aCSF25 = amplispuff_peak2_aCSF25 - amplis_peak2_aCSF25;
amplis_afterpuff3_aCSF25 = amplispuff_peak3_aCSF25 - amplis_peak3_aCSF25;
amplis_afterallpuff_aCSF25 = [amplis_afterpuff1_aCSF25;amplis_afterpuff2_aCSF25;amplis_afterpuff3_aCSF25];
delay_aCSF25 = [delay_peak1_aCSF25;delay_peak2_aCSF25;delay_peak3_aCSF25];
timetopeak_aCSF25 = [timetopeak_peak1_aCSF25;timetopeak_peak2_aCSF25;timetopeak_peak3_aCSF25];


disp('Select ALL your "aCSF50" outputs')
[aCSF50, folder_aCSF50] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF50 = size(aCSF50,2);

for i = 1:nTrials_aCSF50;
    aCSF50Data(i,1) = load(fullfile(folder_aCSF50, aCSF50{i}));
    for j = 1:size(aCSF50Data(i).output.dff,2)
        dff_aCSF50{i,j} = aCSF50Data(i).output.dff(:,j);
        if isnan(aCSF50Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time1(j,1)-(2*n):1:aCSF50Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time1(j,3)-n:1:aCSF50Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF50(i,j) = NaN;
            delay_peak1_aCSF50(i,j) = NaN;
        else
            amplis_peak1_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time1(j,1)-(2*n):1:aCSF50Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time1(j,3)-n:1:aCSF50Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF50(i,j) = aCSF50Data(i).output.time1(j,3)/freq - aCSF50Data(i).output.time1(j,2)/freq;
            delay_peak1_aCSF50(i,j) = aCSF50Data(i).output.time1(j,2)/freq - aCSF50Data(i).output.time1(j,1)/freq;
        end
        if isnan(aCSF50Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time2(j,1)-(2*n):1:aCSF50Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time2(j,3)-n:1:aCSF50Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF50(i,j) = NaN;
            delay_peak2_aCSF50(i,j) = NaN;
        else
            amplis_peak2_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time2(j,1)-(2*n):1:aCSF50Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time2(j,3)-n:1:aCSF50Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF50(i,j) = aCSF50Data(i).output.time2(j,3)/freq - aCSF50Data(i).output.time2(j,2)/freq;
            delay_peak2_aCSF50(i,j) = aCSF50Data(i).output.time2(j,2)/freq - aCSF50Data(i).output.time2(j,1)/freq;
        end
        if isnan(aCSF50Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time3(j,1)-(2*n):1:aCSF50Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time3(j,3)-n:1:aCSF50Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF50(i,j) = NaN;
            delay_peak3_aCSF50(i,j) = NaN;
        else
            amplis_peak3_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time3(j,1)-(2*n):1:aCSF50Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF50(i,j) = mean(aCSF50Data(i).output.dff(aCSF50Data(i).output.time3(j,3)-n:1:aCSF50Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF50(i,j) = aCSF50Data(i).output.time3(j,3)/freq - aCSF50Data(i).output.time3(j,2)/freq;
            delay_peak3_aCSF50(i,j) = aCSF50Data(i).output.time3(j,2)/freq - aCSF50Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF50(amplis_peak1_aCSF50 == 0) = NaN;
amplis_peak2_aCSF50(amplis_peak2_aCSF50 == 0) = NaN;
amplis_peak3_aCSF50(amplis_peak3_aCSF50 == 0) = NaN;
amplispuff_peak1_aCSF50(amplispuff_peak1_aCSF50 == 0) = NaN;
amplispuff_peak2_aCSF50(amplispuff_peak2_aCSF50 == 0) = NaN;
amplispuff_peak3_aCSF50(amplispuff_peak3_aCSF50 == 0) = NaN;
timetopeak_peak1_aCSF50(timetopeak_peak1_aCSF50 == 0) = NaN;
timetopeak_peak2_aCSF50(timetopeak_peak2_aCSF50 == 0) = NaN;
timetopeak_peak3_aCSF50(timetopeak_peak3_aCSF50 == 0) = NaN;
delay_peak1_aCSF50(delay_peak1_aCSF50 == 0) = NaN;
delay_peak2_aCSF50(delay_peak2_aCSF50 == 0) = NaN;
delay_peak3_aCSF50(delay_peak3_aCSF50 == 0) = NaN;
amplis_afterpuff1_aCSF50 = amplispuff_peak1_aCSF50 - amplis_peak1_aCSF50;
amplis_afterpuff2_aCSF50 = amplispuff_peak2_aCSF50 - amplis_peak2_aCSF50;
amplis_afterpuff3_aCSF50 = amplispuff_peak3_aCSF50 - amplis_peak3_aCSF50;
amplis_afterallpuff_aCSF50 = [amplis_afterpuff1_aCSF50;amplis_afterpuff2_aCSF50;amplis_afterpuff3_aCSF50];
delay_aCSF50 = [delay_peak1_aCSF50;delay_peak2_aCSF50;delay_peak3_aCSF50];
timetopeak_aCSF50 = [timetopeak_peak1_aCSF50;timetopeak_peak2_aCSF50;timetopeak_peak3_aCSF50];

disp('Select ALL your "aCSF100" outputs')
[aCSF100, folder_aCSF100] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF100 = size(aCSF100,2);

for i = 1:nTrials_aCSF100;
    aCSF100Data(i,1) = load(fullfile(folder_aCSF100, aCSF100{i}));
    for j = 1:size(aCSF100Data(i).output.dff,2)
        dff_aCSF100{i,j} = aCSF100Data(i).output.dff(:,j);
        if isnan(aCSF100Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time1(j,1)-(2*n):1:aCSF100Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time1(j,3)-n:1:aCSF100Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF100(i,j) = NaN;
            delay_peak1_aCSF100(i,j) = NaN;
        else
            amplis_peak1_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time1(j,1)-(2*n):1:aCSF100Data(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time1(j,3)-n:1:aCSF100Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF100(i,j) = aCSF100Data(i).output.time1(j,3)/freq - aCSF100Data(i).output.time1(j,2)/freq;
            delay_peak1_aCSF100(i,j) = aCSF100Data(i).output.time1(j,2)/freq - aCSF100Data(i).output.time1(j,1)/freq;
        end
        if isnan(aCSF100Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time2(j,1)-(2*n):1:aCSF100Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time2(j,3)-n:1:aCSF100Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF100(i,j) = NaN;
            delay_peak2_aCSF100(i,j) = NaN;
        else
            amplis_peak2_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time2(j,1)-(2*n):1:aCSF100Data(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time2(j,3)-n:1:aCSF100Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF100(i,j) = aCSF100Data(i).output.time2(j,3)/freq - aCSF100Data(i).output.time2(j,2)/freq;
            delay_peak2_aCSF100(i,j) = aCSF100Data(i).output.time2(j,2)/freq - aCSF100Data(i).output.time2(j,1)/freq;
        end
        if isnan(aCSF100Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time3(j,1)-(2*n):1:aCSF100Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time3(j,3)-n:1:aCSF100Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF100(i,j) = NaN;
            delay_peak3_aCSF100(i,j) = NaN;
        else
            amplis_peak3_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time3(j,1)-(2*n):1:aCSF100Data(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF100(i,j) = mean(aCSF100Data(i).output.dff(aCSF100Data(i).output.time3(j,3)-n:1:aCSF100Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF100(i,j) = aCSF100Data(i).output.time3(j,3)/freq - aCSF100Data(i).output.time3(j,2)/freq;
            delay_peak3_aCSF100(i,j) = aCSF100Data(i).output.time3(j,2)/freq - aCSF100Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF100(amplis_peak1_aCSF100 == 0) = NaN;
amplis_peak2_aCSF100(amplis_peak2_aCSF100 == 0) = NaN;
amplis_peak3_aCSF100(amplis_peak3_aCSF100 == 0) = NaN;
amplispuff_peak1_aCSF100(amplispuff_peak1_aCSF100 == 0) = NaN;
amplispuff_peak2_aCSF100(amplispuff_peak2_aCSF100 == 0) = NaN;
amplispuff_peak3_aCSF100(amplispuff_peak3_aCSF100 == 0) = NaN;
timetopeak_peak1_aCSF100(timetopeak_peak1_aCSF100 == 0) = NaN;
timetopeak_peak2_aCSF100(timetopeak_peak2_aCSF100 == 0) = NaN;
timetopeak_peak3_aCSF100(timetopeak_peak3_aCSF100 == 0) = NaN;
delay_peak1_aCSF100(delay_peak1_aCSF100 == 0) = NaN;
delay_peak2_aCSF100(delay_peak2_aCSF100 == 0) = NaN;
delay_peak3_aCSF100(delay_peak3_aCSF100 == 0) = NaN;
amplis_afterpuff1_aCSF100 = amplispuff_peak1_aCSF100 - amplis_peak1_aCSF100;
amplis_afterpuff2_aCSF100 = amplispuff_peak2_aCSF100 - amplis_peak2_aCSF100;
amplis_afterpuff3_aCSF100 = amplispuff_peak3_aCSF100 - amplis_peak3_aCSF100;
amplis_afterallpuff_aCSF100 = [amplis_afterpuff1_aCSF100;amplis_afterpuff2_aCSF100;amplis_afterpuff3_aCSF100];
delay_aCSF100 = [delay_peak1_aCSF100;delay_peak2_aCSF100;delay_peak3_aCSF100];
timetopeak_aCSF100 = [timetopeak_peak1_aCSF100;timetopeak_peak2_aCSF100;timetopeak_peak3_aCSF100];


%%%%% ALL YOUR CONTENT DATA (ALL CONCENTRATIONS)%%%%%


disp('Select ALL your "content25" outputs')
[content25, folder_content25] = uigetfile('*.*','MultiSelect','on');
nTrials_content25 = size(content25,2);

for i = 1:nTrials_content25;
    content25Data(i,1) = load(fullfile(folder_content25, content25{i}));
    for j = 1:size(content25Data(i).output.dff,2)
        dff_content25{i,j} = content25Data(i).output.dff(:,j);
        if isnan(content25Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time1(j,1)-(2*n):1:content25Data(i).output.time1(j,1),j));
            amplispuff_peak1_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time1(j,3)-n:1:content25Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content25(i,j) = NaN;
            delay_peak1_content25(i,j) = NaN;
        else
            amplis_peak1_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time1(j,1)-(2*n):1:content25Data(i).output.time1(j,1),j));
            amplispuff_peak1_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time1(j,3)-n:1:content25Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content25(i,j) = content25Data(i).output.time1(j,3)/freq - content25Data(i).output.time1(j,2)/freq;
            delay_peak1_content25(i,j) = content25Data(i).output.time1(j,2)/freq - content25Data(i).output.time1(j,1)/freq;
        end
        if isnan(content25Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time2(j,1)-(2*n):1:content25Data(i).output.time2(j,1),j));
            amplispuff_peak2_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time2(j,3)-n:1:content25Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content25(i,j) = NaN;
            delay_peak2_content25(i,j) = NaN;
        else
            amplis_peak2_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time2(j,1)-(2*n):1:content25Data(i).output.time2(j,1),j));
            amplispuff_peak2_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time2(j,3)-n:1:content25Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content25(i,j) = content25Data(i).output.time2(j,3)/freq - content25Data(i).output.time2(j,2)/freq;
            delay_peak2_content25(i,j) = content25Data(i).output.time2(j,2)/freq - content25Data(i).output.time2(j,1)/freq;
        end
        if isnan(content25Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time3(j,1)-(2*n):1:content25Data(i).output.time3(j,1),j));
            amplispuff_peak3_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time3(j,3)-n:1:content25Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content25(i,j) = NaN;
            delay_peak3_content25(i,j) = NaN;
        else
            amplis_peak3_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time3(j,1)-(2*n):1:content25Data(i).output.time3(j,1),j));
            amplispuff_peak3_content25(i,j) = mean(content25Data(i).output.dff(content25Data(i).output.time3(j,3)-n:1:content25Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content25(i,j) = content25Data(i).output.time3(j,3)/freq - content25Data(i).output.time3(j,2)/freq;
            delay_peak3_content25(i,j) = content25Data(i).output.time3(j,2)/freq - content25Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content25(amplis_peak1_content25 == 0) = NaN;
amplis_peak2_content25(amplis_peak2_content25 == 0) = NaN;
amplis_peak3_content25(amplis_peak3_content25 == 0) = NaN;
amplispuff_peak1_content25(amplispuff_peak1_content25 == 0) = NaN;
amplispuff_peak2_content25(amplispuff_peak2_content25 == 0) = NaN;
amplispuff_peak3_content25(amplispuff_peak3_content25 == 0) = NaN;
timetopeak_peak1_content25(timetopeak_peak1_content25 == 0) = NaN;
timetopeak_peak2_content25(timetopeak_peak2_content25 == 0) = NaN;
timetopeak_peak3_content25(timetopeak_peak3_content25 == 0) = NaN;
delay_peak1_content25(delay_peak1_content25 == 0) = NaN;
delay_peak2_content25(delay_peak2_content25 == 0) = NaN;
delay_peak3_content25(delay_peak3_content25 == 0) = NaN;
amplis_afterpuff1_content25 = amplispuff_peak1_content25 - amplis_peak1_content25;
amplis_afterpuff2_content25 = amplispuff_peak2_content25 - amplis_peak2_content25;
amplis_afterpuff3_content25 = amplispuff_peak3_content25 - amplis_peak3_content25;
amplis_afterallpuff_content25 = [amplis_afterpuff1_content25;amplis_afterpuff2_content25;amplis_afterpuff3_content25];
delay_content25 = [delay_peak1_content25;delay_peak2_content25;delay_peak3_content25];
timetopeak_content25 = [timetopeak_peak1_content25;timetopeak_peak2_content25;timetopeak_peak3_content25];


disp('Select ALL your "content50" outputs')
[content50, folder_content50] = uigetfile('*.*','MultiSelect','on');
nTrials_content50 = size(content50,2);

for i = 1:nTrials_content50;
    content50Data(i,1) = load(fullfile(folder_content50, content50{i}));
    for j = 1:size(content50Data(i).output.dff,2)
        dff_content50{i,j} = content50Data(i).output.dff(:,j);
        if isnan(content50Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time1(j,1)-(2*n):1:content50Data(i).output.time1(j,1),j));
            amplispuff_peak1_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time1(j,3)-n:1:content50Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content50(i,j) = NaN;
            delay_peak1_content50(i,j) = NaN;
        else
            amplis_peak1_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time1(j,1)-(2*n):1:content50Data(i).output.time1(j,1),j));
            amplispuff_peak1_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time1(j,3)-n:1:content50Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content50(i,j) = content50Data(i).output.time1(j,3)/freq - content50Data(i).output.time1(j,2)/freq;
            delay_peak1_content50(i,j) = content50Data(i).output.time1(j,2)/freq - content50Data(i).output.time1(j,1)/freq;
        end
        if isnan(content50Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time2(j,1)-(2*n):1:content50Data(i).output.time2(j,1),j));
            amplispuff_peak2_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time2(j,3)-n:1:content50Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content50(i,j) = NaN;
            delay_peak2_content50(i,j) = NaN;
        else
            amplis_peak2_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time2(j,1)-(2*n):1:content50Data(i).output.time2(j,1),j));
            amplispuff_peak2_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time2(j,3)-n:1:content50Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content50(i,j) = content50Data(i).output.time2(j,3)/freq - content50Data(i).output.time2(j,2)/freq;
            delay_peak2_content50(i,j) = content50Data(i).output.time2(j,2)/freq - content50Data(i).output.time2(j,1)/freq;
        end
        if isnan(content50Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time3(j,1)-(2*n):1:content50Data(i).output.time3(j,1),j));
            amplispuff_peak3_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time3(j,3)-n:1:content50Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content50(i,j) = NaN;
            delay_peak3_content50(i,j) = NaN;
        else
            amplis_peak3_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time3(j,1)-(2*n):1:content50Data(i).output.time3(j,1),j));
            amplispuff_peak3_content50(i,j) = mean(content50Data(i).output.dff(content50Data(i).output.time3(j,3)-n:1:content50Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content50(i,j) = content50Data(i).output.time3(j,3)/freq - content50Data(i).output.time3(j,2)/freq;
            delay_peak3_content50(i,j) = content50Data(i).output.time3(j,2)/freq - content50Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content50(amplis_peak1_content50 == 0) = NaN;
amplis_peak2_content50(amplis_peak2_content50 == 0) = NaN;
amplis_peak3_content50(amplis_peak3_content50 == 0) = NaN;
amplispuff_peak1_content50(amplispuff_peak1_content50 == 0) = NaN;
amplispuff_peak2_content50(amplispuff_peak2_content50 == 0) = NaN;
amplispuff_peak3_content50(amplispuff_peak3_content50 == 0) = NaN;
timetopeak_peak1_content50(timetopeak_peak1_content50 == 0) = NaN;
timetopeak_peak2_content50(timetopeak_peak2_content50 == 0) = NaN;
timetopeak_peak3_content50(timetopeak_peak3_content50 == 0) = NaN;
delay_peak1_content50(delay_peak1_content50 == 0) = NaN;
delay_peak2_content50(delay_peak2_content50 == 0) = NaN;
delay_peak3_content50(delay_peak3_content50 == 0) = NaN;
amplis_afterpuff1_content50 = amplispuff_peak1_content50 - amplis_peak1_content50;
amplis_afterpuff2_content50 = amplispuff_peak2_content50 - amplis_peak2_content50;
amplis_afterpuff3_content50 = amplispuff_peak3_content50 - amplis_peak3_content50;
amplis_afterallpuff_content50 = [amplis_afterpuff1_content50;amplis_afterpuff2_content50;amplis_afterpuff3_content50];
delay_content50 = [delay_peak1_content50;delay_peak2_content50;delay_peak3_content50];
timetopeak_content50 = [timetopeak_peak1_content50;timetopeak_peak2_content50;timetopeak_peak3_content50];


disp('Select ALL your "content100" outputs')
[content100, folder_content100] = uigetfile('*.*','MultiSelect','on');
nTrials_content100 = size(content100,2);

for i = 1:nTrials_content100;
    content100Data(i,1) = load(fullfile(folder_content100, content100{i}));
    for j = 1:size(content100Data(i).output.dff,2)
        dff_content100{i,j} = content100Data(i).output.dff(:,j);
        if isnan(content100Data(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time1(j,1)-(2*n):1:content100Data(i).output.time1(j,1),j));
            amplispuff_peak1_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time1(j,3)-n:1:content100Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content100(i,j) = NaN;
            delay_peak1_content100(i,j) = NaN;
        else
            amplis_peak1_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time1(j,1)-(2*n):1:content100Data(i).output.time1(j,1),j));
            amplispuff_peak1_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time1(j,3)-n:1:content100Data(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content100(i,j) = content100Data(i).output.time1(j,3)/freq - content100Data(i).output.time1(j,2)/freq;
            delay_peak1_content100(i,j) = content100Data(i).output.time1(j,2)/freq - content100Data(i).output.time1(j,1)/freq;
        end
        if isnan(content100Data(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time2(j,1)-(2*n):1:content100Data(i).output.time2(j,1),j));
            amplispuff_peak2_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time2(j,3)-n:1:content100Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content100(i,j) = NaN;
            delay_peak2_content100(i,j) = NaN;
        else
            amplis_peak2_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time2(j,1)-(2*n):1:content100Data(i).output.time2(j,1),j));
            amplispuff_peak2_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time2(j,3)-n:1:content100Data(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content100(i,j) = content100Data(i).output.time2(j,3)/freq - content100Data(i).output.time2(j,2)/freq;
            delay_peak2_content100(i,j) = content100Data(i).output.time2(j,2)/freq - content100Data(i).output.time2(j,1)/freq;
        end
        if isnan(content100Data(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time3(j,1)-(2*n):1:content100Data(i).output.time3(j,1),j));
            amplispuff_peak3_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time3(j,3)-n:1:content100Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content100(i,j) = NaN;
            delay_peak3_content100(i,j) = NaN;
        else
            amplis_peak3_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time3(j,1)-(2*n):1:content100Data(i).output.time3(j,1),j));
            amplispuff_peak3_content100(i,j) = mean(content100Data(i).output.dff(content100Data(i).output.time3(j,3)-n:1:content100Data(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content100(i,j) = content100Data(i).output.time3(j,3)/freq - content100Data(i).output.time3(j,2)/freq;
            delay_peak3_content100(i,j) = content100Data(i).output.time3(j,2)/freq - content100Data(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content100(amplis_peak1_content100 == 0) = NaN;
amplis_peak2_content100(amplis_peak2_content100 == 0) = NaN;
amplis_peak3_content100(amplis_peak3_content100 == 0) = NaN;
amplispuff_peak1_content100(amplispuff_peak1_content100 == 0) = NaN;
amplispuff_peak2_content100(amplispuff_peak2_content100 == 0) = NaN;
amplispuff_peak3_content100(amplispuff_peak3_content100 == 0) = NaN;
timetopeak_peak1_content100(timetopeak_peak1_content100 == 0) = NaN;
timetopeak_peak2_content100(timetopeak_peak2_content100 == 0) = NaN;
timetopeak_peak3_content100(timetopeak_peak3_content100 == 0) = NaN;
delay_peak1_content100(delay_peak1_content100 == 0) = NaN;
delay_peak2_content100(delay_peak2_content100 == 0) = NaN;
delay_peak3_content100(delay_peak3_content100 == 0) = NaN;
amplis_afterpuff1_content100 = amplispuff_peak1_content100 - amplis_peak1_content100;
amplis_afterpuff2_content100 = amplispuff_peak2_content100 - amplis_peak2_content100;
amplis_afterpuff3_content100 = amplispuff_peak3_content100 - amplis_peak3_content100;
amplis_afterallpuff_content100 = [amplis_afterpuff1_content100;amplis_afterpuff2_content100;amplis_afterpuff3_content100];
delay_content100 = [delay_peak1_content100;delay_peak2_content100;delay_peak3_content100];
timetopeak_content100 = [timetopeak_peak1_content100;timetopeak_peak2_content100;timetopeak_peak3_content100];



%Figure of the dose dependent responses

figure(1);
x_amplis_afterallpuff_aCSF25(1:1:size(amplis_afterallpuff_aCSF25,1),1)=1;
x_amplis_afterallpuff_content25(1:1:size(amplis_afterallpuff_content25,1),1)=2;
x_amplis_afterallpuff_aCSF50(1:1:size(amplis_afterallpuff_aCSF50,1),1)=3;
x_amplis_afterallpuff_content50(1:1:size(amplis_afterallpuff_content50,1),1)=4;
x_amplis_afterallpuff_aCSF100(1:1:size(amplis_afterallpuff_aCSF100,1),1)=5;
x_amplis_afterallpuff_content100(1:1:size(amplis_afterallpuff_content100,1),1)=6;
sz = 75;
for i = 1:size(amplis_afterallpuff_aCSF25,2)
    (scatter(x_amplis_afterallpuff_aCSF25,amplis_afterallpuff_aCSF25(:,i),sz,'k','filled','square','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_content25,2)
    (scatter(x_amplis_afterallpuff_content25,amplis_afterallpuff_content25(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_aCSF50,2)
    (scatter(x_amplis_afterallpuff_aCSF50,amplis_afterallpuff_aCSF50(:,i),sz,'k','filled','square','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_content50,2)
    (scatter(x_amplis_afterallpuff_content50,amplis_afterallpuff_content50(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_aCSF100,2)
    (scatter(x_amplis_afterallpuff_aCSF100,amplis_afterallpuff_aCSF100(:,i),sz,'k','filled','square','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_content100,2)
    (scatter(x_amplis_afterallpuff_content100,amplis_afterallpuff_content100(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
boxplot([amplis_afterallpuff_aCSF25(:); amplis_afterallpuff_content25(:); amplis_afterallpuff_aCSF50(:); amplis_afterallpuff_content50(:); amplis_afterallpuff_aCSF100(:); amplis_afterallpuff_content100(:)],[ones(size(amplis_afterallpuff_aCSF25(:)));2*ones(size(amplis_afterallpuff_content25(:)));3*ones(size(amplis_afterallpuff_aCSF50(:)));4*ones(size(amplis_afterallpuff_content50(:)));5*ones(size(amplis_afterallpuff_aCSF100(:)));6*ones(size(amplis_afterallpuff_content100(:)))]);
xlim([0.5 6.5]);
xticks([1 3 5]);
title('Response to gradient of concentrations','FontSize',18);
ylim([-25 300]);
yticks(0:50:300);
set(gca, 'xticklabel', {'DMDS 25mM', 'DMDS 50mM', 'DMDS 100mM'}); axis square;
ylabel('%DF/F');
hold on
mean_aCSF25 = mean(amplis_afterallpuff_aCSF25(:),'omitnan');
mean_content25 = mean(amplis_afterallpuff_content25(:),'omitnan');
mean_aCSF50 = mean(amplis_afterallpuff_aCSF50(:),'omitnan');
mean_content50 = mean(amplis_afterallpuff_content50(:),'omitnan');
mean_aCSF100 = mean(amplis_afterallpuff_aCSF100(:),'omitnan');
mean_content100 = mean(amplis_afterallpuff_content100(:),'omitnan');
median_aCSF25 = median(amplis_afterallpuff_aCSF25(:),'omitnan');
median_content25 = median(amplis_afterallpuff_content25(:),'omitnan');
median_aCSF50 = median(amplis_afterallpuff_aCSF50(:),'omitnan');
median_content50 = median(amplis_afterallpuff_content50(:),'omitnan');
median_aCSF100 = median(amplis_afterallpuff_aCSF100(:),'omitnan');
median_content100 = median(amplis_afterallpuff_content100(:),'omitnan');
hold off;
vccd = strcat(folder_content100, 'Response to gradient of concentrations');
saveas(gcf,vccd,'fig');

output.mean_aCSF25=mean_aCSF25;
output.mean_content25=mean_content25;
output.mean_aCSF50=mean_aCSF50;
output.mean_content50=mean_content50;
output.mean_aCSF100=mean_aCSF100;
output.mean_content100=mean_content100;
output.median_aCSF25=median_aCSF25;
output.median_content25=median_content25;
output.median_aCSF50=median_aCSF50;
output.median_content50=median_content50;
output.median_aCSF100=median_aCSF100;
output.median_content100=median_content100;


%%%%% Statistics %%%%%

[h,p,ks2stat] = kstest2(amplis_afterallpuff_aCSF25(:),amplis_afterallpuff_content25(:));
hypothesis_kstest2(1,:) = h;
p_value_kstest2(1,:) = p;
stats_kstest2(:,:,1) = ks2stat;

[h,p,ks2stat] = kstest2(amplis_afterallpuff_aCSF50(:),amplis_afterallpuff_content50(:));
hypothesis_kstest2(2,:) = h;
p_value_kstest2(2,:) = p;
stats_kstest2(:,:,2) = ks2stat;

[h,p,ks2stat] = kstest2(amplis_afterallpuff_aCSF100(:),amplis_afterallpuff_content100(:));
hypothesis_kstest2(3,:) = h;
p_value_kstest2(3,:) = p;
stats_kstest2(:,:,3) = ks2stat;

output.hypothesis_kstest2=hypothesis_kstest2;
output.p_value_kstest2=p_value_kstest2;
output.stats_kstest2=stats_kstest2;

%%%% Creation of a matrix for exporting in xlsx for ANOVA analysis with R

TN = isnan(amplis_afterallpuff_aCSF25);
amplis_afterallpuff_aCSF25(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_aCSF25 = amplis_afterallpuff_aCSF25';
else
end
TN = isnan(amplis_afterallpuff_aCSF50);
amplis_afterallpuff_aCSF50(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_aCSF50 = amplis_afterallpuff_aCSF50';
else
end
TN = isnan(amplis_afterallpuff_aCSF100);
amplis_afterallpuff_aCSF100(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_aCSF100 = amplis_afterallpuff_aCSF100';
else
end
amplis_aCSF = [amplis_afterallpuff_aCSF25;amplis_afterallpuff_aCSF50;amplis_afterallpuff_aCSF100];

TN = isnan(amplis_afterallpuff_content25);
amplis_afterallpuff_content25(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_content25 = amplis_afterallpuff_content25';
else
end
TN = isnan(amplis_afterallpuff_content50);
amplis_afterallpuff_content50(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_content50 = amplis_afterallpuff_content50';
else
end
TN = isnan(amplis_afterallpuff_content100);
amplis_afterallpuff_content100(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_content100 = amplis_afterallpuff_content100';
else
end
amplis_content = [amplis_afterallpuff_content25;amplis_afterallpuff_content50;amplis_afterallpuff_content100];

amplis = [amplis_aCSF;amplis_content];

conc_25(1:length(amplis_afterallpuff_content25),1) = 25;
conc_50(1:length(amplis_afterallpuff_content50),1) = 50;
conc_100(1:length(amplis_afterallpuff_content100),1) = 100;
concentration = [conc_25;conc_50;conc_100;conc_25;conc_50;conc_100];

stim_aCSF(1:length(amplis_aCSF),1) = "aCSF";
stim_content(1:length(amplis_content),1) = "content";
stim_nature = [stim_aCSF;stim_content];

all_amplis = [stim_nature,concentration,amplis];
var_names = ["stim_nature","concentration","amplis"];
all_amplis = [var_names;all_amplis];

% The created matrix needed to be opened to add a sheet name + replace dot
% by commas for the values of amplitude 

writematrix(all_amplis,'amplis.xlsx');

%Save the final structure

save(strcat(folder_content100,'Gradient','.mat'),'output');

clear baseline
close all

end
