c = 8; %����� ���������
n = 6; %����� �������� � ��������
d = .5; %������� ���������� �� ������ ��������

x = [-10 10; -5 5];
[r,q] = size(x);
minv = min(x')';
maxv = max(x')';
v = rand(r,c).*((maxv-minv)*ones(1,c)+minv*ones(1,c));
t = c*n; % ����� �����
v = [v v v v v v];
v = v+randn(r,t)*d; % ���������� �����
P = v;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot (P(1, :), P(2, :), '+r')
hold on; 
plot (network1.IW{1}(: , 1), network1.IW{1}(: , 2) ,'ob')

data2 = [1.7; 8.7];
a = sim(network1, data2)