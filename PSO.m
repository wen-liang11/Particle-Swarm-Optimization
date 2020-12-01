% PSO DEMO. Find minimum point of the first present figure. which is
% x1=0, x2=0, and lead to z=0


clear; clc;

desire=0;
num_point=size(desire,1);

X1=(-5:0.1:5);
X2=(-5:0.1:5);
Z=ones(101);

for i=1:101
    for j=1:101
        
        Z(i,j)=X1(i)^2+X2(j)^2;
    end
end
% surf(X1,X2,Z,'FaceAlpha',0.5) 
% fprintf('\nProgram paused. Close figure and Press SPACE to continue.\n');
% pause


max_iter=50;
omega=0.9;
c1=1.5;
c2=1.5;
ag=5;              % number of agents
num_var=2;

Posit=-3.5+7*rand(ag,num_var);                  
Veloc=-1.5+3*rand(ag,num_var); 

OUT=zeros(ag,num_point);
Pbest=Posit;
FFx=ones(ag,1);
FFp=ones(ag,1);
FFg=1;
FFg_past=ones(max_iter,1);
Gbest=zeros(1,num_var);               


for k=1:max_iter
    OUT=sum(Posit.^2,2);                

    for l = 1:ag
        
        FFx(l)=norm(OUT(l,:)-desire);
    end


    f_index=FFx<FFp;
    FFp(f_index)=FFx(f_index);
    Pbest(f_index,:)=Posit(f_index,:);

    [min_FFp,g_index]=min(FFp);
    if min_FFp <= FFg
        FFg=min_FFp;
        FFg_past(k)=min_FFp;
        Gbest=Pbest(g_index,:);
    end
    
    
    if FFg < 10^-5
        break
    end
    
    subplot(1,2,1)    
	surf(X1,X2,Z,'FaceAlpha',0.5)
    hold on
    scatter3(Posit(:,1),Posit(:,2),OUT,'filled','r');
    set(gca,'FontSize',14);
    axis([-5 5 -5 5 0 50]);
    hold off
    
    subplot(1,2,2)
    surf(X1,X2,Z,'FaceAlpha',0.5)
    view(2)
    hold on
    scatter3(Posit(:,1),Posit(:,2),OUT,'filled','r');
    axis([-5 5 -5 5]);
    hold off
    
    
    F(k)=getframe(gcf);
    pause(0.4)
    
  
    omega=0.9-0.01*k;
    Veloc=omega.*Veloc+c1*rand(ag,num_var).*(Pbest-Posit)+c2*rand(ag,num_var).*(repmat(Gbest,ag,1)-Posit);
    Posit=Posit+Veloc;


end