CREATE DATABASE CafeteriaDB;

CREATE TABLE Clientes (
    cli_id INT IDENTITY(1,1) PRIMARY KEY, 
    cli_nom NVARCHAR(100) NOT NULL,       
    cli_ape NVARCHAR(100) NOT NULL,       
    cli_ema NVARCHAR(150) UNIQUE NOT NULL,
    cli_tel NVARCHAR(20),                 
    cli_dir NVARCHAR(255)                 
);

CREATE NONCLUSTERED INDEX IX_Clientes_Email ON Clientes (cli_ema);

CREATE TABLE Productos (
    prod_id INT IDENTITY(1,1) PRIMARY KEY, 
    prod_nom NVARCHAR(100) NOT NULL,       
    prod_des NVARCHAR(500),               
    prod_pre DECIMAL(10, 2) NOT NULL,     
    prod_dis BIT DEFAULT 1                 
);

CREATE TABLE Pedidos (
    ped_id INT IDENTITY(1,1) PRIMARY KEY,  
    cli_id INT NOT NULL,                     
    ped_fec DATETIME DEFAULT GETDATE(),     
    ped_tot DECIMAL(10, 2) NOT NULL,         
    ped_est NVARCHAR(50) NOT NULL,          
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (cli_id) REFERENCES Clientes(cli_id)
);

CREATE NONCLUSTERED INDEX IX_Pedidos_ClienteID ON Pedidos (cli_id);

CREATE TABLE DetallePedidos (
    dp_id INT IDENTITY(1,1) PRIMARY KEY,  
    ped_id INT NOT NULL,                   
    prod_id INT NOT NULL,                  
    dp_can INT NOT NULL,                   
    dp_sub DECIMAL(10, 2) NOT NULL,        
    CONSTRAINT FK_DetallePedidos_Pedidos FOREIGN KEY (ped_id) REFERENCES Pedidos(ped_id),
    CONSTRAINT FK_DetallePedidos_Productos FOREIGN KEY (prod_id) REFERENCES Productos(prod_id)
);

CREATE NONCLUSTERED INDEX IX_DetallePedidos_PedidoID ON DetallePedidos (ped_id);
CREATE NONCLUSTERED INDEX IX_DetallePedidos_ProductoID ON DetallePedidos (prod_id);

