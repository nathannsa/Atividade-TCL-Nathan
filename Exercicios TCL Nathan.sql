-- Exercicios Nathan Alves Salomão 4/12/24
-- **Exercício 1: Desativar o Autocommit, Inserir Professores e Efetuar o COMMIT**

-- Desabilitar o autocommit
SET autocommit = 0;

-- Inserir os novos professores na tabela 'professor'
INSERT INTO professor (nro_registro_professor, nome, codigo_disciplina) VALUES
('P011', 'Clara Almeida', 'D001'),  -- Aqui, 'D001' é um exemplo de código de disciplina
('P012', 'João Gomes', 'D002'),     -- 'D002' é o código para Elétrica, por exemplo
('P013', 'Fernando da Silva', 'D003'), -- 'D003' é para Mecânica
('P014', 'Bento Ramos', 'D002');    -- 'D002' para Elétrica novamente

-- Efetuar o COMMIT para salvar as inserções
COMMIT;


-- **Exercício 2: Alterar Dados de Professor e Excluir um Registro**

-- Atualizar o nome da professora Clara Almeida para "Clara de Almeida"
UPDATE professor
SET nome = 'Clara de Almeida'
WHERE nome = 'Clara Almeida' AND codigo_disciplina = 'D001'; -- Adapte o código da disciplina se necessário

-- Deletar o registro do professor Fernando da Silva
DELETE FROM professor
WHERE nome = 'Fernando da Silva' AND codigo_disciplina = 'D003'; -- Adapte o código da disciplina se necessário

-- Efetuar o COMMIT para salvar as alterações
COMMIT;


-- **Exercício 3: Criar um SAVEPOINT, Inserir Disciplinas, Atualizar e Excluir Registros**

-- Criar o SAVEPOINT chamado "savepoint_insert_disc"
SAVEPOINT savepoint_insert_disc;

-- Inserir 5 novas disciplinas na tabela 'disciplina'
INSERT INTO disciplina (codigo_disciplina, nome_disciplina, carga_horaria, descricao) VALUES
('D011', 'Matemática II', 60, 'Continuação de Matemática I'),
('D012', 'Física II', 60, 'Avanços em Física Moderna'),
('D013', 'Química II', 60, 'Continuação da Química Geral'),
('D014', 'Programação II', 80, 'Lógica de Programação Avançada'),
('D015', 'Estruturas de Dados', 40, 'Estruturas de Dados e Algoritmos Avançados');

-- Atualizar o nome da segunda disciplina (Física II), trocando a última letra
UPDATE disciplina
SET nome_disciplina = CONCAT(SUBSTRING(nome_disciplina, 1, LENGTH(nome_disciplina) - 1), 
                             IF(UPPER(RIGHT(nome_disciplina, 1)) = RIGHT(nome_disciplina, 1), 
                                LOWER(RIGHT(nome_disciplina, 1)), 
                                UPPER(RIGHT(nome_disciplina, 1))))
WHERE codigo_disciplina = 'D012';

-- Excluir o último registro inserido (Estruturas de Dados)
DELETE FROM disciplina
WHERE codigo_disciplina = 'D015';

-- ROLLBACK TO para desfazer as inserções até o SAVEPOINT
ROLLBACK TO SAVEPOINT savepoint_insert_disc;

-- Efetuar o COMMIT para salvar as mudanças restantes
COMMIT;
