execute immediate $$
begin

CREATE TABLE IF NOT EXISTS CATEGORY (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS CURRENCY (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS COLOR_LABEL (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS CHANNEL (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS TYPE (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS LABEL (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,NAME TEXT
);

CREATE TABLE IF NOT EXISTS SALES (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,TICKET_ID TEXT
    ,UID TEXT
    ,CURRENCY_ID INT
    ,SALES FLOAT
    ,QUANTITY INT
    ,DATE DATE
    ,FOREIGN KEY (CURRENCY_ID) REFERENCES CURRENCY(ID)
);

CREATE TABLE IF NOT EXISTS PRODUCTS (
     ID INT PRIMARY KEY AUTOINCREMENT START 1 INCREMENT 1
    ,UID TEXT
    ,CLOUD_PROD_ID TEXT
    ,PRODUCT_ID TEXT
    ,TITLE TEXT
    ,SUBTITLE TEXT
    ,SHORT_ID TEXT
    ,COLOR_NUM INT
    ,CATEGORY_ID INT
    ,TYPE_ID INT
    ,CURRENCY_ID INT
    ,FULL_PRICE FLOAT
    ,CURRENT_PRICE FLOAT
    ,SALE BOOLEAN
    ,TOPCOLOR TEXT
    ,CHANNEL_ID INT
    ,SHORT_DESCRIPTION TEXT
    ,RATING FLOAT
    ,CUSTOMIZABLE BOOLEAN
    ,EXTENDED_SIZING BOOLEAN
    ,IN_STOCK BOOLEAN
    ,COMING_SOON BOOLEAN
    ,BEST_SELLER BOOLEAN
    ,EXCLUDED BOOLEAN
    ,GIFT_CARD BOOLEAN
    ,JERSEY BOOLEAN
    ,LAUNCH BOOLEAN
    ,MEMBER_EXCLUSIVE BOOLEAN
    ,NBA BOOLEAN
    ,NFL BOOLEAN
    ,SUSTAINABLE BOOLEAN
    ,LABEL_ID INT
    ,PREBUILD_ID TEXT
    ,PROD_URL TEXT
    ,COLOR_ID TEXT
    ,COLOR_DESCRIPTION TEXT
    ,COLOR_FULLPRICE FLOAT
    ,COLOR_CURRENTPRICE FLOAT
    ,COLOR_DISCOUNT BOOLEAN
    ,COLOR_BESTSELLER BOOLEAN
    ,COLOR_IN_STOCK BOOLEAN
    ,COLOR_MEMBER_EXCLUSIVE BOOLEAN
    ,COLOR_NEW BOOLEAN
    ,COLOR_LABEL_ID INT
    ,COLOR_IMAGE_URL TEXT
    ,FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(ID)
    ,FOREIGN KEY (TYPE_ID) REFERENCES TYPE(ID)
    ,FOREIGN KEY (CURRENCY_ID) REFERENCES CURRENCY(ID)
    ,FOREIGN KEY (CHANNEL_ID) REFERENCES CHANNEL(ID)
    ,FOREIGN KEY (LABEL_ID) REFERENCES LABEL(ID)
    ,FOREIGN KEY (COLOR_LABEL_ID) REFERENCES LABEL(ID)
);

end;
$$