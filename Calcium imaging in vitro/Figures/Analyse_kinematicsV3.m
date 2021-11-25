function output = Analyse_kinematicsV3()

clear 
close all

output=struct('mean_decay_control',[],'mean_decay_content',[],'median_decay_control',[],'median_decay_content',[],'hypothesis_kstest2',[],'p_value_kstest2',[],'stats_kstest2',[]);

freq = 5; %Your frequency in Hertz;

%Takes all your control cells output and extract the time decay

disp('Select ALL your "control" outputs')
[control, folder_control] = uigetfile('*.*','MultiSelect','on');
nTrials_control = size(control,2);

for i = 1:nTrials_control;
    controlData(i,1) = load(fullfile(folder_control, control{i}));
    for j = 1:size(controlData(i).fitExpo.decay,1)
        time_decay1_control(i,j) = controlData(i).fitExpo.decay(j,1);
        time_decay2_control(i,j) = controlData(i).fitExpo.decay(j,2);
        time_decay3_control(i,j) = controlData(i).fitExpo.decay(j,3);
    end
end

time_decay1_control(time_decay1_control == 0) = NaN;
time_decay2_control(time_decay2_control == 0) = NaN;
time_decay3_control(time_decay3_control == 0) = NaN;
time_decay_control = [time_decay1_control;time_decay2_control;time_decay3_control];


%Takes all your content cells output and extract the time decay

disp('Select ALL your "content" outputs')
[content, folder_content] = uigetfile('*.*','MultiSelect','on');
nTrials_content = size(content,2);

for i = 1:nTrials_content;
    contentData(1,i) = load(fullfile(folder_content, content{i}));
    for j = 1:size(contentData(i).fitExpo.decay,1)
        time_decay1_content(i,j) = contentData(i).fitExpo.decay(j,1);
        time_decay2_content(i,j) = contentData(i).fitExpo.decay(j,2);
        time_decay3_content(i,j) = contentData(i).fitExpo.decay(j,3);
    end
end

time_decay1_content(time_decay1_content == 0) = NaN;
time_decay2_content(time_decay2_content == 0) = NaN;
time_decay3_content(time_decay3_content == 0) = NaN;
time_decay_content = [time_decay1_content;time_decay2_content;time_decay3_content];


%Here it checks that the 3 matrix containing your control and
%content data have the same size (if you have less cells for one
%condition for example, the size will be different). If the is a difference
%of size, it corrects it

if isequal(size(time_decay_control),size(time_decay_content))==0;
    if length(time_decay_control) >= length(time_decay_content);
        n = length(time_decay_control);
    else
        n = length(time_decay_content);
    end
    if n > length(time_decay_control);
        A1 = zeros(n,size(time_decay_control,2));
        A1(1:size(time_decay_control,1),:) = time_decay_control;
        A1(size(time_decay_control,1)+1:n,:) = NaN;
        time_decay_control = A1;
    end
    if n > length(time_decay_content);
        A2 = zeros(n,size(time_decay_content,2));
        A2(1:size(time_decay_content,1),:) = time_decay_content;
        A2(size(time_decay_content,1)+1:n,:) = NaN;
        time_decay_content = A2;
    end
end

%Dataset are created: it concatenates all your data in a matrix

%dataset = [time_decay_control;time_decay_content];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     %FIGURES OF ALL THE DATA %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Figure of the time decay for control (spontaneous activity) and content

figure(1);
x_time_decay_control(1:1:size(time_decay_control,1),1)=1;
x_time_decay_content(1:1:size(time_decay_content,1),1)=2;
sz = 75;
for i = 1:size(time_decay_control,2)
    (scatter(x_time_decay_control,time_decay_control(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.1));
    hold on
end
for i = 1:size(time_decay_content,2)
    (scatter(x_time_decay_content,time_decay_content(:,i),sz,'k','filled','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',.5,'MarkerEdgeAlpha',.5,'jitter', 'on', 'jitterAmount', 0.1));
    hold on
end
hold on
boxplot([time_decay_control(:); time_decay_content(:)],[ones(size(time_decay_control(:)));2*ones(size(time_decay_content(:)))]);
hold on
xlim([0.5 2.5]);
xticks([1 2]);
title('Time decay for control (spontaneous activity) and content','FontSize',18);
ylim([0 30]);
yticks(0:5:30);
set(gca, 'xticklabel', {'Spontaneous', 'Content'}); axis square;
ylabel('Time decay (s)');
hold off;
vccd = strcat(folder_content, 'Time decay for control (spontaneous activity) and content');
saveas(gcf,vccd,'fig');


mean_decay_control = mean(time_decay_control(:),'omitnan');
mean_decay_content = mean(time_decay_content(:),'omitnan');
median_decay_control = median(time_decay_control(:),'omitnan');
median_decay_content = median(time_decay_content(:),'omitnan');
output.mean_decay_control=mean_decay_control;
output.mean_decay_content=mean_decay_content;
output.median_decay_control=median_decay_control;
output.median_decay_content=median_decay_content;

%%%%% Statistics %%%%%

[h,p,ks2stat] = kstest2(time_decay_control(:),time_decay_content(:));
hypothesis_kstest2(1,:) = h;
p_value_kstest2(1,:) = p;
stats_kstest2(:,:,1) = ks2stat;

output.hypothesis_kstest2=hypothesis_kstest2;
output.p_value_kstest2=p_value_kstest2;
output.stats_kstest2=stats_kstest2;

%Save the final structure

save(strcat(folder_content,'Kinematics','.mat'),'output');

clear baseline
close all

end