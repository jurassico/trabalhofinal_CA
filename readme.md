# Projeto de Filtros Passivos - Circuitos em Corrente Alternada
**Júlia Emanuelle Ulrich** -- Engenharia de Computação

## Sobre o Projeto
Este repositório contém o projeto de um crossover passivo para uma caixa de som de duas vias, composta por um woofer (para baixas frequências) e um tweeter (para altas frequências). O objetivo do projeto é separar e direcionar as frequências corretas para cada transdutor, garantindo máxima fidelidade de áudio e a proteção dos componentes operacionais.

Para realizar essa separação, foram projetados e implementados dois filtros de 2ª ordem com resposta do tipo Butterworth:
* **Filtro Passa-Baixas (LPF):** Permite a passagem dos sinais graves, direcionando-os ao woofer.
* **Filtro Passa-Altas (HPF):** Permite a passagem dos sinais agudos, direcionando-os ao tweeter.

## Especificações do Projeto
Os parâmetros base utilizados para o cálculo dos componentes foram:
* **Frequência de Corte ($f_c$):** **2000 Hz**
* **Impedância de Carga ($R$):** **8 Ω**
* **Fator de Qualidade ($Q$):** $\frac{\sqrt{2}}{2} \approx 0.7071$ (característico do filtro Butterworth).

## Equacionamento e Fórmulas de Projeto
Abaixo, detalha-se o passo a passo da obtenção das funções de transferência e das fórmulas finais de projeto, baseando-se na análise de impedâncias no domínio da frequência.

### 1. Filtro Passa-Baixas (Woofer) - 2ª Ordem
A topologia do filtro passa-baixas consiste em um indutor ($L$) em série e um capacitor ($C$) em paralelo com a carga ($R$). 

*(Esquema elétrico do Filtro Passa-Baixas)* *![Esquema Passa-Baixas](C:\Users\jubs\Downloads\passabaixas.png)*

As impedâncias de cada elemento são definidas como:
* $Z_R = R$
* $Z_L = j\omega L$
* $Z_C = \frac{1}{j\omega C}$

A impedância equivalente ($Z_p$) do ramo paralelo (capacitor e carga) é dada por:

$$Z_p = Z_C // R = \frac{Z_C \cdot R}{Z_C + R} = \frac{(1/j\omega C) \cdot R}{(1/j\omega C) + R} \cdot \left(\frac{j\omega C}{j\omega C}\right)$$

$$Z_p = \frac{R}{1 + j\omega C R}$$

Aplicando a regra do divisor de tensão, a função de transferência $H(j\omega)$ resulta em:

$$H(j\omega) = \frac{V_{saida}}{V_{entrada}} = \frac{Z_p}{Z_L + Z_p}$$

Substituindo $Z_p$ e $Z_L$ e manipulando algebricamente a equação:

$$H(j\omega) = \frac{\frac{R}{1 + j\omega C R}}{j\omega L + \frac{R}{1 + j\omega C R}} \cdot \left(\frac{1 + j\omega C R}{1 + j\omega C R}\right)$$

$$H(j\omega) = \frac{R}{j\omega L (1 + j\omega C R) + R} = \frac{R}{j\omega L + (j\omega)^2 L C R + R}$$

Para obter a forma canônica, divide-se o numerador e o denominador por $R$:

$$H(j\omega) = \frac{R/R}{\frac{j\omega L}{R} + \frac{(j\omega)^2 L C R}{R} + \frac{R}{R}} = \frac{1}{1 + j\omega \frac{L}{R} + (j\omega)^2 L C}$$

E, em seguida, divide-se os termos por $LC$:

$$H(j\omega) = \frac{1/LC}{\frac{1}{LC} + j\omega \frac{L/R}{LC} + \frac{(j\omega)^2 LC}{LC}} = \frac{1/LC}{(j\omega)^2 + j\omega \frac{1}{CR} + 1/LC}$$

Comparando com a equação padrão do filtro passa-baixas de 2ª ordem:

$$H(j\omega) = \frac{\omega_c^2}{(j\omega)^2 + \frac{\omega_c}{Q}(j\omega) + \omega_c^2}$$

Extraem-se as seguintes relações para o Passa-Baixas:

**1)** $\omega_c^2 = \frac{1}{LC} \Rightarrow \omega_c = \frac{1}{\sqrt{LC}}$

**2)** $\frac{\omega_c}{Q} = \frac{1}{CR} \Rightarrow C = \frac{Q}{\omega_c R}$

---

### 2. Filtro Passa-Altas (Tweeter) - 2ª Ordem
A topologia do filtro passa-altas utiliza um capacitor ($C$) em série e um indutor ($L$) em paralelo com a carga ($R$).

*(Esquema elétrico do Filtro Passa-Altas)* *![Esquema Passa-Altas](caminho/para/imagem_passa_altas.png)*

A impedância do ramo paralelo ($Z_p$) formado pelo indutor e a carga é:

$$Z_p = Z_L // R = \frac{Z_L \cdot R}{Z_L + R} = \frac{j\omega L \cdot R}{j\omega L + R}$$

Aplicando o divisor de tensão:

$$H(j\omega) = \frac{V_{saida}}{V_{entrada}} = \frac{Z_p}{Z_C + Z_p}$$

$$H(j\omega) = \frac{\frac{j\omega L R}{j\omega L + R}}{\frac{1}{j\omega C} + \frac{j\omega L R}{j\omega L + R}}$$

Manipulando a equação:

$$H(j\omega) = \frac{j\omega L R}{\frac{j\omega L + R}{j\omega C} + j\omega L R} \cdot \left(\frac{j\omega C}{j\omega C}\right)$$

$$H(j\omega) = \frac{(j\omega)^2 L C R}{R + j\omega L + (j\omega)^2 L C R}$$

Dividindo o numerador e o denominador por $R$:

$$H(j\omega) = \frac{(j\omega)^2 L C}{1 + j\omega \frac{L}{R} + (j\omega)^2 L C}$$

E, posteriormente, dividindo por $LC$:

$$H(j\omega) = \frac{(j\omega)^2}{\frac{1}{LC} + j\omega \frac{1}{CR} + (j\omega)^2} = \frac{(j\omega)^2}{(j\omega)^2 + j\omega \frac{1}{CR} + 1/LC}$$

Comparando com a forma padrão do filtro passa-altas de 2ª ordem:

$$H(j\omega) = \frac{(j\omega)^2}{(j\omega)^2 + \frac{\omega_c}{Q}(j\omega) + \omega_c^2}$$

Verifica-se que as relações extraídas são idênticas às do Passa-Baixas:

**1)** $\omega_c^2 = \frac{1}{LC} \Rightarrow \omega_c = \frac{1}{\sqrt{LC}}$

**2)** $\frac{\omega_c}{Q} = \frac{1}{CR} \Rightarrow C = \frac{Q}{\omega_c R}$

---

### 3. Fórmulas de Projeto (Cálculo de L e C)
Conforme demonstrado pelas deduções algébricas, as equações características para os componentes são as mesmas para ambas as topologias. Sabendo que em um filtro Butterworth o fator de qualidade é $Q = \frac{\sqrt{2}}{2}$:

**Cálculo do Capacitor ($C$):**
Substituindo $Q$ na relação $C = \frac{Q}{\omega_c R}$:
$$C = \frac{\frac{\sqrt{2}}{2}}{\omega_c R} \Rightarrow C = \frac{\sqrt{2}}{2 \omega_c R}$$

**Cálculo do Indutor ($L$):**
Isolando $L$ da equação $\omega_c^2 = \frac{1}{LC}$:
$$L = \frac{1}{\omega_c^2 C}$$

Substituindo a fórmula de $C$ deduzida anteriormente:
$$L = \frac{1}{\omega_c^2 \left(\frac{Q}{\omega_c R}\right)} = \frac{R}{\omega_c Q}$$

Substituindo o valor de $Q = \frac{\sqrt{2}}{2}$:
$$L = \frac{R}{\omega_c \left(\frac{\sqrt{2}}{2}\right)} = \frac{2R}{\sqrt{2} \omega_c} \Rightarrow L = \frac{\sqrt{2} R}{\omega_c}$$

---

## Lógica e Funcionamento do Código
O programa computacional foi desenvolvido em ambiente MATLAB/Octave. O fluxo lógico de execução opera da seguinte maneira:
1. **Entrada de Dados:** O sistema solicita ao usuário a inserção dos parâmetros de Impedância ($R$) e Frequência de Corte ($f_c$).
2. **Cálculo Teórico:** O algoritmo utiliza as fórmulas deduzidas matematicamente para calcular os valores ideais exatos do indutor e do capacitor.
3. **Busca de Valores Comerciais:** Considerando a indisponibilidade de componentes com valores fracionários arbitrários, o algoritmo realiza uma busca em vetores predefinidos (série comercial E) e utiliza a função `min(abs())` para selecionar as peças reais que mais se aproximam do cálculo teórico.
4. **Análise de Erro:** O código quantifica a diferença percentual entre os componentes teóricos e comerciais, calculando também o impacto desse desvio na frequência de corte real do circuito.
5. **Geração de Gráficos:** Utiliza-se a função `tf` para instanciar as funções de transferência teóricas e reais, e o comando `bode()` para gerar os diagramas comparativos.

## Análise dos Resultados
*(Insira a imagem do seu gráfico de simulação aqui substituindo esta linha por: `![Gráfico de Bode](caminho/para/imagem_bode.png)`)*

Abaixo, apresenta-se o comparativo de uma simulação utilizando $R$ = **8 Ω** e $f_c$ = **2000 Hz**:

| Parâmetro | Valor Ideal | Valor Comercial | Erro (%) |
| :--- | :--- | :--- | :--- |
| **Indutor ($L$)** | **0.900 mH** | **0.820 mH** | **8.89%** |
| **Capacitor ($C$)** | **7.030 µF** | **6.800 µF** | **3.27%** |
| **Freq. Corte ($f_c$)**| **2000 Hz** | **2129.57 Hz** | **6.48%** |

## Discussão e Análise Crítica
O principal desafio prático na implementação de filtros passivos reside na restrição imposta pelos valores comerciais de componentes. Valores calculados teoricamente (como **0.900 mH** e **7.030 µF**) raramente estão disponíveis no mercado. A aproximação para os componentes padronizados mais próximos causou um deslocamento da frequência de corte de **2000 Hz** para **2129.57 Hz**, caracterizando um erro de **6.48%**.

Em um contexto de projeto de áudio, no entanto, essa variação não compromete o desempenho do sistema. A alteração afeta uma estreita faixa de aproximadamente 130 Hz na região de transição (crossover), sendo uma divergência praticamente imperceptível à audição humana. Adicionalmente, as próprias tolerâncias de fabricação dos alto-falantes e suas curvas naturais de resposta tendem a atenuar e mascarar variações sutis geradas pelos filtros.

## Conclusões
O projeto cumpriu satisfatoriamente seus objetivos fundamentais. O equacionamento matemático para o dimensionamento dos filtros Butterworth de 2ª ordem foi estruturado e validado com sucesso, enquanto a ferramenta computacional otimizou o processo de simulação e comparação analítica.

A etapa prática do projeto evidencia que, embora o equacionamento teórico forneça as diretrizes exatas de funcionamento, a engenharia de hardware exige a adaptação perante limitações físicas e mercadológicas. O uso de valores padronizados demonstrou ser uma solução viável e eficaz, garantindo o funcionamento correto do circuito divisor de frequências sem perdas significativas de integridade no sistema final.