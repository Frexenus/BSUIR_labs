[alphabet, targets] = prprob;
i = 10;
ti = alphabet(:, i);
letter{i} = reshape(ti, 5, 7)';
letter{i}

[R,Q] = size(alphabet);
[S2,Q] = size(targets);

S1 = 10;

net = newff (minmax (alphabet), [S1 S2], {'logsig' 'logsig'}, 'traingdx');
net.LW{2,1} = net.LW{2,1}*0.01;
net.b{2} = net.b{2}*0.01;

gensim(net);

P = alphabet;
T = targets;

net.performFcn = 'sse'; % Sum-Squared Error performance function
net.trainParam.goal = 0.1; % Sum-squared error goal.
net.trainParam.show = 20; % Frequency of progress displays (in epochs).
net.trainParam.epochs = 5000; % Maximum number of epochs to train.
net.trainParam.mc = 0.95;
[net,tr] = train(net, P, T);

netn = net;

netn.trainParam.goal = 0.6; % ���������� �������������������� �����������
netn.trainParam.epochs = 300; % ������������ ���������� ������ ��������

T = [targets targets targets targets];
for pass = 1:10
P = [alphabet, alphabet, ...
(alphabet + randn(R,Q)*0.1), (alphabet + randn(R,Q)*0.2)];
[netn,tr] = train(netn,P,T);
end

netn.trainParam.goal = 0.1; % ���������� ������������������ �����������
netn.trainParam.epochs = 500; % ������������ ���������� ������ ��������

net.trainParam.show = 5; % ������� ������ ����������� �� �����
[netn, tr] = train(netn, P, T);

noise_range = 0:.05:.5;
max_test = 100;
network1 = [];
network2 = [];
T = targets;
for noiselevel = noise_range
fprintf('������� ���� %.2f.\n',noiselevel);
errors1 = 0;
errors2 = 0;
for i = 1:max_test
P = alphabet + randn(35,26)*noiselevel;
% ���� ��� ���� 1
A = sim(net,P);
AA = compet(A);
errors1 = errors1+sum(sum(abs(AA-T)))/2;
% ���� ��� ���� 2
An = sim(netn,P);
AAn = compet(An);
errors2 = errors2+sum(sum(abs(AAn-T)))/2;
end
network1 = [network1 errors1/26/100]; % ������� �������� ������ (100�������������������� �� 26 ��������)
network2 = [network2 errors2/26/100]; % ������� �������� ������ (100 ������������������� �� 26 ��������)
end

plot(noise_range,network1*100,'--',noise_range,network2*100);
title('������� ��������� �������������');
xlabel('������� ����');
ylabel('���� 1 - - ���� 2 ---');

noisyK = alphabet(:,11) + randn(35,1) *0.2;
plotchar(noisyK);

A2 = sim(net, noisyK);
A2 = compet(A2);
answer = find(compet(A2) == 1)
plotchar(alphabet (:,answer));

noisyD = alphabet(:,4) + randn(35,1) *0.2;
plotchar(noisyD);

A2 = sim(net, noisyD);
A2 = compet(A2);
answer = find(compet(A2) == 1)
plotchar(alphabet (:,answer));
