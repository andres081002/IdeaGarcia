-- Crea la Base de Datos
CREATE DATABASE CafeteriaDB;

-- Crea la tabla Clientes
CREATE TABLE Clientes (
    cli_id INT AUTO_INCREMENT PRIMARY KEY, 
    cli_nom VARCHAR(100) NOT NULL,         
    cli_ape VARCHAR(100) NOT NULL,         
    cli_ema VARCHAR(150) UNIQUE NOT NULL,  
    cli_tel VARCHAR(20),                   
    cli_dir VARCHAR(255)                   
);

-- Crea un indice
CREATE INDEX IX_Clientes_Email ON Clientes (cli_ema);

-- Crea la tabla Productos
CREATE TABLE Productos (
    prod_id INT AUTO_INCREMENT PRIMARY KEY, 
    prod_nom VARCHAR(100) NOT NULL,         
    prod_des VARCHAR(500),                  
    prod_pre DECIMAL(10, 2) NOT NULL,       
    prod_dis BOOLEAN DEFAULT TRUE           
);

-- Crea la tabla Pedidos
CREATE TABLE Pedidos (
    ped_id INT AUTO_INCREMENT PRIMARY KEY,     
    cli_id INT NOT NULL,                      
    ped_fec DATETIME DEFAULT CURRENT_TIMESTAMP, 
    ped_tot DECIMAL(10, 2) NOT NULL,          
    ped_est VARCHAR(50) NOT NULL,            
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (cli_id) REFERENCES Clientes(cli_id)
);

-- Crea un índice
CREATE INDEX IX_Pedidos_ClienteID ON Pedidos (cli_id);

-- Crea la tabla DetallePedidos
CREATE TABLE DetallePedidos (
    dp_id INT AUTO_INCREMENT PRIMARY KEY, 
    ped_id INT NOT NULL,                   
    prod_id INT NOT NULL,                  
    dp_can INT NOT NULL,                   
    dp_sub DECIMAL(10, 2) NOT NULL,        
    CONSTRAINT FK_DetallePedidos_Pedidos FOREIGN KEY (ped_id) REFERENCES Pedidos(ped_id),
    CONSTRAINT FK_DetallePedidos_Productos FOREIGN KEY (prod_id) REFERENCES Productos(prod_id)
);

-- Crea un índice
CREATE INDEX IX_DetallePedidos_PedidoID ON DetallePedidos (ped_id);
CREATE INDEX IX_DetallePedidos_ProductoID ON DetallePedidos (prod_id);