function [outputArg1,outputArg2] = tau(inputArg1,alpha)
%TAU �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
%��� �ñ׸��̵� �Լ�
outputArg1= 2/(1+exp(-alpha*inputArg1))-1;

%���Լ�
outputArg2=(alpha/2)*(1+outputArg1)*(1-outputArg1);

end

