P = rands(2, 1000); % ����������� ��������� �������� ��� �������������
plot(P(1,:), P(2,:), '*g') % ����������� ��������� ��������
net = newsom ([0 1; 0 1], [5 6]);
plotsom(net. iw{ 1,1}, net.layers{1}.distances); % ������������ SOM

net.trainParam.epochs = 100; % ��������� ���������� ����
net = train(net, P) % �������� ����

plotsom(net.iw{ 1,1}, net.layers{1}.distances)
p = [0.3; 0.5]; % ����������� ������ �������
a = 0; % ��������� ��������� ���������� a
a = sim(net, p)
a