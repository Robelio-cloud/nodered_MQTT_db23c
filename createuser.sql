-- Criação do usuário nodered com senha nodered
CREATE USER C##nodered IDENTIFIED BY nodered;

-- Concessões de permissões básicas
GRANT CREATE SESSION TO C##nodered;
GRANT CREATE TABLE TO C##nodered;

-- Permitir uso de espaço em tablespace USERS
ALTER USER C##nodered QUOTA UNLIMITED ON USERS;

-- Tabela genérica para testes
CREATE TABLE C##nodered.nodered (
    col1 VARCHAR2(500),
    col2 VARCHAR2(500)
);

-- Tabela principal de sensores
CREATE TABLE C##nodered.sensor_data (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vibration NUMBER,
    temperature NUMBER,
    rpm NUMBER,
    current NUMBER,
    level NUMBER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Descomente para testes manuais:
-- INSERT INTO C##nodered.sensor_data (vibration, temperature, rpm, current, level) VALUES (0.98, 34.5, 1200, 4.2, 75.0);
-- SELECT COUNT(*) FROM C##nodered.sensor_data;

-- Finaliza a sessão
EXIT;
