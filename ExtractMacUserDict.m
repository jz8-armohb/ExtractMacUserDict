clc; clear; close all;
tic


fidIn = fopen('�û��ʵ�.plist', 'r');

dictTagLineIdx = [];   % plist�ļ���<dict>���к�
phraseIdx = 1;    % �������
lineIdx = 1;
while ~feof(fidIn)
    line{lineIdx} = fgetl(fidIn);
    cutLine{lineIdx} = strsplit(line{lineIdx}, '\t');   % ��Tab�ָ����ַ���
    
    % Ѱ��<dict>
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
    
    
    
    
    phrases{i, 1} = cutLine{dictTagLineIdx(i) + 4}{2}(9: end - 9);     % �����루ƴ����
    phrases{i, 2} = 1;      % Ĭ�ϳ����ڵ�һ����ѡ��
    phrases{i, 3} = cutLine{dictTagLineIdx(i) + 2}{2}(9: end - 9);     % ����
end


toc