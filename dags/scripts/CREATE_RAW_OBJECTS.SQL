execute immediate $$
begin

CREATE TABLE IF NOT EXISTS PRODUCTS_RAW (
    ID INT,
    UID TEXT,
    cloudProdID TEXT,
    productID TEXT,
    shortID TEXT,
    colorNum INT,
    title TEXT,
    subtitle TEXT,
    category TEXT,
    type TEXT,
    currency TEXT,
    fullPrice FLOAT,
    currentPrice FLOAT,
    sale TEXT,
    TopColor TEXT,
    channel TEXT,
    short_description TEXT,
    rating FLOAT,
    customizable TEXT,
    ExtendedSizing TEXT,
    inStock TEXT,
    ComingSoon TEXT,
    BestSeller TEXT,
    Excluded TEXT,
    GiftCard TEXT,
    Jersey TEXT,
    Launch TEXT,
    MemberExclusive TEXT,
    NBA TEXT,
    NFL TEXT,
    Sustainable TEXT,
    label TEXT,
    prebuildId TEXT,
    prod_url TEXT,
    color_ID TEXT,
    color_Description TEXT,
    color_FullPrice FLOAT,
    color_CurrentPrice FLOAT,
    color_Discount TEXT,
    color_BestSeller TEXT,
    color_InStock TEXT,
    color_MemberExclusive TEXT,
    color_New TEXT,
    color_Label TEXT,
    color_Image_url TEXT
);

CREATE TABLE IF NOT EXISTS SALES_RAW (
     ID INT
    ,ticket_id INT
    ,UID TEXT
    ,currency TEXT
    ,sales FLOAT
    ,quantity INT
    ,DATE DATE
);

end;
$$