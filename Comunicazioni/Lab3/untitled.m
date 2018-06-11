clear all
close all
clc

% F=fopen('C:\Users\nunzi\OneDrive\Desktop\main.txt');
% while(~feof(F))
%     riga=fgetl(F)
% end
% fclose(F);

I=imread('D:\Documents\Foto, Video e roba stupida\buffonrit.png');
I=imresize(I,0.5);
figure(1)
imshow(I);