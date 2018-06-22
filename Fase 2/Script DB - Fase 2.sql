
CREATE TABLE Usuario_común (
  Cod_usuario_común SERIAL PRIMARY KEY  NOT NULL,
  Credencial VARCHAR(50) NOT NULL
);

CREATE TABLE Administrador_sistema (
  Cod_administrador_sistema SERIAL NOT NULL,
  Credencial VARCHAR(50) NOT NULL,
  PRIMARY KEY (Cod_administrador_sistema));

CREATE TABLE Contratante (
  Cod_contratante SERIAL NOT NULL,
  Nombre VARCHAR(50) NOT NULL,
  DPI INT NOT NULL,
  PRIMARY KEY (Cod_contratante));

CREATE TABLE Administrador_servicio (
  Cod_administrador_servicio SERIAL NOT NULL,
  Credencial VARCHAR(50) NOT NULL,
  Cod_contratante INT NOT NULL,
  PRIMARY KEY (Cod_administrador_servicio),
  CONSTRAINT Cod_contratante
    FOREIGN KEY (Cod_contratante)
    REFERENCES Contratante (Cod_contratante)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Usuario (
  Cod_usuario SERIAL NOT NULL,
  Nombre VARCHAR(50) NOT NULL,
  Apellido VARCHAR(50) NOT NULL,
  Nickname VARCHAR(50) NOT NULL,
  Contraseña VARCHAR(50) NOT NULL,
  Cod_administrador_sistema INT NULL,
  Cod_administrador_servicio INT NULL,
  Cod_usuario_común INT NULL,
  PRIMARY KEY (Cod_usuario),
  CONSTRAINT Cod_usuario_común
    FOREIGN KEY (Cod_usuario_común)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_administrador_sistema
    FOREIGN KEY (Cod_administrador_servicio)
    REFERENCES Administrador_sistema (Cod_administrador_sistema)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT Cod_administrador_servicio
    FOREIGN KEY (Cod_administrador_servicio)
    REFERENCES Administrador_servicio (Cod_administrador_servicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


CREATE TABLE Módulo (
  Cod_módulo SERIAL NOT NULL,
  Nombre VARCHAR(50) NOT NULL,
  Demanda INT NOT NULL,
  Costo FLOAT8 NOT NULL,
  Habilitado INT NOT NULL,
  Mensaje VARCHAR(100) NULL,
  PRIMARY KEY (Cod_módulo));

CREATE TABLE Contratante_módulo (
  Cod_contratante_módulo SERIAL NOT NULL,
  Cod_contratante INT NOT NULL,
  Cod_módulo INT NOT NULL,
  Número_usuarios INT NOT NULL,
  PRIMARY KEY (Cod_contratante_módulo),
  CONSTRAINT Cod_contratante
    FOREIGN KEY (Cod_contratante)
    REFERENCES Contratante (Cod_contratante)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_módulo
    FOREIGN KEY (Cod_módulo)
    REFERENCES Módulo (Cod_módulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Pago (
  Cod_pago SERIAL NOT NULL,
  Descripción VARCHAR(100) NOT NULL,
  Total FLOAT8 NOT NULL,
  Pago_realizado INT NOT NULL,
  Cod_contratante INT NOT NULL,
  PRIMARY KEY (Cod_pago),
  CONSTRAINT Cod_contratante
    FOREIGN KEY (Cod_contratante)
    REFERENCES Contratante (Cod_contratante)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


CREATE TABLE Tarjeta (
  Cod_tarjeta SERIAL NOT NULL,
  Tipo_tarjeta VARCHAR(45) NOT NULL,
  Número_tarjeta INT NOT NULL,
  Fecha_caducidad DATE NOT NULL,
  Código_seguridad INT NOT NULL,
  Cod_contratante INT NOT NULL,
  PRIMARY KEY (Cod_tarjeta),
  CONSTRAINT Cod_contratante
    FOREIGN KEY (Cod_contratante)
    REFERENCES Contratante (Cod_contratante)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Producto (
  Cod_producto SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Cantidad INT NOT NULL,
  Cod_materia_prima INT NULL,
  PRIMARY KEY (Cod_producto),
  CONSTRAINT Cod_materia_prima
    FOREIGN KEY (Cod_materia_prima)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE 
    ON UPDATE CASCADE);

CREATE TABLE Cliente (
  Cod_cliente SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cod_cliente));

CREATE TABLE Venta (
  Cod_venta SERIAL NOT NULL,
  Importe_total FLOAT8 NOT NULL,
  Fecha DATE NOT NULL,
  Cod_cliente INT NOT NULL,
  Cod_vendedor INT NOT NULL,
  Descuento FLOAT8 NOT NULL,
  PRIMARY KEY (Cod_venta),
  CONSTRAINT Cod_cliente
    FOREIGN KEY (Cod_cliente)
    REFERENCES Cliente (Cod_cliente)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT Cod_vendedor
    FOREIGN KEY (Cod_vendedor)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE 
    ON UPDATE CASCADE);

CREATE TABLE Venta_producto (
  Cod_venta_producto SERIAL NOT NULL,
  Cantidad_producto INT NOT NULL,
  Cod_venta INT NOT NULL,
  Cod_producto INT NOT NULL,
  PRIMARY KEY (Cod_venta_producto),
  CONSTRAINT Cod_venta
    FOREIGN KEY (Cod_venta)
    REFERENCES Venta (Cod_venta)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT Cod_producto
    FOREIGN KEY (Cod_producto)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Proveedor (
  Cod_proveedor SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cod_proveedor));

CREATE TABLE Compra (
  Cod_compra SERIAL NOT NULL,
  Fecha_pedido DATE NOT NULL,
  Fecha_recibido DATE NOT NULL,
  Número_factura INT NOT NULL,
  Importe_total FLOAT8 NOT NULL,
  Cod_proveedor INT NOT NULL,
  PRIMARY KEY (Cod_compra),
  CONSTRAINT Cod_proveedor
    FOREIGN KEY (Cod_proveedor)
    REFERENCES Proveedor (Cod_proveedor)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Factura (
  Cod_factura SERIAL NOT NULL,
  Correlativo INT NOT NULL,
  Fecha DATE NOT NULL,
  Hora TIME NOT NULL,
  Importe_total FLOAT8 NOT NULL,
  Impuesto FLOAT8 NOT NULL,
  Cod_cliente INT NOT NULL,
  Cod_vendedor INT NOT NULL,
  PRIMARY KEY (Cod_factura),
  CONSTRAINT Cod_cliente
    FOREIGN KEY (Cod_cliente)
    REFERENCES Cliente (Cod_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_vendedor
    FOREIGN KEY (Cod_vendedor)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Factura_producto (
  Cod_factura_producto SERIAL NOT NULL,
  Cod_factura INT NOT NULL,
  Cod_producto INT NOT NULL,
  PRIMARY KEY (Cod_factura_producto),
  CONSTRAINT Cod_factura
    FOREIGN KEY (Cod_factura)
    REFERENCES Factura (Cod_factura)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_producto
    FOREIGN KEY (Cod_producto)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Compra_producto (
  Cod_compra_producto SERIAL NOT NULL,
  Cod_compra INT NOT NULL,
  Cod_producto INT NOT NULL,
  PRIMARY KEY (Cod_compra_producto),
  CONSTRAINT Cod_compra
    FOREIGN KEY (Cod_compra)
    REFERENCES Compra (Cod_compra)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_producto
    FOREIGN KEY (Cod_producto)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Puesto (
  Cod_puesto SERIAL NOT NULL,
  Ocupación CHAR(1) NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (Cod_puesto));

CREATE TABLE Personal (
  Cod_personal SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  DPI INT NOT NULL,
  NIT VARCHAR(45) NOT NULL,
  Cod_puesto INT NOT NULL,
  Cod_usuario_común INT NOT NULL,
  PRIMARY KEY (Cod_personal),
  CONSTRAINT Cod_usuario_común
    FOREIGN KEY (Cod_usuario_común)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_puesto
    FOREIGN KEY (Cod_puesto)
    REFERENCES Puesto (Cod_puesto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Viaje (
  Cod_viaje SERIAL NOT NULL,
  Fecha_salida DATE NOT NULL,
  Fecha_llegada DATE NOT NULL,
  Distancia FLOAT8 NOT NULL,
  PRIMARY KEY (Cod_viaje));

CREATE TABLE Piloto (
  Cod_piloto SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  DPI INT NOT NULL,
  Cod_viaje INT NOT NULL,
  Cod_usuario_común INT NOT NULL,
  PRIMARY KEY (Cod_piloto),
  CONSTRAINT Cod_viaje
    FOREIGN KEY (Cod_viaje)
    REFERENCES Viaje (Cod_viaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_usuario_común
    FOREIGN KEY (Cod_usuario_común)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Vehículo (
  Cod_vehículo SERIAL NOT NULL,
  Marca VARCHAR(45) NOT NULL,
  Placa VARCHAR(45) NOT NULL,
  Modelo VARCHAR(45) NOT NULL,
  Cod_piloto INT NOT NULL,
  PRIMARY KEY (Cod_vehículo),
  CONSTRAINT Cod_piloto
    FOREIGN KEY (Cod_piloto)
    REFERENCES Piloto (Cod_piloto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Acompañante (
  Cod_acompañante SERIAL NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  DPI INT NOT NULL,
  Cod_viaje INT NOT NULL,
  Cod_usuario_común INT NOT NULL,
  PRIMARY KEY (Cod_acompañante),
  CONSTRAINT Cod_viaje
    FOREIGN KEY (Cod_viaje)
    REFERENCES Viaje (Cod_viaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_usuario_común
    FOREIGN KEY (Cod_usuario_común)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Viaje_producto (
  Cod_viaje_producto SERIAL NOT NULL,
  Cod_viaje INT NOT NULL,
  Cod_producto INT NOT NULL,
  PRIMARY KEY (Cod_viaje_producto),
  CONSTRAINT Cod_viaje
    FOREIGN KEY (Cod_viaje)
    REFERENCES Viaje (Cod_viaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_producto
    FOREIGN KEY (Cod_producto)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Noticia (
  Cod_noticia SERIAL NOT NULL,
  Título VARCHAR(45) NOT NULL,
  Contenido VARCHAR(45) NOT NULL,
  Cod_administrador_servicio INT NOT NULL,
  PRIMARY KEY (Cod_noticia),
  CONSTRAINT Cod_administrador_servicio
    FOREIGN KEY (Cod_administrador_servicio)
    REFERENCES Administrador_servicio (Cod_administrador_servicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Comentario (
  Cod_comentario SERIAL NOT NULL,
  Contenido VARCHAR(45) NOT NULL,
  Cod_ususario_común INT NOT NULL,
  Cod_noticia INT NOT NULL,
  PRIMARY KEY (Cod_comentario),
  CONSTRAINT Cod_usuario_común
    FOREIGN KEY (Cod_ususario_común)
    REFERENCES Usuario_común (Cod_usuario_común)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT Cod_noticia
    FOREIGN KEY (Cod_noticia)
    REFERENCES Noticia (Cod_noticia)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Evento (
  Cod_evento SERIAL NOT NULL,
  Contenido VARCHAR(45) NOT NULL,
  Estado VARCHAR(45) NOT NULL,
  Fecha VARCHAR(45) NOT NULL,
  Cod_administrador_servicio INT NOT NULL,
  PRIMARY KEY (Cod_evento),
  CONSTRAINT Cod_administrador_servicio
    FOREIGN KEY (Cod_administrador_servicio)
    REFERENCES Administrador_servicio (Cod_administrador_servicio)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Oportunidad (
  Cod_oportunidad SERIAL NOT NULL,
  Título VARCHAR(45) NOT NULL,
  Descripción VARCHAR(45) NOT NULL,
  Monto FLOAT8 NOT NULL,
  Prioridad INT NOT NULL,
  Cod_cliente INT NOT NULL,
  PRIMARY KEY (Cod_oportunidad),
  CONSTRAINT Cod_cliente
    FOREIGN KEY (Cod_cliente)
    REFERENCES Cliente (Cod_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Regla (
  Cod_regla SERIAL NOT NULL,
  Cant_mínima INT NOT NULL,
  Cant_max INT NOT NULL,
  Cod_producto INT NOT NULL,
  PRIMARY KEY (Cod_regla),
  CONSTRAINT Cod_producto
    FOREIGN KEY (Cod_producto)
    REFERENCES Producto (Cod_producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE Cita (
  Cod_cita SERIAL NOT NULL,
  Fecha DATE NOT NULL,
  Hora TIME NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Cod_puesto INT NOT NULL,
  PRIMARY KEY (Cod_cita),
  CONSTRAINT Cod_puesto
    FOREIGN KEY (Cod_puesto)
    REFERENCES Puesto (Cod_puesto)
    ON DELETE CASCADE
    ON UPDATE CASCADE);