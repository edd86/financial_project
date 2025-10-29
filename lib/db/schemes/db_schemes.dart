//TODO: Almacenar cobros por el servicio, Menu de usuarios, Estado de resultados

List<String> dbSchemes = [
  '''CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    rol TEXT NOT NULL,
    phone TEXT,
    password TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  );''',
  '''CREATE TABLE permissions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
  );''',
  '''CREATE TABLE user_permissions (
    user_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, permission_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(permission_id) REFERENCES permissions(id) ON DELETE CASCADE
  );''',
  '''CREATE TABLE simplified_regime (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_number TEXT NOT NULL,
    min_capital REAL NOT NULL DEFAULT 0.0,
    max_capital REAL NOT NULL DEFAULT 0.0,
    taxable_amount REAL NOT NULL DEFAULT 0.0,
    due_pattern TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  );''',
  '''CREATE TABLE general_regime (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    periodicity TEXT NOT NULL CHECK (periodicity IN ('mensual', 'bimestral', 'trimestral', 'semestral', 'anual')),
    percentage REAL NOT NULL DEFAULT 0.0,
    due_pattern TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  );''',
  '''CREATE TABLE clients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    business_name TEXT NOT NULL,
    tax_id TEXT NOT NULL UNIQUE,
    capital REAL NOT NULL DEFAULT 0.0,
    regime_type TEXT NOT NULL CHECK (regime_type IN ('simplificado', 'general')),
    activity TEXT CHECK (activity IN ('artesanias', 'minorista', 'vendedor') OR activity IS NULL),
    description TEXT,
    base_product_price REAL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  );''',
  '''CREATE TABLE monthly_business_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    record_month TEXT NOT NULL,
    record_year INTEGER NOT NULL,
    total_purchases REAL NOT NULL DEFAULT 0.0,
    purchase_discount REAL NOT NULL DEFAULT 0.0,
    purchase_invoice_count INTEGER NOT NULL DEFAULT 0,
    net_purchases REAL,
    gross_sales REAL NOT NULL DEFAULT 0.0,
    sales_discount REAL NOT NULL DEFAULT 0.0,
    sales_invoice_count INTEGER NOT NULL DEFAULT 0,
    net_sales REAL,
    taxable_income REAL,
    status TEXT NOT NULL DEFAULT 'borrador' CHECK (status IN ('borrador', 'confirmado', 'procesado')),
    notes TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE,
    UNIQUE(client_id, record_month)
  );''',
  '''CREATE TABLE client_obligations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    monthly_record_id INTEGER,
    obligation_type TEXT NOT NULL CHECK (obligation_type IN ('simplificado', 'general')),
    simplified_id INTEGER,
    general_id INTEGER,
    payment_amount REAL NOT NULL DEFAULT 0.0,
    applied_percentage REAL,
    taxable_base REAL,
    due_date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pendiente' CHECK (status IN ('pendiente', 'cumplido', 'vencido')),
    period_start TEXT NOT NULL,
    period_end TEXT NOT NULL,
    calculation_notes TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY(monthly_record_id) REFERENCES monthly_business_records(id) ON DELETE SET NULL,
    FOREIGN KEY(simplified_id) REFERENCES simplified_regime(id),
    FOREIGN KEY(general_id) REFERENCES general_regime(id),
    CHECK (
        (obligation_type = 'simplificado' AND simplified_id IS NOT NULL AND general_id IS NULL AND monthly_record_id IS NULL) OR
        (obligation_type = 'general' AND general_id IS NOT NULL AND simplified_id IS NULL AND monthly_record_id IS NOT NULL)
    )
  );''',
  '''CREATE TABLE balance_sheets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    balance_date TEXT NOT NULL,
    period TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'borrador' CHECK(status IN ('borrador', 'aprobado', 'cerrado')),
    total_assets REAL NOT NULL DEFAULT 0.0,
    total_liabilities REAL NOT NULL DEFAULT 0.0,
    total_equity REAL NOT NULL DEFAULT 0.0,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE
  );''',
  '''CREATE TABLE assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    balance_sheet_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('corriente', 'no corriente')),
    category TEXT,
    amount REAL NOT NULL DEFAULT 0.0,
    description TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (balance_sheet_id) REFERENCES balance_sheets(id) ON DELETE CASCADE
  );''',
  '''CREATE TABLE liabilities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    balance_sheet_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('corriente', 'no corriente')),
    category TEXT,
    amount REAL NOT NULL DEFAULT 0.0,
    description TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (balance_sheet_id) REFERENCES balance_sheets(id) ON DELETE CASCADE
  );''',
  '''CREATE TABLE equity (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    balance_sheet_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    category TEXT,
    amount REAL NOT NULL DEFAULT 0.0,
    description TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (balance_sheet_id) REFERENCES balance_sheets(id) ON DELETE CASCADE
  );''',
  '''CREATE TABLE income_statements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    period_start_date TEXT NOT NULL,
    period_end_date TEXT NOT NULL,
    net_sales REAL NOT NULL DEFAULT 0.0,
    cost_of_sales REAL NOT NULL DEFAULT 0.0,
    sales_expenses REAL NOT NULL DEFAULT 0.0,
    admin_expenses REAL NOT NULL DEFAULT 0.0,
    depreciation REAL NOT NULL DEFAULT 0.0,
    other_income REAL NOT NULL DEFAULT 0.0,
    financial_expenses REAL NOT NULL DEFAULT 0.0,
    taxes REAL NOT NULL DEFAULT 0.0,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE,
    CONSTRAINT uq_client_period UNIQUE (client_id, period_start_date, period_end_date)
  );''',
  '''CREATE TABLE services (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    amount REAL NOT NULL DEFAULT 0.0
  );''',
  '''CREATE TABLE service_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    date TEXT NOT NULL,
    date_payed TEXT,
    is_payed INTEGER NOT NULL DEFAULT 0,
    amount REAL NOT NULL DEFAULT 0.0,
    FOREIGN KEY(client_id) REFERENCES clients(id)
  );''',
  '''INSERT INTO permissions (name) VALUES 
    ('admin'), ('consultar_clientes'),
    ('gestionar_clientes'), ('user_management'),
    ('consultar_obligaciones'), ('gestionar_obligaciones'),
    ('consultar_balances'), ('gestionar_balances'),
    ('gestionar_estados');
  ''',
  '''INSERT INTO simplified_regime (category_number, min_capital, max_capital, taxable_amount, due_pattern) VALUES 
    ('Categoria 1', 12001, 15000, 47, '3-10,5-10,7-10,9-10,11-10,1-10'),
    ('Categoria 2', 15001, 18700, 90, '3-10,5-10,7-10,9-10,11-10,1-10'),
    ('Categoria 3', 18701, 23500, 147, '3-10,5-10,7-10,9-10,11-10,1-10'),
    ('Categoria 4', 23501, 29500, 158, '3-10,5-10,7-10,9-10,11-10,1-10'),
    ('Categoria 5', 29501, 37000, 200, '3-10,5-10,7-10,9-10,11-10,1-10'),
    ('Categoria 6', 37001, 60000, 350, '3-10,5-10,7-10,9-10,11-10,1-10');
  ''',
  '''INSERT INTO general_regime (name, periodicity, percentage, due_pattern) VALUES 
    ('IVA', 'mensual', 13.0, '13,22'),
    ('IT', 'mensual', 3.0, '13,22'),
    ('IUE', 'anual', 25.0, '3-31,06-30,09-30,12-31');
  ''',
  '''INSERT INTO services (name, amount) VALUES
    ('obligaciones', 60.0),
    ('balance', 70.0),
    ('resultados', 120.0);
  ''',
];
