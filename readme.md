# Projeto de Filtros Passivos - Circuitos em Corrente Alternada
**Júlia Emanuelle Ulrich** -- Engenharia de Computação

## Sobre o Projeto
Este repositório contém o projeto de um crossover passivo para uma caixa de som de duas vias, composta por um woofer (para baixas frequências) e um tweeter (para altas frequências). O objetivo do projeto é separar e direcionar as frequências certas para cada alto-falante, garantindo uma boa qualidade de áudio e protegendo os componentes.

Para fazer essa separação, projetei e implementei dois filtros de 2ª ordem com resposta Butterworth:
* **Filtro Passa-Baixas (LPF):** Deixa passar os sinais graves e manda direto para o woofer.
* **Filtro Passa-Altas (HPF):** Deixa passar os sinais agudos e manda para o tweeter.

## Especificações do Projeto
Os parâmetros base usados para o cálculo dos componentes foram:
* **Frequência de Corte ($f_c$):** **2000 Hz**
* **Impedância de Carga ($R$):** **8 Ω**
* **Fator de Qualidade ($Q$):** $\frac{\sqrt{2}}{2} \approx 0.7071$ (característico do filtro Butterworth).

## Equacionamento e Fórmulas de Projeto
Abaixo mostro o passo a passo de como cheguei nas funções de transferência e nas fórmulas finais usando a análise de impedâncias no domínio da frequência.

### 1. Filtro Passa-Baixas (Woofer) - 2ª Ordem
O circuito do filtro passa-baixas é composto por um indutor ($L$) em série e um capacitor ($C$) em paralelo com a carga ($R$). 

*(Circuito do Filtro Passa-Baixas)* *![Circuito Passa-Baixas](passabaixas.png)*

As impedâncias de cada elemento são definidas como:
* $Z_R = R$
* $Z_L = j\omega L$
* $Z_C = \frac{1}{j\omega C}$

A impedância equivalente ($Z_p$) do ramo paralelo (capacitor e carga) é:

$$Z_p = Z_C // R = \frac{Z_C \cdot R}{Z_C + R} = \frac{(1/j\omega C) \cdot R}{(1/j\omega C) + R} \cdot \left(\frac{j\omega C}{j\omega C}\right)$$

$$Z_p = \frac{R}{1 + j\omega C R}$$

Aplicando a regra do divisor de tensão, a função de transferência $H(j\omega)$ fica assim:

$$H(j\omega) = \frac{V_{saida}}{V_{entrada}} = \frac{Z_p}{Z_L + Z_p}$$

Substituindo $Z_p$ e $Z_L$ e dando uma ajeitada na equação:

$$H(j\omega) = \frac{\frac{R}{1 + j\omega C R}}{j\omega L + \frac{R}{1 + j\omega C R}} \cdot \left(\frac{1 + j\omega C R}{1 + j\omega C R}\right)$$

$$H(j\omega) = \frac{R}{j\omega L (1 + j\omega C R) + R} = \frac{R}{j\omega L + (j\omega)^2 L C R + R}$$

Para chegar no formato padrão, dividimos o numerador e o denominador por $R$:

$$H(j\omega) = \frac{R/R}{\frac{j\omega L}{R} + \frac{(j\omega)^2 L C R}{R} + \frac{R}{R}} = \frac{1}{1 + j\omega \frac{L}{R} + (j\omega)^2 L C}$$

E, em seguida, dividimos os termos por $LC$:

$$H(j\omega) = \frac{1/LC}{\frac{1}{LC} + j\omega \frac{L/R}{LC} + \frac{(j\omega)^2 LC}{LC}} = \frac{1/LC}{(j\omega)^2 + j\omega \frac{1}{CR} + 1/LC}$$

Comparando com a equação padrão do filtro passa-baixas de 2ª ordem:

$$H(j\omega) = \frac{\omega_c^2}{(j\omega)^2 + \frac{\omega_c}{Q}(j\omega) + \omega_c^2}$$

A partir disso, chegamos nas seguintes relações para o Passa-Baixas:

**1)** $\omega_c^2 = \frac{1}{LC} \Rightarrow \omega_c = \frac{1}{\sqrt{LC}}$

**2)** $\frac{\omega_c}{Q} = \frac{1}{CR} \Rightarrow C = \frac{Q}{\omega_c R}$

---

### 2. Filtro Passa-Altas (Tweeter) - 2ª Ordem
O circuito do filtro passa-altas utiliza um capacitor ($C$) em série e um indutor ($L$) em paralelo com a carga ($R$).

*(Circuito do Filtro Passa-Altas)* *![Circuito Passa-Altas](passaaltas.png)*

A impedância do ramo paralelo ($Z_p$) formado pelo indutor e a carga é:

$$Z_p = Z_L // R = \frac{Z_L \cdot R}{Z_L + R} = \frac{j\omega L \cdot R}{j\omega L + R}$$

Aplicando o divisor de tensão:

$$H(j\omega) = \frac{V_{saida}}{V_{entrada}} = \frac{Z_p}{Z_C + Z_p}$$

$$H(j\omega) = \frac{\frac{j\omega L R}{j\omega L + R}}{\frac{1}{j\omega C} + \frac{j\omega L R}{j\omega L + R}}$$

Manipulando a equação:

$$H(j\omega) = \frac{j\omega L R}{\frac{j\omega L + R}{j\omega C} + j\omega L R} \cdot \left(\frac{j\omega C}{j\omega C}\right)$$

$$H(j\omega) = \frac{(j\omega)^2 L C R}{R + j\omega L + (j\omega)^2 L C R}$$

Para chegar no formato padrão, dividimos o numerador e o denominador por $R$:

$$H(j\omega) = \frac{(j\omega)^2 L C}{1 + j\omega \frac{L}{R} + (j\omega)^2 L C}$$

E, em seguida, dividimos os termos por $LC$:

$$H(j\omega) = \frac{(j\omega)^2}{\frac{1}{LC} + j\omega \frac{1}{CR} + (j\omega)^2} = \frac{(j\omega)^2}{(j\omega)^2 + j\omega \frac{1}{CR} + 1/LC}$$

Comparando com a forma padrão do filtro passa-altas de 2ª ordem:

$$H(j\omega) = \frac{(j\omega)^2}{(j\omega)^2 + \frac{\omega_c}{Q}(j\omega) + \omega_c^2}$$

A partir disso, obtemos relações idênticas às do Passa-Baixas:

**1)** $\omega_c^2 = \frac{1}{LC} \Rightarrow \omega_c = \frac{1}{\sqrt{LC}}$

**2)** $\frac{\omega_c}{Q} = \frac{1}{CR} \Rightarrow C = \frac{Q}{\omega_c R}$

---

### 3. Fórmulas de Projeto (Cálculo de L e C)
Como deu para ver nas contas ali em cima, as equações dos componentes são as mesmas para os dois circuitos. Sabendo que em um filtro Butterworth o fator de qualidade é $Q = \frac{\sqrt{2}}{2}$:

**Cálculo do Capacitor ($C$):**
Substituindo $Q$ na relação $C = \frac{Q}{\omega_c R}$:
$$C = \frac{\frac{\sqrt{2}}{2}}{\omega_c R} \Rightarrow C = \frac{\sqrt{2}}{2 \omega_c R}$$

**Cálculo do Indutor ($L$):**
Isolando $L$ da equação $\omega_c^2 = \frac{1}{LC}$:
$$L = \frac{1}{\omega_c^2 C}$$

Substituindo a fórmula de $C$ que achamos antes:
$$L = \frac{1}{\omega_c^2 \left(\frac{Q}{\omega_c R}\right)} = \frac{R}{\omega_c Q}$$

Substituindo o valor de $Q = \frac{\sqrt{2}}{2}$:
$$L = \frac{R}{\omega_c \left(\frac{\sqrt{2}}{2}\right)} = \frac{2R}{\sqrt{2} \omega_c} \Rightarrow L = \frac{\sqrt{2} R}{\omega_c}$$

---

## Metodologia e Escolha dos Componentes
O processo de dimensionamento dos filtros seguiu os seguintes passos:
1. Definição dos parâmetros iniciais: Impedância ($R$) e Frequência de Corte ($f_c$).
2. Uso das fórmulas deduzidas para encontrar os valores matemáticos exatos do indutor e do capacitor.
3. Como não é possível encontrar componentes com esses valores exatos no mercado, foi feita uma busca na tabela de valores comerciais padronizados para escolher as peças mais próximas.
4. Cálculo da diferença de erro (%) para avaliar o quanto a frequência de corte se deslocaria na prática com essas peças reais.

## Análise dos Resultados
*(Insira a imagem do seu gráfico de simulação aqui substituindo esta linha por: `![Gráfico de Bode](grafico.png)`)*

Abaixo apresento o comparativo considerando os cálculos para $R$ = **8 Ω** e $f_c$ = **2000 Hz**:

* Para o **Indutor ($L$)**, o valor ideal calculado foi de **0.900 mH**, mas o comercial mais próximo escolhido foi de **0.820 mH** (erro de **8.89%**).
* Para o **Capacitor ($C$)**, o valor ideal era **7.030 µF**, e o comercial usado foi **6.800 µF** (erro de **3.27%**).
* Com essa troca de peças, a **Frequência de Corte ($f_c$)** real do circuito mudou de **2000 Hz** para **2129.57 Hz** (erro de **6.48%**).

## Discussão e Problemas Encontrados
O principal desafio prático na montagem de filtros passivos é que os valores teóricos raramente estão disponíveis para compra. O arredondamento para os componentes comerciais mais próximos deslocou a nossa frequência de corte de **2000 Hz** para **2129.57 Hz**, gerando um erro de **6.48%**.

Em um sistema de áudio, no entanto, essa diferença não chega a comprometer o funcionamento. A alteração ocorre em uma faixa de aproximadamente 130 Hz na região de transição, sendo praticamente imperceptível na prática. Além disso, as próprias variações de fabricação e as curvas de resposta dos alto-falantes ajudam a mascarar esses pequenos desvios do filtro.

## Conclusões
O projeto cumpriu seu objetivo. Foi possível estruturar e validar o equacionamento dos filtros Butterworth de 2ª ordem a partir da análise de circuitos.

A etapa prática demonstra que, embora a teoria forneça números exatos, a montagem de um circuito real exige adaptação aos componentes disponíveis no mercado. O uso de valores padronizados provou ser uma solução eficaz, garantindo o funcionamento correto do projeto sem prejudicar a qualidade final do áudio.
