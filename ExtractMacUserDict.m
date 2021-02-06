clc; clear; close all;
tic


fidIn = fopen('用户词典.plist', 'r');

dictTagLineIdx = [];   % plist文件中<dict>的行号
phraseIdx = 1;    % 短语序号
lineIdx = 1;
while ~feof(fidIn)
    line{lineIdx} = fgetl(fidIn);
%     cutLine{lineIdx} = strsplit(line{lineIdx}, '\t');   % 按Tab分割行字符串
    
    % 寻找<dict>
    if contains(line{lineIdx}, '<dict>') == true
%         disp('Phrase detected.');
        dictTagLineIdx(phraseIdx) = lineIdx;
        phraseIdx = phraseIdx + 1;       
    end
    
    lineIdx = lineIdx + 1;
end

[~, numPhrases] = size(dictTagLineIdx);
phrases = {};


for i = 1: numPhrases
    %%% plist中一共有几行是当前词条的区域
    if i ~= numPhrases
        rangeCurrPhrase = dictTagLineIdx(i + 1) - dictTagLineIdx(i);      
    else
        rangeCurrPhrase = lineIdx - dictTagLineIdx(i) - 3;
    end

    %%% 找出当前词条<string>和</string>的行号
    isStart(:) = 0;
    isEnd(:) = 0;
    startCnt = 1;
    endCnt = 1;
    for j = 1: rangeCurrPhrase - 1
        if contains(line{dictTagLineIdx(i) + j}, '<string>') == true
            isStart(startCnt) = dictTagLineIdx(i) + j;
            startCnt = startCnt + 1;
        end
        
        if contains(line{dictTagLineIdx(i) + j}, '</string>') == true
            isEnd(endCnt) = dictTagLineIdx(i) + j;
            endCnt = endCnt + 1;
        end
    end
    
    %%% 存储输入码和候选项编号
    phrases{i, 1} = line{isStart(2)}(11: end - 9);
    phrases{i, 2} = 1;      % 默认出现在第一个候选项
    
    %%% 存储短语
    % 一般情况（短语中无换行）
    if isStart(1) == isEnd(1)
        phrases{i, 3} = line{isStart(1)}(11: end - 9);
    end
end


toc