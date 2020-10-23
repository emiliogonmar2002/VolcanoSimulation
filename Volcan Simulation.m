%% Solución Reto Equipo 

clc
g = 9.81;
step = 0.5;
kp = input("Ingrese la resistencia del aire (recomendada 1.17): ");
%kp = 1.165586167;
m = 29984.28182;

% Inicializa los vectores de posición, velocidad y aceleración
h = [];
s = [];
v = [];
vx = [];
vy = [];
ax = [];
ay = [];

% Asignar los valores iniciales
h(1) = 5426;
s(1) = 0;
v(1) = input("Ingrese la velocidad inicial 200-400: ");
%v(1) = 350;
ay(1) = -g;
ax(1) = 0;
ang = input("Ingrese el ángulo 60-80: ");
%ang = 70;
angRad = deg2rad(ang);
vy(1) = sin(angRad)*v(1);
vx(1) = cos(angRad)*v(1);

k = 2;

% Volcan
x = -1570:1570;
volcano = 5426*sin(0.001*x-6*pi/4);

hold on

plot(x,volcano,"kx");

texto = "s";
texto1 = "s";
texto2 = "s";

while h > 0
    % Eje y
        % Nueva posición
        h(k) = h(k-1) + step.*vy(k-1) + 0.5.*ay(k-1).*step.^2;

        % Velocidad intermedio    
        vmy = vy(k-1) + 0.5.*ay(k-1).*step;

        % Nueva aceleración
        ay(k) = -g + (kp./m).*vmy.^2;

        % Nueva velocidad
        vy(k) = vmy + 0.5.*ay(k).*step;   
    
    % Eje x
        % Nueva posición
        s(k) = s(k-1) + step.*vx(k-1) + 0.5.*ax(k-1).*step.^2;

        % Velocidad intermedio    
        vmx = vx(k-1) + 0.5.*ax(k-1).*step;

        % Nueva aceleración
        ax(k) =(kp./m).*vmx.^2 .* sign(vx(k-1));

        % Nueva velocidad
        vx(k) = vmx + 0.5.*ax(k).*step;  
        
       
    % Velocidad
        v(k) = sqrt(vx(k).^2+vy(k)^2);
        
       delete(texto)
       delete(texto1)
       delete(texto2)
       plot(s, h, 'ro')
       xlim([-50000 50000])
       ylim([0 18000])
       texto1 = text(30000, 10000, "v = " + num2str(v(k)));
       texto = text(30000, 9000, "x = " + num2str(s(k)));
       texto2 = text(30000, 8000, "y = " + num2str(h(k)));
       xlabel('s')
       ylabel('h(s)')
       title('Roca 1')
       drawnow
     
    k = k + 1;
end

text(30000, 12000, "hmax = " + num2str(max(h)))
text(30000, 11000, "smax = " + num2str(max(s)))
text(-40000, 12000, "Resitencia del aire = " + num2str(kp))
text(-40000, 11000, "Velocidad inicial = " + num2str(v(1)))
text(-40000, 10000, "Ángulo  = " + num2str(ang))

hold off