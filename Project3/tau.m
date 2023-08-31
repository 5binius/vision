function [outputArg1,outputArg2] = tau(inputArg1,alpha)
%TAU 이 함수의 요약 설명 위치
%   자세한 설명 위치
%양극 시그모이드 함수
outputArg1= 2/(1+exp(-alpha*inputArg1))-1;

%도함수
outputArg2=(alpha/2)*(1+outputArg1)*(1-outputArg1);

end

