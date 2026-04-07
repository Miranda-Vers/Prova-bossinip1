-- Enunciado 1 - Base de dados e criação de tabela

-- A base a ser utilizada pode ser obtida a partir do link a seguir.
-- https://www.kaggle.com/datasets/yasserh/titanic-dataset
-- Ela deve ser importada para uma base de dados gerenciada pelo PostgreSQL. Os dados
-- devem ser armazenados em uma tabela apropriada para as análises desejadas. Você deve
-- identificar as colunas necessárias, de acordo com a descrição de cada item da prova.
-- Além, é claro, de uma chave primária (de auto incremento). Neste item, portanto, você
-- deve desenvolver o script de criação da tabela.

-- Mensagem de commit: feat(p1): cria base e importa dados

CREATE Table titanic (
    PassegerID SERIAL PRIMARY KEY,
    Survived INTEGER,
    Pclase INTEGER,
    Nome VARCHAR(100),
    Sex VARCHAR(6),
    Fare DECIMAL(4,2),
    Embarked CHAR (1))


-- Enunciado 2 - Sobrevivência em função da classe social
-- Escreva um cursor não vinculado que mostra o número de passageiros sobreviventes que
-- viajavam na primeira classe (Pclass = 1).
-- Mensagem de commit: feat(p1): encontra sobreviventes da primeira classe

DO
$$
DECLARE
    cur_sobreviventes_p1 REFCURSOR;
    n_sobreviventes INTEGER;
BEGIN
    OPEN cur_sobreviventes_p1 FOR
        SELECT COUNT(PassegerID)
        FROM titanic
        WHERE Survived = 1 and Pclase = 1;
        FETCH cur_sobreviventes_p1 INTO n_sobreviventes;
        RAISE NOTICE 'O número de sobreviventes na 1ª classe é: %', n_sobreviventes;
    CLOSE cur_sobreviventes_p1;
END;
$$


-- Enunciado 3 - Sobrevivência em função do gênero
-- Escreva um cursor com query dinâmica que mostra o número de passageiros
-- sobreviventes dentre as mulheres (Sex = 'female'). Escreva um condicional para que, se
-- não existir nenhuma, o valor -1 seja exibido.
-- Mensagem de commit: feat(p1): encontra sobreviventes do sexo feminino

DO $$
DECLARE
    cur_mulheres_sobreviventes REFCURSOR;
    v_contagem INT;
    v_nome_tabela VARCHAR(200) := 'titanic';
BEGIN
    OPEN cur_mulheres_sobreviventes FOR EXECUTE
        format
            (
                '
            SELECT COUNT(*)
            FROM %s
            WHERE Sex = $1 AND Survived = $2
            ',
            v_nome_tabela
        )
        USING 'female', 1;
        FETCH cur_mulheres_sobreviventes INTO v_contagem;
       
        IF v_contagem = 0 THEN
         RAISE NOTICE '%', -1;
        ELSE
         RAISE NOTICE '%', v_contagem;
        END IF;
    CLOSE cur_mulheres_sobreviventes;
END;
$$

-- Enunciado 4 - Tarifa versus embarque
-- Dentre os passageiros que pagaram tarifa (Fare) maior que 50, quantos embarcaram em
-- Cherbourg (Embarked = 'C')? Escreva um cursor vinculado que exiba esse valor.
-- Mensagem de commit: feat(p1): encontra passageiros de Cherbourg com tarifa alta






-- Enunciado 5 Limpeza de valores NULL
-- Escreva um cursor não vinculado para a remoção de todas as tuplas que possuam o valor
-- NULL em pelo menos um de seus campos. Antes de fazer a sua remoção, exiba a tupla. A
-- seguir, mostre as tuplas remanescentes, de baixo para cima.
-- Mensagem de commit: feat(p1): remove com dados faltantes

