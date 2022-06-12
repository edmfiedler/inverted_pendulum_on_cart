clear
clc
close all

%% Load state-space system + Controller
Controller

%% Simulate

time = 0:ts:20;
data = zeros(4,length(time)+1);

% Initialize
x = [-1;0;0;0];
xi = -1.48;
u = 0;
data(:,1) = x;

ref = squarewave(time,4);


figure
set(gcf,'position',[560,320,800,400])
set(groot,'defaultAxesTickLabelInterpreter','latex');  

k = 1;
i = 2;
for t = time
    x = Ad*x+Bd*u;
    y = Cd*x+Dd*u;

    data(:,i) = x;
    i = i + 1;
    % Exit condition, pendulum is dropped
    if abs(x(3)) > pi/2
        break
    end

    % Animation
    if rem(t,0.025) == 0
        clf
        theta = (pi/2)+x(3);
        plot([y(1) y(1)+l*cos(theta)],[0 l*sin(theta)],'b','LineWidth',1.2)
        hold on
        plot(y(1)+l*cos(theta),l*sin(theta),'bo','LineWidth',5)
        plot([y(1)-0.2 y(1)+0.2],[0 0],'k','LineWidth',1.2)
        plot([y(1)-0.2 y(1)+0.2],[-0.1 -0.1],'k','LineWidth',1.2)
        plot([y(1)-0.2 y(1)-0.2],[0 -0.1],'k','LineWidth',1.2)
        plot([y(1)+0.2 y(1)+0.2],[0 -0.1],'k','LineWidth',1.2)
        plot(y(1)+0.15,-0.15,'ko','LineWidth',5)
        plot(y(1)-0.15,-0.15,'ko','LineWidth',5)
        hold off
        axis('equal')
        ylim([-0.2 1.5])
        xlim([-2 2])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        title(['Position ',num2str(y(1),'%0.2f'),'m, Angle ',num2str(rad2deg(x(3)),'%0.2f'),'$^\circ$, Time ',num2str(t,'%0.2f'),'s'],'Interpreter','latex','FontSize',14)
        xlabel('Position [m]','Interpreter','latex')
        drawnow
    end
    
    x_n = [x(1);x(2);x(3) + randn*0.1;x(4)];
    u = -Kx*x_n+Ki*xi;
    e = ref(k)-y(1);
    k = k + 1;
    xi = xi + e*ts;
end

%% Plot

figure
set(gcf,'position',[560,320,800,500])

subplot(2,1,1)
plot(time,data(1,1:end-1),'LineWidth',1.2)
hold on
plot(time,ref(1:length(time)),'--','LineWidth',1.2)
hold off
legend({'Position','Reference'},'Interpreter','latex','FontSize',9)
xlim([0 ts*(i-3)])
ylim([-1.5 1.5])
title('Cart Position','Interpreter','latex','FontSize',14)
xlabel({'Time [s]';''},'Interpreter','latex','FontSize',11)
ylabel('x [m]','Interpreter','latex','FontSize',11)
grid('on')

subplot(2,1,2)
plot(time,data(3,1:end-1),'LineWidth',1.2)
xlim([0 ts*(i-3)])
ylim([-0.25 0.25])
title('Pendulum Angle','Interpreter','latex','FontSize',14)
xlabel('Time [s]','Interpreter','latex','FontSize',11)
ylabel('$\varphi$ [rad]','Interpreter','latex','FontSize',11)
grid('on')