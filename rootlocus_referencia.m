% Definir os coeficientes do numerador e do denominador
numerador = [0.00164528 0.0291102 8.87529 77.9155 11972.6 3794.09 30124.6];
denominador = [1 37.7524 5908.58 112781 7917120 23213100 181514000 98883000 392560000];

% Criar a função de transferência
sistema = tf(numerador, denominador);

% Plotar o lugar das raízes
figure;
rlocus(sistema);

% Adicionar título e rótulos aos eixos
title('Lugar das Raízes do Sistema Dinâmico');
xlabel('Parte Real');
ylabel('Parte Imaginária');

% Definir o tempo de simulação
t = 0:0.01:10; % De 0 a 10 segundos com passo de 0.01 segundos

% Simular a resposta ao degrau
[y, t] = step(sistema, t);

% Projetar um compensador de avanço de fase (lead compensator)
% Exemplo de compensador de avanço de fase: (s + z_c) / (s + p_c)
% Onde z_c < p_c
z_c = -5; % Zero do compensador
p_c = -20; % Polo do compensador
compensador = tf([1 -z_c], [1 -p_c]);

% Sistema compensado
sistema_compensado = series(compensador, sistema);

% Plotar o lugar das raízes do sistema compensado
figure;
rlocus(sistema_compensado);
title('Lugar das Raízes do Sistema Compensado');
xlabel('Parte Real');
ylabel('Parte Imaginária');

% Simular a resposta ao degrau do sistema compensado
[y_comp, t_comp] = step(sistema_compensado, t);

% Plotar as respostas do sistema original e do sistema compensado no mesmo gráfico
figure;
plot(t, y, 'b', 'DisplayName', 'Sistema Original'); % 'b' para azul
hold on;
plot(t_comp, y_comp, 'r', 'DisplayName', 'Sistema Compensado'); % 'r' para vermelho

% Adicionar título e rótulos aos eixos
xlabel('Tempo (s)');
ylabel('Resposta');
title('Resposta ao Degrau: Sistema Original e Compensado');
legend('show');
grid on;
hold off;

