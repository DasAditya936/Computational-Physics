%close all;
clear all;
clc;
N=50000; % No. of iterations
Nre=10; % No. of realizations
x=zeros(N,1); % x position of the walker
y=zeros(N,1); % y position of the walker
x(1)=0; % initial x position of the walker
y(1)=0; % initial y position of the walker
for ire=1:Nre % realization loop
    for i=2:N % temporal iteration loop
        ro=rand(1); % random no. for orientation (x or y)
        rd=rand(1); % random no. for displacement
        if ro>=0.5
            y(i)=y(i-1);

            if rd>=0.5
                x(i)=x(i-1)+1;
            else
                x(i)=x(i-1)-1;
            end

        else
            x(i)=x(i-1);
            if rd>=0.5
                y(i)=y(i-1)+1;
            else
                y(i)=y(i-1)-1;
            end
        end
    end
    msd(:,ire)=x.^2+y.^2; % mean square displacement for different realizations
end

% for i=1:N
%     scatter(x(i),y(i),'.k');hold on;
%     pause(0.001);
%     xlim([-50 50]);ylim([-50 50]);
% end

%scatter(x,y,'.');xlim([-300 300]);ylim([-300 300]);

MSD=mean(msd,2); % Mean msd
plot(MSD);
% D=1:N;
% hold on;
% plot(D);
