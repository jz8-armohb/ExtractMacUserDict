clc; clear; close all;
tic


fidIn = fopen('�û��ʵ�.plist', 'r');

dictTagLineIdx = [];   % plist�ļ���<dict>���к�
phraseIdx = 1;    % �������
lineIdx = 1;
while ~feof(fidIn)
    line{lineIdx} = fgetl(fidIn);
%     cutLine{lineIdx} = strsplit(line{lineIdx}, '\t');   % ��Tab�ָ����ַ���
    
    % Ѱ��<dict>
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
    %%% plist��һ���м����ǵ�ǰ����������
    if i ~= numPhrases
        rangeCurrPhrase = dictTagLineIdx(i + 1) - dictTagLineIdx(i);      
    else
        rangeCurrPhrase = lineIdx - dictTagLineIdx(i) - 3;
    end

    %%% �ҳ���ǰ����<string>��</string>���к�
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
    
    %%% �洢������ͺ�ѡ����
    phrases{i, 1} = line{isStart(2)}(11: end - 9);
    phrases{i, 2} = 1;      % Ĭ�ϳ����ڵ�һ����ѡ��
    
    %%% �洢����
    % һ��������������޻��У�
    if isStart(1) == isEnd(1)
        phrases{i, 3} = line{isStart(1)}(11: end - 9);
    end
end


toc