clc; clear; close all;
tic


fidIn = fopen('�û��ʵ�.plist', 'r');

plistLineNum = [];   % plist�ļ���<dict>���к�
phraseIdx = 1;    % �������
lineIdx = 1;
while ~feof(fidIn)
    line = fgetl(fidIn);
    cutLine{lineIdx} = strsplit(line, '\t');   % ��Tab�ָ����ַ���
    
    % Ѱ��<dict>
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
    phrases{i, 1} = cutLine{plistLineNum(i) + 4}{2}(9: end - 9);     % ƴ��
    phrases{i, 2} = 1;      % Ĭ�ϳ����ڵ�һ����ѡ��
    phrases{i, 3} = cutLine{plistLineNum(i) + 2}{2}(9: end - 9);     % ����
end


toc