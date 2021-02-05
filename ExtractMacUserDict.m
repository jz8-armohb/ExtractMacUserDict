clc; clear; close all;
tic


fidIn = fopen('用户词典.plist', 'r');

dictTagLineIdx = [];   % plist文件中<dict>的行号
phraseIdx = 1;    % 短语序号
lineIdx = 1;
while ~feof(fidIn)
    line{lineIdx} = fgetl(fidIn);
    cutLine{lineIdx} = strsplit(line{lineIdx}, '\t');   % 按Tab分割行字符串
    
    % 寻找<dict>
%     if strcmp(cutLine{lineIdx}(end), '<dict>') == true
    if contains(line{lineIdx}, '<dict>')
%         disp('Phrase detected.');
        dictTagLineIdx(phraseIdx) = lineIdx;
        phraseIdx = phraseIdx + 1;       
    end
    
    lineIdx = lineIdx + 1;
end

[~, numPhrases] = size(dictTagLineIdx);
phrases = {};

for i = 1: numPhrases
    
    strTagStart = zeros(1, 2);
%     while
    
    
    
    
    phrases{i, 1} = cutLine{dictTagLineIdx(i) + 4}{2}(9: end - 9);     % 输入码（拼音）
    phrases{i, 2} = 1;      % 默认出现在第一个候选项
    phrases{i, 3} = cutLine{dictTagLineIdx(i) + 2}{2}(9: end - 9);     % 短语
end


toc