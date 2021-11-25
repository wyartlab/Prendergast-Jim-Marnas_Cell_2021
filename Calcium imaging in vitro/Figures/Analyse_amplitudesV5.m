function output = Analyse_amplitudesV5()

clear 
close all

output=struct('mean_spontaneous', [],'mean_aCSF', [],'mean_content', [],'median_spontaneous',[],'median_aCSF',[],'median_content',[],'mean_delay_content',[],'mean_timetopeak_content',[],'median_delay_content',[],'median_timetopeak_content',[],'hypothesis_ttest',[],'p_value_ttest',[],'tstats_ttest',[]);

freq = 5; %Your frequency in Hertz;
n = 3; %Number of frames to add before and after for your peak amplitude

%Takes all your control cells output and extract all the peak amplitude and
%put them in "amplis_afterallpuff_control"

disp('Select ALL your "control" outputs')
[control, folder_control] = uigetfile('*.*','MultiSelect','on');
nTrials_control = size(control,2);

for i = 1:nTrials_control;
    controlData(i,1) = load(fullfile(folder_control, control{i}));
    for j = 1:size(controlData(i).output.dff,2)
        dff_control{i,j} = controlData(i).output.dff(:,j);
        if isnan(controlData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_control(i,j) = NaN;
            amplispuff_peak1_control(i,j) = NaN;
            timetopeak_peak1_control(i,j) = NaN;
            delay_peak1_control(i,j) = NaN;
        else
            amplis_peak1_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time1(j,1)-(2*n):1:controlData(i).output.time1(j,1),j));
            amplispuff_peak1_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time1(j,3)-n:1:controlData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_control(i,j) = controlData(i).output.time1(j,3)/freq - controlData(i).output.time1(j,2)/freq;
            delay_peak1_control(i,j) = controlData(i).output.time1(j,2)/freq - controlData(i).output.time1(j,1)/freq;
        end
        if isnan(controlData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_control(i,j) = NaN;
            amplispuff_peak2_control(i,j) = NaN;
            timetopeak_peak2_control(i,j) = NaN;
            delay_peak2_control(i,j) = NaN;
        else
            amplis_peak2_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time2(j,1)-(2*n):1:controlData(i).output.time2(j,1),j));
            amplispuff_peak2_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time2(j,3)-n:1:controlData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_control(i,j) = controlData(i).output.time2(j,3)/freq - controlData(i).output.time2(j,2)/freq;
            delay_peak2_control(i,j) = controlData(i).output.time2(j,2)/freq - controlData(i).output.time2(j,1)/freq;
        end
        if isnan(controlData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_control(i,j) = NaN;
            amplispuff_peak3_control(i,j) = NaN;
            timetopeak_peak3_control(i,j) = NaN;
            delay_peak3_control(i,j) = NaN;
        else
            amplis_peak3_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time3(j,1)-(2*n):1:controlData(i).output.time3(j,1),j));
            amplispuff_peak3_control(i,j) = mean(controlData(i).output.dff(controlData(i).output.time3(j,3)-n:1:controlData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_control(i,j) = controlData(i).output.time3(j,3)/freq - controlData(i).output.time3(j,2)/freq;
            delay_peak3_control(i,j) = controlData(i).output.time3(j,2)/freq - controlData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_control(amplis_peak1_control == 0) = NaN;
amplis_peak2_control(amplis_peak2_control == 0) = NaN;
amplis_peak3_control(amplis_peak3_control == 0) = NaN;
amplispuff_peak1_control(amplispuff_peak1_control == 0) = NaN;
amplispuff_peak2_control(amplispuff_peak2_control == 0) = NaN;
amplispuff_peak3_control(amplispuff_peak3_control == 0) = NaN;
timetopeak_peak1_control(timetopeak_peak1_control == 0) = NaN;
timetopeak_peak2_control(timetopeak_peak2_control == 0) = NaN;
timetopeak_peak3_control(timetopeak_peak3_control == 0) = NaN;
delay_peak1_control(delay_peak1_control == 0) = NaN;
delay_peak2_control(delay_peak2_control == 0) = NaN;
delay_peak3_control(delay_peak3_control == 0) = NaN;
amplis_afterpuff1_control = amplispuff_peak1_control - amplis_peak1_control;
amplis_afterpuff2_control = amplispuff_peak2_control - amplis_peak2_control;
amplis_afterpuff3_control = amplispuff_peak3_control - amplis_peak3_control;
amplis_afterallpuff_control = [amplis_afterpuff1_control;amplis_afterpuff2_control;amplis_afterpuff3_control];
delay_control = [delay_peak1_control;delay_peak2_control;delay_peak3_control];
timetopeak_control = [timetopeak_peak1_control;timetopeak_peak2_control;timetopeak_peak3_control];


%Takes all your spontaneous cells output and extract all the peak amplitude and
%put them in "amplis_afterallpuff_spontaneous"

disp('Select ALL your "spontaneous" outputs')
[spontaneous, folder_spontaneous] = uigetfile('*.*','MultiSelect','on');
nTrials_spontaneous = size(spontaneous,2);

for i = 1:nTrials_spontaneous;
    spontaneousData(i,1) = load(fullfile(folder_spontaneous, spontaneous{i}));
    for j = 1:size(spontaneousData(i).output.dff,2)
        dff_spontaneous{i,j} = spontaneousData(i).output.dff(:,j);
        if isnan(spontaneousData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time1(j,1)-(2*n):1:spontaneousData(i).output.time1(j,1),j));
            amplispuff_peak1_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time1(j,3)-n:1:spontaneousData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_spontaneous(i,j) = NaN;
            delay_peak1_spontaneous(i,j) = NaN;
        else
            amplis_peak1_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time1(j,1)-(2*n):1:spontaneousData(i).output.time1(j,1),j));
            amplispuff_peak1_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time1(j,3)-n:1:spontaneousData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_spontaneous(i,j) = spontaneousData(i).output.time1(j,3)/freq - spontaneousData(i).output.time1(j,2)/freq;
            delay_peak1_spontaneous(i,j) = spontaneousData(i).output.time1(j,2)/freq - spontaneousData(i).output.time1(j,1)/freq;
        end
        if isnan(spontaneousData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time2(j,1)-(2*n):1:spontaneousData(i).output.time2(j,1),j));
            amplispuff_peak2_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time2(j,3)-n:1:spontaneousData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_spontaneous(i,j) = NaN;
            delay_peak2_spontaneous(i,j) = NaN;
        else
            amplis_peak2_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time2(j,1)-(2*n):1:spontaneousData(i).output.time2(j,1),j));
            amplispuff_peak2_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time2(j,3)-n:1:spontaneousData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_spontaneous(i,j) = spontaneousData(i).output.time2(j,3)/freq - spontaneousData(i).output.time2(j,2)/freq;
            delay_peak2_spontaneous(i,j) = spontaneousData(i).output.time2(j,2)/freq - spontaneousData(i).output.time2(j,1)/freq;
        end
        if isnan(spontaneousData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time3(j,1)-(2*n):1:spontaneousData(i).output.time3(j,1),j));
            amplispuff_peak3_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time3(j,3)-n:1:spontaneousData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_spontaneous(i,j) = NaN;
            delay_peak3_spontaneous(i,j) = NaN;
        else
            amplis_peak3_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time3(j,1)-(2*n):1:spontaneousData(i).output.time3(j,1),j));
            amplispuff_peak3_spontaneous(i,j) = mean(spontaneousData(i).output.dff(spontaneousData(i).output.time3(j,3)-n:1:spontaneousData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_spontaneous(i,j) = spontaneousData(i).output.time3(j,3)/freq - spontaneousData(i).output.time3(j,2)/freq;
            delay_peak3_spontaneous(i,j) = spontaneousData(i).output.time3(j,2)/freq - spontaneousData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_spontaneous(amplis_peak1_spontaneous == 0) = NaN;
amplis_peak2_spontaneous(amplis_peak2_spontaneous == 0) = NaN;
amplis_peak3_spontaneous(amplis_peak3_spontaneous == 0) = NaN;
amplispuff_peak1_spontaneous(amplispuff_peak1_spontaneous == 0) = NaN;
amplispuff_peak2_spontaneous(amplispuff_peak2_spontaneous == 0) = NaN;
amplispuff_peak3_spontaneous(amplispuff_peak3_spontaneous == 0) = NaN;
timetopeak_peak1_spontaneous(timetopeak_peak1_spontaneous == 0) = NaN;
timetopeak_peak2_spontaneous(timetopeak_peak2_spontaneous == 0) = NaN;
timetopeak_peak3_spontaneous(timetopeak_peak3_spontaneous == 0) = NaN;
delay_peak1_spontaneous(delay_peak1_spontaneous == 0) = NaN;
delay_peak2_spontaneous(delay_peak2_spontaneous == 0) = NaN;
delay_peak3_spontaneous(delay_peak3_spontaneous == 0) = NaN;
amplis_afterpuff1_spontaneous = amplispuff_peak1_spontaneous - amplis_peak1_spontaneous;
amplis_afterpuff2_spontaneous = amplispuff_peak2_spontaneous - amplis_peak2_spontaneous;
amplis_afterpuff3_spontaneous = amplispuff_peak3_spontaneous - amplis_peak3_spontaneous;
amplis_afterallpuff_spontaneous = [amplis_afterpuff1_spontaneous;amplis_afterpuff2_spontaneous;amplis_afterpuff3_spontaneous];
delay_spontaneous = [delay_peak1_spontaneous;delay_peak2_spontaneous;delay_peak3_spontaneous];
timetopeak_spontaneous = [timetopeak_peak1_spontaneous;timetopeak_peak2_spontaneous;timetopeak_peak3_spontaneous];


%Takes all your aCSF cells output and extract all the peak amplitude and
%put them in "amplis_afterallpuff_aCSF"

disp('Select ALL your "aCSF" outputs')
[aCSF, folder_aCSF] = uigetfile('*.*','MultiSelect','on');
nTrials_aCSF = size(aCSF,2);

for i = 1:nTrials_aCSF;
    aCSFData(i,1) = load(fullfile(folder_aCSF, aCSF{i}));
    for j = 1:size(aCSFData(i).output.dff,2)
        dff_aCSF{i,j} = aCSFData(i).output.dff(:,j);
        if isnan(aCSFData(i).output.dfftau1{1,j}) == 1;
            amplis_peak1_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time1(j,1)-(2*n):1:aCSFData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time1(j,3)-n:1:aCSFData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF(i,j) = NaN;
            delay_peak1_aCSF(i,j) = NaN;
        else
            amplis_peak1_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time1(j,1)-(2*n):1:aCSFData(i).output.time1(j,1),j));
            amplispuff_peak1_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time1(j,3)-n:1:aCSFData(i).output.time1(j,3)+n,j));
            timetopeak_peak1_aCSF(i,j) = aCSFData(i).output.time1(j,3)/freq - aCSFData(i).output.time1(j,2)/freq;
            delay_peak1_aCSF(i,j) = aCSFData(i).output.time1(j,2)/freq - aCSFData(i).output.time1(j,1)/freq;
        end
        if isnan(aCSFData(i).output.dfftau2{1,j}) == 1;
            amplis_peak2_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time2(j,1)-(2*n):1:aCSFData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time2(j,3)-n:1:aCSFData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF(i,j) = NaN;
            delay_peak2_aCSF(i,j) = NaN;
        else
            amplis_peak2_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time2(j,1)-(2*n):1:aCSFData(i).output.time2(j,1),j));
            amplispuff_peak2_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time2(j,3)-n:1:aCSFData(i).output.time2(j,3)+n,j));
            timetopeak_peak2_aCSF(i,j) = aCSFData(i).output.time2(j,3)/freq - aCSFData(i).output.time2(j,2)/freq;
            delay_peak2_aCSF(i,j) = aCSFData(i).output.time2(j,2)/freq - aCSFData(i).output.time2(j,1)/freq;
        end
        if isnan(aCSFData(i).output.dfftau3{1,j}) == 1;
            amplis_peak3_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time3(j,1)-(2*n):1:aCSFData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time3(j,3)-n:1:aCSFData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF(i,j) = NaN;
            delay_peak3_aCSF(i,j) = NaN;
        else
            amplis_peak3_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time3(j,1)-(2*n):1:aCSFData(i).output.time3(j,1),j));
            amplispuff_peak3_aCSF(i,j) = mean(aCSFData(i).output.dff(aCSFData(i).output.time3(j,3)-n:1:aCSFData(i).output.time3(j,3)+n,j));
            timetopeak_peak3_aCSF(i,j) = aCSFData(i).output.time3(j,3)/freq - aCSFData(i).output.time3(j,2)/freq;
            delay_peak3_aCSF(i,j) = aCSFData(i).output.time3(j,2)/freq - aCSFData(i).output.time3(j,1)/freq;
        end
    end
end

amplis_peak1_aCSF(amplis_peak1_aCSF == 0) = NaN;
amplis_peak2_aCSF(amplis_peak2_aCSF == 0) = NaN;
amplis_peak3_aCSF(amplis_peak3_aCSF == 0) = NaN;
amplispuff_peak1_aCSF(amplispuff_peak1_aCSF == 0) = NaN;
amplispuff_peak2_aCSF(amplispuff_peak2_aCSF == 0) = NaN;
amplispuff_peak3_aCSF(amplispuff_peak3_aCSF == 0) = NaN;
timetopeak_peak1_aCSF(timetopeak_peak1_aCSF == 0) = NaN;
timetopeak_peak2_aCSF(timetopeak_peak2_aCSF == 0) = NaN;
timetopeak_peak3_aCSF(timetopeak_peak3_aCSF == 0) = NaN;
delay_peak1_aCSF(delay_peak1_aCSF == 0) = NaN;
delay_peak2_aCSF(delay_peak2_aCSF == 0) = NaN;
delay_peak3_aCSF(delay_peak3_aCSF == 0) = NaN;
amplis_afterpuff1_aCSF = amplispuff_peak1_aCSF - amplis_peak1_aCSF;
amplis_afterpuff2_aCSF = amplispuff_peak2_aCSF - amplis_peak2_aCSF;
amplis_afterpuff3_aCSF = amplispuff_peak3_aCSF - amplis_peak3_aCSF;
amplis_afterallpuff_aCSF = [amplis_afterpuff1_aCSF;amplis_afterpuff2_aCSF;amplis_afterpuff3_aCSF];
delay_aCSF = [delay_peak1_aCSF;delay_peak2_aCSF;delay_peak3_aCSF];
timetopeak_aCSF = [timetopeak_peak1_aCSF;timetopeak_peak2_aCSF;timetopeak_peak3_aCSF];

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

%Here it checks that the 4 matrix containing your spontaneous, control, aCSF and
%content data have the same size (if you have less cells for one
%condition for example, the size will be different). If the is a difference
%of size, it corrects it

if isequal(size(amplis_afterallpuff_control),size(amplis_afterallpuff_spontaneous),size(amplis_afterallpuff_aCSF),size(amplis_afterallpuff_content))==0;
    if length(amplis_afterallpuff_control) >= length(amplis_afterallpuff_aCSF);
        n = length(amplis_afterallpuff_control);
    else
        n = length(amplis_afterallpuff_aCSF);
    end
    if length(amplis_afterallpuff_spontaneous) >= n;
        n = length(amplis_afterallpuff_spontaneous);
    else
        n = n;
    end
    if length(amplis_afterallpuff_content) >= n;
        n = length(amplis_afterallpuff_content);
    else
        n = n;
    end
    if n > length(amplis_afterallpuff_control);
        A1 = zeros(n,size(amplis_afterallpuff_control,2));
        A1(1:size(amplis_afterallpuff_control,1),:) = amplis_afterallpuff_control;
        A1(size(amplis_afterallpuff_control,1)+1:n,:) = NaN;
        amplis_afterallpuff_control = A1;
    end
    if n > length(amplis_afterallpuff_spontaneous);
        A2 = zeros(n,size(amplis_afterallpuff_spontaneous,2));
        A2(1:size(amplis_afterallpuff_spontaneous,1),:) = amplis_afterallpuff_spontaneous;
        A2(size(amplis_afterallpuff_spontaneous,1)+1:n,:) = NaN;
        amplis_afterallpuff_spontaneous = A2;
    end
    if n > length(amplis_afterallpuff_aCSF);
        A3 = zeros(n,size(amplis_afterallpuff_aCSF,2));
        A3(1:size(amplis_afterallpuff_aCSF,1),:) = amplis_afterallpuff_aCSF;
        A3(size(amplis_afterallpuff_aCSF,1)+1:n,:) = NaN;
        amplis_afterallpuff_aCSF = A3;
    end
    if n > length(amplis_afterallpuff_content);
        A4 = zeros(n,size(amplis_afterallpuff_content,2));
        A4(1:size(amplis_afterallpuff_content,1),:) = amplis_afterallpuff_content;
        A4(size(amplis_afterallpuff_content,1)+1:n,:) = NaN;
        amplis_afterallpuff_content = A4;
    end
end

%Dataset are created: it concatenates all your data in a matrix

dataset = [amplis_afterallpuff_control,amplis_afterallpuff_spontaneous,amplis_afterallpuff_aCSF,amplis_afterallpuff_content];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %FIGURES OF ALL THE DATA%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Figure of all the DFF for the 3 conditions

light_control = 85;
light_control_2 = light_control + 320;
light_control_3 = light_control_2 + 320;
puff1_1000framescontrol = light_control + 64;
puff2_1000framescontrol = puff1_1000framescontrol + 320;
puff3_1000framescontrol = puff2_1000framescontrol + 320;

lightpuff = 585;
lightpuff_2 = lightpuff + 320;
lightpuff_3 = lightpuff_2 + 320;
puff1 = lightpuff + 64;
puff2 = puff1 + 320;
puff3 = puff2 + 320;

ypuff(:,1)=ones(1,3001);
ypuff(:,2)=[0:0.1:300];

figure(1);
x = 0;
for i = 1:nTrials_spontaneous;
    for j = 1:size(spontaneousData(i).output.dff,2)
        hold on;
        plot([1:1:light_control-5]/freq,dff_spontaneous{i,j}(1:light_control-5)+x,'Color', [0.8, 0.8, 1]);
        plot([light_control+5:1:light_control_2-5]/freq,dff_spontaneous{i,j}(light_control+5:light_control_2-5)+x,'Color', [0.8, 0.8, 1]);
        plot([light_control_2+5:1:light_control_3-5]/freq,dff_spontaneous{i,j}(light_control_2+5:light_control_3-5)+x,'Color', [0.8, 0.8, 1]);
        plot([light_control_3+5:1:length(dff_spontaneous{i})]/freq,dff_spontaneous{i,j}(light_control_3+5:length(dff_spontaneous{i}))+x,'Color', [0.8, 0.8, 1]);
        x = x + 100;
    end
end
hold on;
xlabel('Time (in seconds)');
ylabel('%DF/F');
title('DF/F over time - spontaneous');
xlim([0 400]);
ylim([-50 2000]);
yticks(0:100:2000);
plot([puff1_1000framescontrol/freq puff1_1000framescontrol/freq],[ypuff],'r');
hold on;
plot([puff2_1000framescontrol/freq puff2_1000framescontrol/freq],[ypuff],'r');
hold on;
plot([puff3_1000framescontrol/freq puff3_1000framescontrol/freq],[ypuff],'r');
hold off
vccd = strcat(folder_content, 'DFF traces - spontaneous');
saveas(gcf,vccd,'fig'); 


figure(2);
y = 0;
for i = 1:nTrials_aCSF;
    for j = 1:size(aCSFData(i).output.dff,2)
        hold on;
        plot([1:1:lightpuff-5]/freq,dff_aCSF{i,j}(1:lightpuff-5)+y,'Color', [0.8, 0.8, 1]);
        plot([lightpuff+5:1:lightpuff_2-5]/freq,dff_aCSF{i,j}(lightpuff+5:lightpuff_2-5)+y,'Color', [0.8, 0.8, 1]);
        plot([lightpuff_2+5:1:lightpuff_3-5]/freq,dff_aCSF{i,j}(lightpuff_2+5:lightpuff_3-5)+y,'Color', [0.8, 0.8, 1]);
        plot([lightpuff_3+5:1:length(dff_aCSF{1})]/freq,dff_aCSF{i,j}(lightpuff_3+5:length(dff_aCSF{1}))+y,'Color', [0.8, 0.8, 1]);
        y = y + 100;
    end
end
hold on;
xlabel('Time (in seconds)');
ylabel('%DF/F');
title('DF/F over time - aCSF');
xlim([0 400]);
ylim([-50 2000]);
yticks(0:100:2000);
plot([puff1/freq puff1/freq],[ypuff],'r');
hold on;
plot([puff2/freq puff2/freq],[ypuff],'r');
hold on;
plot([puff3/freq puff3/freq],[ypuff],'r');
hold off
vccd = strcat(folder_content, 'DFF traces - aCSF');
saveas(gcf,vccd,'fig');


figure(3);
z = 0;
for i = 1:nTrials_content;
    for j = 1:size(contentData(i).output.dff,2)
        hold on;
        plot([1:1:lightpuff-5]/freq,dff_content{i,j}(1:lightpuff-5)+z,'Color', [0.8, 0.8, 1]);
        plot([lightpuff+5:1:lightpuff_2-5]/freq,dff_content{i,j}(lightpuff+5:lightpuff_2-5)+z,'Color', [0.8, 0.8, 1]);
        plot([lightpuff_2+5:1:lightpuff_3-5]/freq,dff_content{i,j}(lightpuff_2+5:lightpuff_3-5)+z,'Color', [0.8, 0.8, 1]);
        plot([lightpuff_3+5:1:length(dff_content{i})]/freq,dff_content{i,j}(lightpuff_3+5:length(dff_content{i}))+z,'Color', [0.8, 0.8, 1]);
        z = z + 100;
    end
end
hold on;
xlabel('Time (in seconds)');
ylabel('%DF/F');
title('DF/F over time - content');
xlim([0 400]);
ylim([-50 2000]);
yticks(0:100:2000);
plot([puff1/freq puff1/freq],[ypuff],'r');
hold on;
plot([puff2/freq puff2/freq],[ypuff],'r');
hold on;
plot([puff3/freq puff3/freq],[ypuff],'r');
hold off
vccd = strcat(folder_content, 'DFF traces - content');
saveas(gcf,vccd,'fig'); 


%Figure of the peak amplitudes aCSF VS content puff by puff + spontaneous

figure(4);
x_amplis_afterallpuff_spontaneous(1:1:size(amplis_afterallpuff_spontaneous,1),1)=1;
x_amplis_afterpuff1_aCSF(1:1:size(amplis_afterpuff1_aCSF,1),1)=2;
x_amplis_afterpuff1_content(1:1:size(amplis_afterpuff1_content,1),1)=3;
x_amplis_afterpuff2_aCSF(1:1:size(amplis_afterpuff2_aCSF,1),1)=4;
x_amplis_afterpuff2_content(1:1:size(amplis_afterpuff2_content,1),1)=5;
x_amplis_afterpuff3_aCSF(1:1:size(amplis_afterpuff3_aCSF,1),1)=6;
x_amplis_afterpuff3_content(1:1:size(amplis_afterpuff3_content,1),1)=7;
sz = 75;
for i = 1:size(amplis_afterallpuff_spontaneous,2)
    (scatter(x_amplis_afterallpuff_spontaneous,amplis_afterallpuff_spontaneous(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.1));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff1_aCSF,2)
    (scatter(x_amplis_afterpuff1_aCSF,amplis_afterpuff1_aCSF(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff1_content,2)
    (scatter(x_amplis_afterpuff1_content,amplis_afterpuff1_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff2_aCSF,2)
    (scatter(x_amplis_afterpuff2_aCSF,amplis_afterpuff2_aCSF(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff2_content,2)
    (scatter(x_amplis_afterpuff2_content,amplis_afterpuff2_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff3_aCSF,2)
    (scatter(x_amplis_afterpuff3_aCSF,amplis_afterpuff3_aCSF(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
for i = 1:size(amplis_afterpuff3_content,2)
    (scatter(x_amplis_afterpuff3_content,amplis_afterpuff3_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5));
    hold on
end
hold on
xlim([0.5 7.5]);
xticks([1 2 3 4 5 6 7]);
title('Maximum DF/F aCSF VS content puff by puff + spontaneous','FontSize',18);
ylim([-20 300]);
yticks(0:50:300);
set(gca, 'xticklabel', {'Spontaneous', 'aCSF', 'Content', 'aCSF', 'Content', 'aCSF', 'Content'}); axis square;
ylabel('%DF/F');
hold on
for i = 1:size(amplis_afterpuff1_aCSF,1)
    for j = 1:size(amplis_afterpuff1_aCSF,2)
        line([2,3] , [amplis_afterpuff1_aCSF(i,j),amplis_afterpuff1_content(i,j)],'Color',[0.7 0.7 0.7]);
        line([4,5] , [amplis_afterpuff2_aCSF(i,j),amplis_afterpuff2_content(i,j)],'Color',[0.7 0.7 0.7]);
        line([6,7] , [amplis_afterpuff3_aCSF(i,j),amplis_afterpuff3_content(i,j)],'Color',[0.7 0.7 0.7]);
    end
end
mean_spontaneous = mean(amplis_afterallpuff_spontaneous(:),'omitnan');
mean_aCSF = [mean(amplis_afterpuff1_aCSF(:),'omitnan');mean(amplis_afterpuff2_aCSF(:),'omitnan');mean(amplis_afterpuff3_aCSF(:),'omitnan')];
mean_content = [mean(amplis_afterpuff1_content(:),'omitnan');mean(amplis_afterpuff2_content(:),'omitnan');mean(amplis_afterpuff3_content(:),'omitnan')];
median_spontaneous = median(amplis_afterallpuff_spontaneous(:),'omitnan');
median_aCSF = [median(amplis_afterpuff1_aCSF(:),'omitnan');median(amplis_afterpuff2_aCSF(:),'omitnan');median(amplis_afterpuff3_aCSF(:),'omitnan')];
median_content = [median(amplis_afterpuff1_content(:),'omitnan');median(amplis_afterpuff2_content(:),'omitnan');median(amplis_afterpuff3_content(:),'omitnan')];
mean_spont = 0.5:1.5;
median_spont = 0.5:1.5;
plot(mean_spont,mean_spontaneous*ones(size(mean_spont)),'r');
hold on
plot(median_spont,median_spontaneous*ones(size(median_spont)),'k');
hold on
line([2,3], [mean_aCSF(1,1), mean_content(1,1)], 'Color', 'r', 'LineWidth', 3);
line([4,5], [mean_aCSF(2,1), mean_content(2,1)], 'Color', 'r', 'LineWidth', 3);
line([6,7], [mean_aCSF(3,1), mean_content(3,1)], 'Color', 'r', 'LineWidth', 3);
line([2,3], [median_aCSF(1,1),median_content(1,1)], 'Color', 'k', 'LineWidth', 2);
line([4,5], [median_aCSF(2,1),median_content(2,1)], 'Color', 'k', 'LineWidth', 2);
line([6,7], [median_aCSF(3,1),median_content(3,1)], 'Color', 'k', 'LineWidth', 2);
hold off;
vccd = strcat(folder_content, 'Maximum DFF aCSF VS content puff by puff + control');
saveas(gcf,vccd,'fig');

output.mean_spontaneous=mean_spontaneous;
output.mean_aCSF=mean_aCSF;
output.mean_content=mean_content;
output.median_spontaneous=median_spontaneous;
output.median_aCSF=median_aCSF;
output.median_content=median_content;

%%%%% Statistics %%%%%

[h,p,stats] = ttest(amplis_afterpuff1_aCSF(:),amplis_afterpuff1_content(:));
hypothesis_ttest(1,:) = h;
p_value_ttest(1,:) = p;
tstats_ttest(:,:,1) = stats;

[h,p,stats] = ttest(amplis_afterpuff2_aCSF(:),amplis_afterpuff2_content(:));
hypothesis_ttest(2,:) = h;
p_value_ttest(2,:) = p;
tstats_ttest(:,:,2) = stats;

[h,p,stats] = ttest(amplis_afterpuff3_aCSF(:),amplis_afterpuff3_content(:));
hypothesis_ttest(3,:) = h;
p_value_ttest(3,:) = p;
tstats_ttest(:,:,3) = stats;

output.hypothesis_ttest=hypothesis_ttest;
output.p_value_ttest=p_value_ttest;
output.tstats_ttest=tstats_ttest;

%%%% Creation of a matrix for exporting in xlsx for ANOVA analysis with R

TN = isnan(amplis_afterpuff1_aCSF);
amplis_afterpuff1_aCSF(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff1_aCSF = amplis_afterpuff1_aCSF';
else
end
TN = isnan(amplis_afterpuff2_aCSF);
amplis_afterpuff2_aCSF(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff2_aCSF = amplis_afterpuff2_aCSF';
else
end
TN = isnan(amplis_afterpuff3_aCSF);
amplis_afterpuff3_aCSF(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff3_aCSF = amplis_afterpuff3_aCSF';
else
end
amplis_aCSF = [amplis_afterpuff1_aCSF;amplis_afterpuff2_aCSF;amplis_afterpuff3_aCSF];

TN = isnan(amplis_afterpuff1_content);
amplis_afterpuff1_content(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff1_content = amplis_afterpuff1_content';
else
end
TN = isnan(amplis_afterpuff2_content);
amplis_afterpuff2_content(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff2_content = amplis_afterpuff2_content';
else
end
TN = isnan(amplis_afterpuff3_content);
amplis_afterpuff3_content(TN) = [];
if any(TN(:) == 1)
    amplis_afterpuff3_content = amplis_afterpuff3_content';
else
end
amplis_content = [amplis_afterpuff1_content;amplis_afterpuff2_content;amplis_afterpuff3_content];

amplis = [amplis_aCSF;amplis_content];

stim1(1:length(amplis_content)/3,1) = 1;
stim2(1:length(amplis_content)/3,1) = 2;
stim3(1:length(amplis_content)/3,1) = 3;
stim = [stim1;stim2;stim3;stim1;stim2;stim3];

stim_aCSF(1:length(amplis_aCSF),1) = "aCSF";
stim_content(1:length(amplis_content),1) = "content";
stim_nature = [stim_aCSF;stim_content];

all_amplis = [stim_nature,stim,amplis];
var_names = ["stim_nature","stim","amplis"];
all_amplis = [var_names;all_amplis];

% The created matrix needed to be opened to add a sheet name + replace dot
% by commas for the values of amplitude 

writematrix(all_amplis,'amplis.xlsx');

%Figure of latency and time-to-peak for content

figure(5);
x_delay_content(1:1:size(delay_content,1),1)=1;
x_timetopeak_content(1:1:size(timetopeak_content,1),1)=2;
sz = 75;
for i = 1:size(delay_content,2)
    (scatter(x_delay_content,delay_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.1));
    hold on
end
hold on
for i = 1:size(timetopeak_content,2)
    (scatter(x_timetopeak_content,timetopeak_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.1));
    hold on
end
hold on
boxplot([delay_content(:); timetopeak_content(:)],[ones(size(delay_content(:)));2*ones(size(timetopeak_content(:)))]);
hold on
xlim([0.5 2.5]);
xticks([1 2]);
ylim([-0.5 6]);
yticks(0:1:6);
title('Latency and time-to-peak','FontSize',18);
set(gca, 'xticklabel', {'Latency', 'Time-to-peak'}); axis square;
ylabel('Time (in seconds)');
hold off
vccd = strcat(folder_content, 'Delay and time to peak content');
saveas(gcf,vccd,'fig');

mean_delay_content = mean(delay_content(:),'omitnan');
mean_timetopeak_content = mean(timetopeak_content(:),'omitnan');
median_delay_content = median(delay_content(:),'omitnan');
median_timetopeak_content = median(timetopeak_content(:),'omitnan');
output.mean_delay_content=mean_delay_content;
output.mean_timetopeak_content=mean_timetopeak_content;
output.median_delay_content=median_delay_content;
output.median_timetopeak_content=median_timetopeak_content;

%Save the final structure

save(strcat(folder_content,'Amplitudes','.mat'),'output');

clear baseline
close all

end
