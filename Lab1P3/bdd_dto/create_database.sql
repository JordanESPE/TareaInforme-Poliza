-- Crear la base de datos para el proyecto de pólizas
CREATE DATABASE IF NOT EXISTS dbb_dto_poliza;

-- Usar la base de datos
USE dbb_dto_poliza;

-- Las tablas se crearán automáticamente con Hibernate (ddl-auto=update)
-- Pero aquí está la estructura esperada:

-- Tabla de Propietarios
-- CREATE TABLE IF NOT EXISTS propietario (
--     id BIGINT AUTO_INCREMENT PRIMARY KEY,
--     nombre_completo VARCHAR(255) NOT NULL,
--     edad INT NOT NULL
-- );

-- Tabla de Automóviles
-- CREATE TABLE IF NOT EXISTS automovil (
--     id BIGINT AUTO_INCREMENT PRIMARY KEY,
--     modelo VARCHAR(100) NOT NULL,
--     valor DOUBLE NOT NULL,
--     accidentes BOOLEAN NOT NULL,
--     propietario_id BIGINT,
--     FOREIGN KEY (propietario_id) REFERENCES propietario(id)
-- );

-- Tabla de Seguros
-- CREATE TABLE IF NOT EXISTS seguro (
--     id BIGINT AUTO_INCREMENT PRIMARY KEY,
--     costo_total DOUBLE NOT NULL,
--     automovil_id BIGINT,
--     FOREIGN KEY (automovil_id) REFERENCES automovil(id)
-- );

-- Verificar que la base de datos se creó
SELECT 'Base de datos dbb_dto_poliza creada exitosamente!' as mensaje;
