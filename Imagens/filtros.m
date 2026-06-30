clc;
clear;
close all;

%% PROJETO DE FILTROS PASSIVOS BUTTERWORTH DE 2ª ORDEM
% Júlia Emanuelle Ulrich

% O programa:
% Recebe a impedância da carga e a frequência de corte;
% Calcula os componentes teóricos L e C;
% Seleciona os componentes comerciais mais próximos;
% Calcula os erros dos componentes e da frequência de corte;
% Gera os diagramas de Bode dos filtros (teórico e comercial).

fprintf('=============================================\n');
fprintf(' PROJETO DE FILTROS PASSIVOS BUTTERWORTH\n');
fprintf('=============================================\n\n');

%% Entrada de dados
R = input('Digite a impedância da carga (ohms): ');
fc = input('Digite a frequência de corte (Hz): ');

%% Parâmetros do filtro
Q = sqrt(2)/2;          % Butterworth
wc = 2*pi*fc;           % Frequência angular (em rad/s)

%% Componentes teóricos
C = Q/(wc*R);
L = R/(Q*wc);

%% Vetores com os valores comerciais
indutores = [0.10 0.12 0.15 0.18 0.22 0.27 0.33 0.39 ...
            0.47 0.56 0.68 0.82 1.0 1.2 1.5 1.8 2.2 ... 
            2.7 3.3 3.9 4.7 5.6 6.8 8.2 10 12 15]*1e-3;

capacitores = [1.0 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2 ...
              10 12 15 18 22 27 33 39 47 56 68 82 100]*1e-6;

%% Escolha dos componentes comerciais mais próximos
[~,iL] = min(abs(indutores-L));
Lreal = indutores(iL);

[~,iC] = min(abs(capacitores-C));
Creal = capacitores(iC);

%% Diferenças
difL = Lreal - L;
difC = Creal - C;
erroL = abs(difL)/L*100;
erroC = abs(difC)/C*100;

%% Frequência de corte
fcTeorica = 1/(2*pi*sqrt(L*C));
fcReal = 1/(2*pi*sqrt(Lreal*Creal));
erroFc = abs(fcReal-fcTeorica)/fcTeorica*100;

%% Resultados

fprintf('\n================ RESULTADOS ================\n');
fprintf('\nCOMPONENTES TEÓRICOS\n');
fprintf('L = %.3f mH\n',L*1000);
fprintf('C = %.3f uF\n',C*1e6);

fprintf('\nCOMPONENTES COMERCIAIS\n');
fprintf('L = %.3f mH\n',Lreal*1000);
fprintf('C = %.3f uF\n',Creal*1e6);

fprintf('\nDIFERENÇA DOS COMPONENTES\n');
fprintf('L = %.3f mH\n',difL*1000);
fprintf('C = %.3f uF\n',difC*1e6);

fprintf('\nERRO DOS COMPONENTES\n');
fprintf('Erro em L = %.2f %%\n',erroL);
fprintf('Erro em C = %.2f %%\n',erroC);

fprintf('\nFREQUÊNCIA DE CORTE\n');
fprintf('Teórica    = %.2f Hz\n',fcTeorica);
fprintf('Comercial  = %.2f Hz\n',fcReal);
fprintf('Erro       = %.2f %%\n',erroFc);


%% Filtro passa-baixas

numLP = [1/(L*C)];
denLP = [1 1/(R*C) 1/(L*C)];
HLP = tf(numLP,denLP);

numLP_real = [1/(Lreal*Creal)];
denLP_real = [1 1/(R*Creal) 1/(Lreal*Creal)];
HLP_real = tf(numLP_real,denLP_real);


%% Filtro passa-altas

numHP = [1 0 0];
denHP = [1 1/(R*C) 1/(L*C)];
HHP = tf(numHP,denHP);

numHP_real = [1 0 0];
denHP_real = [1 1/(R*Creal) 1/(Lreal*Creal)];
HHP_real = tf(numHP_real,denHP_real);

%% Diagrama de Bode do filtro passa-baixas

figure
bode(HLP,HLP_real)
grid on
legend('Teórica','Comercial')
title('Filtro Passa-Baixas Butterworth')

%% Diagrama de Bode do filtro passa-altas

figure
bode(HHP,HHP_real)
grid on
legend('Teórica','Comercial')
title('Filtro Passa-Altas Butterworth')