clc; clear; close all;
tic


fidIn = fopen('用户词典.plist', 'r');

plistLineNum = [];   % plist文件中<dict>的行号
phraseIdx = 1;    % 短语序号
lineIdx = 1;
while ~feof(fidIn)
    line = fgetl(fidIn);
    cutLine{lineIdx} = strsplit(line, '\t');   % 按Tab分割行字符串
    
    % 寻找<dict>
    if strcmp(cutLine{lineIdx}(end), '<dict>') == true
%         disp('Phrase detected.');
        plistLineNum(phraseIdx) = lineIdx;
        phraseIdx = phraseIdx + 1;       
    end
    
    lineIdx = lineIdx + 1;
end

[~, numPhrases] = size(plistLineNum);
phrases = {};

for i = 1: numPhrases
    phrases{i, 1} = cutLine{plistLineNum(i) + 4}{2}(9: end - 9);     % 拼音
    phrases{i, 2} = 1;      % 默认出现在第一个候选项
    phrases{i, 3} = cutLine{plistLineNum(i) + 2}{2}(9: end - 9);     % 短语
end


toc