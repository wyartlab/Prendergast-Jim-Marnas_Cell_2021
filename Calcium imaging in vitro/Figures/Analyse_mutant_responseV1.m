function output = Analyse_mutant_responseV1()

clear 
close all

output=struct('mean_aCSF_WT',[],'mean_content_WT',[],'mean_aCSF_homo',[],'mean_content_homo','median_aCSF_WT',[],'median_content_WT',[],'median_aCSF_homo',[],'median_content_homo',[],'hypothesis_kstest2',[],'p_value_kstest2',[],'stats_kstest2',[]);

freq = 5; %Your frequency in Hertz;
n = 3; %Number of frames to add before and after for your peak amplitude

%%%%% ALL YOUR aCSF DATA (ALL CONCENTRATIONS)%%%%%


disp('Select ALL your "aCSF_WT" outputs')
[aCSF_WT, folder_aCSF_WT] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF_WT = size(aCSF_WT,2);

for i = 1:nTrials_aCSF_WT;
    aCSF_WTData(i,1) = load(fullfile(folder_aCSF_WT, aCSF_WT{i}));
    for j = 1:size(aCSF_WTData(i).output.dff,2)
        dff_aCSF_WT{i,j} = aCSF_WTData(i).output.dff(:,j);
        if isnan(aCSF_WTData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time1(j,1)-(2*n):1:aCSF_WTData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time1(j,3)-n:1:aCSF_WTData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF_WT(i,j) = NaN;
            delay_peak1_aCSF_WT(i,j) = NaN;
        else
            amplis_peak1_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time1(j,1)-(2*n):1:aCSF_WTData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time1(j,3)-n:1:aCSF_WTData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF_WT(i,j) = aCSF_WTData(i).output.time1(j,3)/freq - aCSF_WTData(i).output.time1(j,2)/freq;
            delay_peak1_aCSF_WT(i,j) = aCSF_WTData(i).output.time1(j,2)/freq - aCSF_WTData(i).output.time1(j,1)/freq;
        end
        if isnan(aCSF_WTData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time2(j,1)-(2*n):1:aCSF_WTData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time2(j,3)-n:1:aCSF_WTData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF_WT(i,j) = NaN;
            delay_peak2_aCSF_WT(i,j) = NaN;
        else
            amplis_peak2_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time2(j,1)-(2*n):1:aCSF_WTData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time2(j,3)-n:1:aCSF_WTData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF_WT(i,j) = aCSF_WTData(i).output.time2(j,3)/freq - aCSF_WTData(i).output.time2(j,2)/freq;
            delay_peak2_aCSF_WT(i,j) = aCSF_WTData(i).output.time2(j,2)/freq - aCSF_WTData(i).output.time2(j,1)/freq;
        end
        if isnan(aCSF_WTData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time3(j,1)-(2*n):1:aCSF_WTData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time3(j,3)-n:1:aCSF_WTData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF_WT(i,j) = NaN;
            delay_peak3_aCSF_WT(i,j) = NaN;
        else
            amplis_peak3_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time3(j,1)-(2*n):1:aCSF_WTData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF_WT(i,j) = mean(aCSF_WTData(i).output.dff(aCSF_WTData(i).output.time3(j,3)-n:1:aCSF_WTData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF_WT(i,j) = aCSF_WTData(i).output.time3(j,3)/freq - aCSF_WTData(i).output.time3(j,2)/freq;
            delay_peak3_aCSF_WT(i,j) = aCSF_WTData(i).output.time3(j,2)/freq - aCSF_WTData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF_WT(amplis_peak1_aCSF_WT == 0) = NaN;
amplis_peak2_aCSF_WT(amplis_peak2_aCSF_WT == 0) = NaN;
amplis_peak3_aCSF_WT(amplis_peak3_aCSF_WT == 0) = NaN;
amplispuff_peak1_aCSF_WT(amplispuff_peak1_aCSF_WT == 0) = NaN;
amplispuff_peak2_aCSF_WT(amplispuff_peak2_aCSF_WT == 0) = NaN;
amplispuff_peak3_aCSF_WT(amplispuff_peak3_aCSF_WT == 0) = NaN;
timetopeak_peak1_aCSF_WT(timetopeak_peak1_aCSF_WT == 0) = NaN;
timetopeak_peak2_aCSF_WT(timetopeak_peak2_aCSF_WT == 0) = NaN;
timetopeak_peak3_aCSF_WT(timetopeak_peak3_aCSF_WT == 0) = NaN;
delay_peak1_aCSF_WT(delay_peak1_aCSF_WT == 0) = NaN;
delay_peak2_aCSF_WT(delay_peak2_aCSF_WT == 0) = NaN;
delay_peak3_aCSF_WT(delay_peak3_aCSF_WT == 0) = NaN;
amplis_afterpuff1_aCSF_WT = amplispuff_peak1_aCSF_WT - amplis_peak1_aCSF_WT;
amplis_afterpuff2_aCSF_WT = amplispuff_peak2_aCSF_WT - amplis_peak2_aCSF_WT;
amplis_afterpuff3_aCSF_WT = amplispuff_peak3_aCSF_WT - amplis_peak3_aCSF_WT;
amplis_afterallpuff_aCSF_WT = [amplis_afterpuff1_aCSF_WT;amplis_afterpuff2_aCSF_WT;amplis_afterpuff3_aCSF_WT];
delay_aCSF_WT = [delay_peak1_aCSF_WT;delay_peak2_aCSF_WT;delay_peak3_aCSF_WT];
timetopeak_aCSF_WT = [timetopeak_peak1_aCSF_WT;timetopeak_peak2_aCSF_WT;timetopeak_peak3_aCSF_WT];


disp('Select ALL your "aCSF_homo" outputs')
[aCSF_homo, folder_aCSF_homo] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF_homo = size(aCSF_homo,2);

for i = 1:nTrials_aCSF_homo;
    aCSF_homoData(i,1) = load(fullfile(folder_aCSF_homo, aCSF_homo{i}));
    for j = 1:size(aCSF_homoData(i).output.dff,2)
        dff_aCSF_homo{i,j} = aCSF_homoData(i).output.dff(:,j);
        if isnan(aCSF_homoData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time1(j,1)-(2*n):1:aCSF_homoData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time1(j,3)-n:1:aCSF_homoData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF_homo(i,j) = NaN;
            delay_peak1_aCSF_homo(i,j) = NaN;
        else
            amplis_peak1_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time1(j,1)-(2*n):1:aCSF_homoData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time1(j,3)-n:1:aCSF_homoData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF_homo(i,j) = aCSF_homoData(i).output.time1(j,3)/freq - aCSF_homoData(i).output.time1(j,2)/freq;
            delay_peak1_aCSF_homo(i,j) = aCSF_homoData(i).output.time1(j,2)/freq - aCSF_homoData(i).output.time1(j,1)/freq;
        end
        if isnan(aCSF_homoData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time2(j,1)-(2*n):1:aCSF_homoData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time2(j,3)-n:1:aCSF_homoData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF_homo(i,j) = NaN;
            delay_peak2_aCSF_homo(i,j) = NaN;
        else
            amplis_peak2_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time2(j,1)-(2*n):1:aCSF_homoData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time2(j,3)-n:1:aCSF_homoData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF_homo(i,j) = aCSF_homoData(i).output.time2(j,3)/freq - aCSF_homoData(i).output.time2(j,2)/freq;
            delay_peak2_aCSF_homo(i,j) = aCSF_homoData(i).output.time2(j,2)/freq - aCSF_homoData(i).output.time2(j,1)/freq;
        end
        if isnan(aCSF_homoData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time3(j,1)-(2*n):1:aCSF_homoData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time3(j,3)-n:1:aCSF_homoData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF_homo(i,j) = NaN;
            delay_peak3_aCSF_homo(i,j) = NaN;
        else
            amplis_peak3_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time3(j,1)-(2*n):1:aCSF_homoData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF_homo(i,j) = mean(aCSF_homoData(i).output.dff(aCSF_homoData(i).output.time3(j,3)-n:1:aCSF_homoData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF_homo(i,j) = aCSF_homoData(i).output.time3(j,3)/freq - aCSF_homoData(i).output.time3(j,2)/freq;
            delay_peak3_aCSF_homo(i,j) = aCSF_homoData(i).output.time3(j,2)/freq - aCSF_homoData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF_homo(amplis_peak1_aCSF_homo == 0) = NaN;
amplis_peak2_aCSF_homo(amplis_peak2_aCSF_homo == 0) = NaN;
amplis_peak3_aCSF_homo(amplis_peak3_aCSF_homo == 0) = NaN;
amplispuff_peak1_aCSF_homo(amplispuff_peak1_aCSF_homo == 0) = NaN;
amplispuff_peak2_aCSF_homo(amplispuff_peak2_aCSF_homo == 0) = NaN;
amplispuff_peak3_aCSF_homo(amplispuff_peak3_aCSF_homo == 0) = NaN;
timetopeak_peak1_aCSF_homo(timetopeak_peak1_aCSF_homo == 0) = NaN;
timetopeak_peak2_aCSF_homo(timetopeak_peak2_aCSF_homo == 0) = NaN;
timetopeak_peak3_aCSF_homo(timetopeak_peak3_aCSF_homo == 0) = NaN;
delay_peak1_aCSF_homo(delay_peak1_aCSF_homo == 0) = NaN;
delay_peak2_aCSF_homo(delay_peak2_aCSF_homo == 0) = NaN;
delay_peak3_aCSF_homo(delay_peak3_aCSF_homo == 0) = NaN;
amplis_afterpuff1_aCSF_homo = amplispuff_peak1_aCSF_homo - amplis_peak1_aCSF_homo;
amplis_afterpuff2_aCSF_homo = amplispuff_peak2_aCSF_homo - amplis_peak2_aCSF_homo;
amplis_afterpuff3_aCSF_homo = amplispuff_peak3_aCSF_homo - amplis_peak3_aCSF_homo;
amplis_afterallpuff_aCSF_homo = [amplis_afterpuff1_aCSF_homo;amplis_afterpuff2_aCSF_homo;amplis_afterpuff3_aCSF_homo];
delay_aCSF_homo = [delay_peak1_aCSF_homo;delay_peak2_aCSF_homo;delay_peak3_aCSF_homo];
timetopeak_aCSF_homo = [timetopeak_peak1_aCSF_homo;timetopeak_peak2_aCSF_homo;timetopeak_peak3_aCSF_homo];


%%%%% ALL YOUR CONTENT DATA %%%%%


disp('Select ALL your "content_WT" outputs')
[content_WT, folder_content_WT] = uigetfile('*.*','MultiSelect','on');
nTrials_content_WT = size(content_WT,2);

for i = 1:nTrials_content_WT;
    content_WTData(i,1) = load(fullfile(folder_content_WT, content_WT{i}));
    for j = 1:size(content_WTData(i).output.dff,2)
        dff_content_WT{i,j} = content_WTData(i).output.dff(:,j);
        if isnan(content_WTData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time1(j,1)-(2*n):1:content_WTData(i).output.time1(j,1),j));
            amplispuff_peak1_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time1(j,3)-n:1:content_WTData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content_WT(i,j) = NaN;
            delay_peak1_content_WT(i,j) = NaN;
        else
            amplis_peak1_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time1(j,1)-(2*n):1:content_WTData(i).output.time1(j,1),j));
            amplispuff_peak1_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time1(j,3)-n:1:content_WTData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content_WT(i,j) = content_WTData(i).output.time1(j,3)/freq - content_WTData(i).output.time1(j,2)/freq;
            delay_peak1_content_WT(i,j) = content_WTData(i).output.time1(j,2)/freq - content_WTData(i).output.time1(j,1)/freq;
        end
        if isnan(content_WTData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time2(j,1)-(2*n):1:content_WTData(i).output.time2(j,1),j));
            amplispuff_peak2_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time2(j,3)-n:1:content_WTData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content_WT(i,j) = NaN;
            delay_peak2_content_WT(i,j) = NaN;
        else
            amplis_peak2_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time2(j,1)-(2*n):1:content_WTData(i).output.time2(j,1),j));
            amplispuff_peak2_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time2(j,3)-n:1:content_WTData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content_WT(i,j) = content_WTData(i).output.time2(j,3)/freq - content_WTData(i).output.time2(j,2)/freq;
            delay_peak2_content_WT(i,j) = content_WTData(i).output.time2(j,2)/freq - content_WTData(i).output.time2(j,1)/freq;
        end
        if isnan(content_WTData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time3(j,1)-(2*n):1:content_WTData(i).output.time3(j,1),j));
            amplispuff_peak3_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time3(j,3)-n:1:content_WTData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content_WT(i,j) = NaN;
            delay_peak3_content_WT(i,j) = NaN;
        else
            amplis_peak3_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time3(j,1)-(2*n):1:content_WTData(i).output.time3(j,1),j));
            amplispuff_peak3_content_WT(i,j) = mean(content_WTData(i).output.dff(content_WTData(i).output.time3(j,3)-n:1:content_WTData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content_WT(i,j) = content_WTData(i).output.time3(j,3)/freq - content_WTData(i).output.time3(j,2)/freq;
            delay_peak3_content_WT(i,j) = content_WTData(i).output.time3(j,2)/freq - content_WTData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content_WT(amplis_peak1_content_WT == 0) = NaN;
amplis_peak2_content_WT(amplis_peak2_content_WT == 0) = NaN;
amplis_peak3_content_WT(amplis_peak3_content_WT == 0) = NaN;
amplispuff_peak1_content_WT(amplispuff_peak1_content_WT == 0) = NaN;
amplispuff_peak2_content_WT(amplispuff_peak2_content_WT == 0) = NaN;
amplispuff_peak3_content_WT(amplispuff_peak3_content_WT == 0) = NaN;
timetopeak_peak1_content_WT(timetopeak_peak1_content_WT == 0) = NaN;
timetopeak_peak2_content_WT(timetopeak_peak2_content_WT == 0) = NaN;
timetopeak_peak3_content_WT(timetopeak_peak3_content_WT == 0) = NaN;
delay_peak1_content_WT(delay_peak1_content_WT == 0) = NaN;
delay_peak2_content_WT(delay_peak2_content_WT == 0) = NaN;
delay_peak3_content_WT(delay_peak3_content_WT == 0) = NaN;
amplis_afterpuff1_content_WT = amplispuff_peak1_content_WT - amplis_peak1_content_WT;
amplis_afterpuff2_content_WT = amplispuff_peak2_content_WT - amplis_peak2_content_WT;
amplis_afterpuff3_content_WT = amplispuff_peak3_content_WT - amplis_peak3_content_WT;
amplis_afterallpuff_content_WT = [amplis_afterpuff1_content_WT;amplis_afterpuff2_content_WT;amplis_afterpuff3_content_WT];
delay_content_WT = [delay_peak1_content_WT;delay_peak2_content_WT;delay_peak3_content_WT];
timetopeak_content_WT = [timetopeak_peak1_content_WT;timetopeak_peak2_content_WT;timetopeak_peak3_content_WT];


disp('Select ALL your "content_homo" outputs')
[content_homo, folder_content_homo] = uigetfile('*.*','MultiSelect','on');
nTrials_content_homo = size(content_homo,2);

for i = 1:nTrials_content_homo;
    content_homoData(i,1) = load(fullfile(folder_content_homo, content_homo{i}));
    for j = 1:size(content_homoData(i).output.dff,2)
        dff_content_homo{i,j} = content_homoData(i).output.dff(:,j);
        if isnan(content_homoData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time1(j,1)-(2*n):1:content_homoData(i).output.time1(j,1),j));
            amplispuff_peak1_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time1(j,3)-n:1:content_homoData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content_homo(i,j) = NaN;
            delay_peak1_content_homo(i,j) = NaN;
        else
            amplis_peak1_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time1(j,1)-(2*n):1:content_homoData(i).output.time1(j,1),j));
            amplispuff_peak1_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time1(j,3)-n:1:content_homoData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_content_homo(i,j) = content_homoData(i).output.time1(j,3)/freq - content_homoData(i).output.time1(j,2)/freq;
            delay_peak1_content_homo(i,j) = content_homoData(i).output.time1(j,2)/freq - content_homoData(i).output.time1(j,1)/freq;
        end
        if isnan(content_homoData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time2(j,1)-(2*n):1:content_homoData(i).output.time2(j,1),j));
            amplispuff_peak2_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time2(j,3)-n:1:content_homoData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content_homo(i,j) = NaN;
            delay_peak2_content_homo(i,j) = NaN;
        else
            amplis_peak2_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time2(j,1)-(2*n):1:content_homoData(i).output.time2(j,1),j));
            amplispuff_peak2_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time2(j,3)-n:1:content_homoData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_content_homo(i,j) = content_homoData(i).output.time2(j,3)/freq - content_homoData(i).output.time2(j,2)/freq;
            delay_peak2_content_homo(i,j) = content_homoData(i).output.time2(j,2)/freq - content_homoData(i).output.time2(j,1)/freq;
        end
        if isnan(content_homoData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time3(j,1)-(2*n):1:content_homoData(i).output.time3(j,1),j));
            amplispuff_peak3_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time3(j,3)-n:1:content_homoData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content_homo(i,j) = NaN;
            delay_peak3_content_homo(i,j) = NaN;
        else
            amplis_peak3_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time3(j,1)-(2*n):1:content_homoData(i).output.time3(j,1),j));
            amplispuff_peak3_content_homo(i,j) = mean(content_homoData(i).output.dff(content_homoData(i).output.time3(j,3)-n:1:content_homoData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_content_homo(i,j) = content_homoData(i).output.time3(j,3)/freq - content_homoData(i).output.time3(j,2)/freq;
            delay_peak3_content_homo(i,j) = content_homoData(i).output.time3(j,2)/freq - content_homoData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_content_homo(amplis_peak1_content_homo == 0) = NaN;
amplis_peak2_content_homo(amplis_peak2_content_homo == 0) = NaN;
amplis_peak3_content_homo(amplis_peak3_content_homo == 0) = NaN;
amplispuff_peak1_content_homo(amplispuff_peak1_content_homo == 0) = NaN;
amplispuff_peak2_content_homo(amplispuff_peak2_content_homo == 0) = NaN;
amplispuff_peak3_content_homo(amplispuff_peak3_content_homo == 0) = NaN;
timetopeak_peak1_content_homo(timetopeak_peak1_content_homo == 0) = NaN;
timetopeak_peak2_content_homo(timetopeak_peak2_content_homo == 0) = NaN;
timetopeak_peak3_content_homo(timetopeak_peak3_content_homo == 0) = NaN;
delay_peak1_content_homo(delay_peak1_content_homo == 0) = NaN;
delay_peak2_content_homo(delay_peak2_content_homo == 0) = NaN;
delay_peak3_content_homo(delay_peak3_content_homo == 0) = NaN;
amplis_afterpuff1_content_homo = amplispuff_peak1_content_homo - amplis_peak1_content_homo;
amplis_afterpuff2_content_homo = amplispuff_peak2_content_homo - amplis_peak2_content_homo;
amplis_afterpuff3_content_homo = amplispuff_peak3_content_homo - amplis_peak3_content_homo;
amplis_afterallpuff_content_homo = [amplis_afterpuff1_content_homo;amplis_afterpuff2_content_homo;amplis_afterpuff3_content_homo];
delay_content_homo = [delay_peak1_content_homo;delay_peak2_content_homo;delay_peak3_content_homo];
timetopeak_content_homo = [timetopeak_peak1_content_homo;timetopeak_peak2_content_homo;timetopeak_peak3_content_homo];


%Figure of the WT vs mutant responses

figure(1);
x_amplis_afterallpuff_aCSF_WT(1:1:size(amplis_afterallpuff_aCSF_WT,1),1)=1;
x_amplis_afterallpuff_content_WT(1:1:size(amplis_afterallpuff_content_WT,1),1)=2;
x_amplis_afterallpuff_aCSF_homo(1:1:size(amplis_afterallpuff_aCSF_homo,1),1)=3;
x_amplis_afterallpuff_content_homo(1:1:size(amplis_afterallpuff_content_homo,1),1)=4;
sz = 75;
for i = 1:size(amplis_afterallpuff_aCSF_WT,2)
    (scatter(x_amplis_afterallpuff_aCSF_WT,amplis_afterallpuff_aCSF_WT(:,i),sz,'k','filled','square','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_content_WT,2)
    (scatter(x_amplis_afterallpuff_content_WT,amplis_afterallpuff_content_WT(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_aCSF_homo,2)
    (scatter(x_amplis_afterallpuff_aCSF_homo,amplis_afterallpuff_aCSF_homo(:,i),sz,'k','filled','square','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
for i = 1:size(amplis_afterallpuff_content_homo,2)
    (scatter(x_amplis_afterallpuff_content_homo,amplis_afterallpuff_content_homo(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.25));
    hold on
end
hold on
boxplot([amplis_afterallpuff_aCSF_WT(:); amplis_afterallpuff_content_WT(:); amplis_afterallpuff_aCSF_homo(:); amplis_afterallpuff_content_homo(:)],[ones(size(amplis_afterallpuff_aCSF_WT(:)));2*ones(size(amplis_afterallpuff_content_WT(:)));3*ones(size(amplis_afterallpuff_aCSF_homo(:)));4*ones(size(amplis_afterallpuff_content_homo(:)))]);
xlim([0.5 4.5]);
xticks([1 3]);
title('Response to content WT VS homozygote','FontSize',18);
ylim([-25 150]);
yticks(0:50:150);
set(gca, 'xticklabel', {'DMDS _WT', 'DMDS _homo'}); axis square;
ylabel('%DF/F');
hold on
mean_aCSF_WT = mean(amplis_afterallpuff_aCSF_WT(:),'omitnan');
mean_content_WT = mean(amplis_afterallpuff_content_WT(:),'omitnan');
mean_aCSF_homo = mean(amplis_afterallpuff_aCSF_homo(:),'omitnan');
mean_content_homo = mean(amplis_afterallpuff_content_homo(:),'omitnan');
median_aCSF_WT = median(amplis_afterallpuff_aCSF_WT(:),'omitnan');
median_content_WT = median(amplis_afterallpuff_content_WT(:),'omitnan');
median_aCSF_homo = median(amplis_afterallpuff_aCSF_homo(:),'omitnan');
median_content_homo = median(amplis_afterallpuff_content_homo(:),'omitnan');
hold off;
vccd = strcat(folder_content_homo,'Response to content WT VS homozygote');
saveas(gcf,vccd,'fig');

output.mean_aCSF_WT=mean_aCSF_WT;
output.mean_content_WT=mean_content_WT;
output.mean_aCSF_homo=mean_aCSF_homo;
output.mean_content_homo=mean_content_homo;
output.median_aCSF_WT=median_aCSF_WT;
output.median_content_WT=median_content_WT;
output.median_aCSF_homo=median_aCSF_homo;
output.median_content_homo=median_content_homo;


%%%%% Statistics %%%%%

[h,p,ks2stat] = kstest2(amplis_afterallpuff_aCSF_WT(:),amplis_afterallpuff_content_WT(:));
hypothesis_kstest2(1,:) = h;
p_value_kstest2(1,:) = p;
stats_kstest2(:,:,1) = ks2stat;

[h,p,ks2stat] = kstest2(amplis_afterallpuff_aCSF_homo(:),amplis_afterallpuff_content_homo(:));
hypothesis_kstest2(2,:) = h;
p_value_kstest2(2,:) = p;
stats_kstest2(:,:,2) = ks2stat;

output.hypothesis_kstest2=hypothesis_kstest2;
output.p_value_kstest2=p_value_kstest2;
output.stats_kstest2=stats_kstest2;

%%%% Creation of a matrix for exporting in xlsx for ANOVA analysis with R

TN = isnan(amplis_afterallpuff_aCSF_WT);
amplis_afterallpuff_aCSF_WT(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_aCSF_WT = amplis_afterallpuff_aCSF_WT';
else
end
TN = isnan(amplis_afterallpuff_aCSF_homo);
amplis_afterallpuff_aCSF_homo(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_aCSF_homo = amplis_afterallpuff_aCSF_homo';
else
end
amplis_aCSF = [amplis_afterallpuff_aCSF_WT;amplis_afterallpuff_aCSF_homo];

TN = isnan(amplis_afterallpuff_content_WT);
amplis_afterallpuff_content_WT(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_content_WT = amplis_afterallpuff_content_WT';
else
end
TN = isnan(amplis_afterallpuff_content_homo);
amplis_afterallpuff_content_homo(TN) = [];
if any(TN(:) == 1)
    amplis_afterallpuff_content_homo = amplis_afterallpuff_content_homo';
else
end
amplis_content = [amplis_afterallpuff_content_WT;amplis_afterallpuff_content_homo];

amplis = [amplis_aCSF;amplis_content];

genotype_WT(1:length(amplis_afterallpuff_content_WT),1) = "WT";
genotype_homo(1:length(amplis_afterallpuff_content_homo),1) = "homo";
genotype = [genotype_WT;genotype_homo;genotype_WT;genotype_homo];

stim_aCSF(1:length(amplis_aCSF),1) = "aCSF";
stim_content(1:length(amplis_content),1) = "content";
stim_nature = [stim_aCSF;stim_content];

all_amplis = [stim_nature,genotype,amplis];
var_names = ["stim_nature","genotype","amplis"];
all_amplis = [var_names;all_amplis];

% The created matrix needed to be opened to add a sheet name + replace dot
% by commas for the values of amplitude 

writematrix(all_amplis,'amplis.xlsx');

%Save the final structure

save(strcat(folder_content_homo,'Mutant','.mat'),'output');

clear baseline
close all

end
