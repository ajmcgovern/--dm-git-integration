
CREATE TABLE Author
(
	Author_Identification CHAR(9)  NOT NULL ,
	Author_Last_Name     VARCHAR2(25)  NOT NULL ,
	Author_First_Name    VARCHAR2(15)  NULL ,
	Author_Phone_Number  INTEGER  NULL ,
	Author_Address       VARCHAR2(25)  NULL ,
	Author_City          VARCHAR2(20)  NULL ,
	Author_State         VARCHAR(4)  NOT NULL ,
	Author_Zip_Code      VARCHAR(9)  NULL ,
	Contract             SMALLINT  NULL 
);

CREATE UNIQUE INDEX UPKCL_auidind ON Author
(Author_Identification   ASC);

ALTER TABLE Author
	ADD CONSTRAINT  UPKCL_auidind PRIMARY KEY (Author_Identification);

CREATE INDEX aunmind ON Author
(Author_Last_Name   ASC,Author_First_Name   ASC);

CREATE TABLE Publisher
(
	Publisher_Identification CHAR(9)  NOT NULL ,
	Publisher_Name       VARCHAR2(40)  NULL ,
	Publisher_Address    VARCHAR2(20)  NULL ,
	Publisher_City       VARCHAR2(25)  NULL ,
	Publisher_State      VARCHAR(4)  DEFAULT 'USA'  NOT NULL ,
	Publisher_Zip_Code   VARCHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPKCL_pubind ON Publisher
(Publisher_Identification   ASC);

ALTER TABLE Publisher
	ADD CONSTRAINT  UPKCL_pubind PRIMARY KEY (Publisher_Identification);

CREATE TABLE Publisher_Logo
(
	Publisher_Identification CHAR(9)  NOT NULL ,
	Publisher_Logo       character(500)  NULL ,
	Publisher_Public_Relations_Inf VARCHAR2(200)  NULL 
);

CREATE UNIQUE INDEX UPKCL_pubinfo ON Publisher_Logo
(Publisher_Identification   ASC);

ALTER TABLE Publisher_Logo
	ADD CONSTRAINT  UPKCL_pubinfo PRIMARY KEY (Publisher_Identification);

CREATE TABLE Book
(
	Book_Identification  CHAR(9)  NOT NULL ,
	Book_Name            VARCHAR2(80)  NULL ,
	Book_Type            CHAR(12)  DEFAULT 'UNDECIDED'  NULL ,
	Publisher_Identification CHAR(9)  NULL ,
	MSRP_Price           DECIMAL(19,4)  NULL ,
	Advance              DECIMAL(19,4)  NULL ,
	Royalty_Terms        INTEGER  NULL ,
	Book_Note            VARCHAR2(200)  NULL ,
	Publication_Date     DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX UPKCL_titleidind ON Book
(Book_Identification   ASC);

ALTER TABLE Book
	ADD CONSTRAINT  UPKCL_titleidind PRIMARY KEY (Book_Identification);

CREATE INDEX titleind ON Book
(Book_Name   ASC);

CREATE TABLE Book_YTD_Sales
(
	Book_Identification  CHAR(9)  NOT NULL ,
	Year_To_Date_Sales_Amount DECIMAL(10,2)  NULL ,
	Year_To_Date_Sales_Date DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX XPKBook_YTD_Sales ON Book_YTD_Sales
(Book_Identification   ASC);

ALTER TABLE Book_YTD_Sales
	ADD CONSTRAINT  XPKBook_YTD_Sales PRIMARY KEY (Book_Identification);

CREATE TABLE BookAuthor
(
	Author_Identification CHAR(9)  NOT NULL ,
	Book_Identification  CHAR(9)  NOT NULL 
);

CREATE UNIQUE INDEX UPKCL_taind ON BookAuthor
(Author_Identification   ASC,Book_Identification   ASC);

ALTER TABLE BookAuthor
	ADD CONSTRAINT  UPKCL_taind PRIMARY KEY (Author_Identification,Book_Identification);

CREATE TABLE Credit_Card
(
	Card_Number          INTEGER  NULL ,
	Card_Expiration_Date DATE  NULL ,
	Credit_Card_Type     CHAR(4)  NULL ,
	Card_Vendor_Name     VARCHAR2(20)  NULL ,
	Credit_Card_Amount   NUMBER(7,2)  NULL ,
	Payment_Number       INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKCredit_Card ON Credit_Card
(Payment_Number   ASC);

ALTER TABLE Credit_Card
	ADD CONSTRAINT  XPKCredit_Card PRIMARY KEY (Payment_Number);

CREATE TABLE Credit_Check
(
	Credit_Check_Event   CHAR(12)  NOT NULL ,
	Credit_Check_Date    DATE  DEFAULT SYSDATE  NULL ,
	Credit_Status        CHAR(12)  NULL ,
	Payment_Number       INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKCredit_Check ON Credit_Check
(Credit_Check_Event   ASC);

ALTER TABLE Credit_Check
	ADD CONSTRAINT  XPKCredit_Check PRIMARY KEY (Credit_Check_Event);

CREATE TABLE Customer
(
	Customer_Identification CHAR(9)  NOT NULL ,
	Customer_First_Name  VARCHAR2(15)  NULL ,
	Customer_Last_Name   VARCHAR2(25)  NOT NULL ,
	Customer_Street_Address VARCHAR2(25)  NULL ,
	Customer_Company_Name VARCHAR2(40)  NULL ,
	Customer_City        VARCHAR2(25)  NULL ,
	Customer_State       VARCHAR(4)  DEFAULT 'NJ'  NOT NULL ,
	Customer_Zip_Code    VARCHAR(9)  NULL ,
	Customer_Phone_Area_Code INTEGER  DEFAULT 212  NULL ,
	Customer_Phone_Number INTEGER  NULL ,
	Customer_Fax_Area_Code INTEGER  DEFAULT 212  NULL  CONSTRAINT  area_codes_1093144733 CHECK (Customer_Fax_Area_Code IN (201, 212, 215, 732, 908)),
	Customer_Fax_Number  INTEGER  NULL 
);

CREATE UNIQUE INDEX XPKCustomer ON Customer
(Customer_Identification   ASC);

ALTER TABLE Customer
	ADD CONSTRAINT  XPKCustomer PRIMARY KEY (Customer_Identification);

CREATE INDEX XIE1Customer ON Customer
(Customer_Last_Name   ASC,Customer_First_Name   ASC);

CREATE TABLE Discount
(
	Discount_Type        VARCHAR2(4)  NOT NULL ,
	Low_Quantity         SMALLINT  NULL ,
	High_Quantity        SMALLINT  NULL ,
	Discount_Percent     DECIMAL(4,2)  NULL 
);

CREATE UNIQUE INDEX XPKDiscount ON Discount
(Discount_Type   ASC);

ALTER TABLE Discount
	ADD CONSTRAINT  XPKDiscount PRIMARY KEY (Discount_Type);

CREATE TABLE Job
(
	Job_Identification   CHAR(9)  NOT NULL ,
	Job_Description      VARCHAR2(50)  DEFAULT 'New Position - title not formalized yet'  NULL ,
	Minimum_Level        SMALLINT  NULL  CONSTRAINT  CK__jobs__min_lvl__1367E606 CHECK (Minimum_Level >= 10),
	Maximum_Level        SMALLINT  NULL  CONSTRAINT  CK__jobs__max_lvl__145C0A3F CHECK (Maximum_Level <= 250)
);

CREATE UNIQUE INDEX PK__jobs__117F9D94 ON Job
(Job_Identification   ASC);

ALTER TABLE Job
	ADD CONSTRAINT  PK__jobs__117F9D94 PRIMARY KEY (Job_Identification);

CREATE TABLE Employee
(
	Employee_Identification CHAR(9)  NOT NULL ,
	Employee_First_Name  VARCHAR2(20)  NULL ,
	Employee_Middle_Initial CHAR(1)  NULL ,
	Employee_Last_Name   VARCHAR2(30)  NULL ,
	Job_Identification   CHAR(9)  DEFAULT 1  NOT NULL  CONSTRAINT  area_codes_1689886395 CHECK (Job_Identification IN (201, 212, 215, 732, 908)),
	Current_Employee_Job_Title SMALLINT  DEFAULT 10  NULL ,
	Employee_Hire_Date   DATE  DEFAULT SYSDATE  NULL 
);

CREATE UNIQUE INDEX PK_emp_id ON Employee
(Employee_Identification   ASC);

ALTER TABLE Employee
	ADD CONSTRAINT  PK_emp_id PRIMARY KEY (Employee_Identification);

CREATE INDEX employee_ind ON Employee
(Employee_Last_Name   ASC,Employee_First_Name   ASC,Employee_Middle_Initial   ASC);

CREATE TABLE Store_Name
(
	Store_Identification CHAR(9)  NOT NULL ,
	Store_Name           VARCHAR2(40)  NULL ,
	Store_Address        VARCHAR2(25)  NULL ,
	Store_City           VARCHAR2(25)  NULL ,
	Store_State          VARCHAR(4)  NOT NULL ,
	Store_Zip_Code       VARCHAR(9)  NULL ,
	Region_Identification CHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPK_storeid ON Store_Name
(Store_Identification   ASC);

ALTER TABLE Store_Name
	ADD CONSTRAINT  UPK_storeid PRIMARY KEY (Store_Identification);

CREATE TABLE Purchase_Order
(
	Store_Identification CHAR(9)  NOT NULL ,
	Order_Number         INTEGER  NOT NULL ,
	Order_Date           DATE  DEFAULT SYSDATE  NULL ,
	Payment_Terms        VARCHAR2(12)  NULL ,
	Customer_Identification CHAR(9)  NULL 
);

CREATE UNIQUE INDEX UPKCL_sales ON Purchase_Order
(Order_Number   ASC);

ALTER TABLE Purchase_Order
	ADD CONSTRAINT  UPKCL_sales PRIMARY KEY (Order_Number);

CREATE TABLE Order_Item
(
	Order_Quantity       SMALLINT  NULL ,
	Order_Number         INTEGER  NOT NULL ,
	Book_Identification  CHAR(9)  NOT NULL ,
	Item_Sequence_Number INTEGER  NOT NULL ,
	Discount_Type        VARCHAR2(4)  NULL ,
	Order_Discount_Amount DECIMAL(7,2)  NULL ,
	Order_Price          DECIMAL(7,2)  NULL 
);

CREATE UNIQUE INDEX XPKOrder_Item ON Order_Item
(Order_Number   ASC,Item_Sequence_Number   ASC);

ALTER TABLE Order_Item
	ADD CONSTRAINT  XPKOrder_Item PRIMARY KEY (Order_Number,Item_Sequence_Number);

CREATE TABLE Royalty_History
(
	Order_Number         INTEGER  NULL ,
	Item_Sequence_Number INTEGER  NULL ,
	Royalty_History_Identification CHAR(9)  NOT NULL ,
	Royalty_Payment_Date DATE  DEFAULT SYSDATE  NULL ,
	Royalty_Payment_Amount DECIMAL(6,2)  NULL ,
	Royalty_Payee        CHAR(30)  NULL 
);

CREATE UNIQUE INDEX XPKRoyalty_History ON Royalty_History
(Royalty_History_Identification   ASC);

ALTER TABLE Royalty_History
	ADD CONSTRAINT  XPKRoyalty_History PRIMARY KEY (Royalty_History_Identification);

CREATE TABLE Book_Retrun
(
	Book_Return_Identification CHAR(9)  NOT NULL ,
	Order_Number         INTEGER  NULL ,
	Item_Sequence_Number INTEGER  NULL ,
	Book_Return_Date     DATE  NULL 
);

CREATE UNIQUE INDEX XPKBook_Retrun ON Book_Retrun
(Book_Return_Identification   ASC);

ALTER TABLE Book_Retrun
	ADD CONSTRAINT  XPKBook_Retrun PRIMARY KEY (Book_Return_Identification);

CREATE TABLE Money_Order
(
	Money_Order_Number   INTEGER  NULL ,
	Money_Order_Amount   NUMBER(7,2)  NULL ,
	Payment_Number       INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKMoney_Order ON Money_Order
(Payment_Number   ASC);

CREATE TABLE Order_Shipment
(
	Order_Shipment_Identifier CHAR(9)  NOT NULL ,
	Billing_Address      VARCHAR2(25)  NULL ,
	Shipping_Address     VARCHAR2(25)  NULL ,
	Shipment_Status      CHAR(7)  NULL ,
	Scheduled_Shipment_Date DATE  DEFAULT SYSDATE  NULL ,
	Order_Number         INTEGER  NOT NULL ,
	Item_Sequence_Number INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKOrder_Shipment ON Order_Shipment
(Order_Shipment_Identifier   ASC,Order_Number   ASC,Item_Sequence_Number   ASC);

ALTER TABLE Order_Shipment
	ADD CONSTRAINT  XPKOrder_Shipment PRIMARY KEY (Order_Shipment_Identifier,Order_Number,Item_Sequence_Number);

CREATE TABLE Back_Order
(
	Rescheduled_Shipment_Date DATE  NULL ,
	Order_Shipment_Identifier CHAR(9)  DEFAULT 212  NOT NULL  CONSTRAINT  area_codes_1316321452 CHECK (Order_Shipment_Identifier IN (201, 212, 215, 732, 908)),
	Order_Number         INTEGER  NOT NULL ,
	Item_Sequence_Number INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKBack_Order ON Back_Order
(Order_Shipment_Identifier   ASC,Order_Number   ASC,Item_Sequence_Number   ASC);

ALTER TABLE Back_Order
	ADD CONSTRAINT  XPKBack_Order PRIMARY KEY (Order_Shipment_Identifier,Order_Number,Item_Sequence_Number);

CREATE TABLE Payment
(
	Payment_Number       INTEGER  NOT NULL ,
	Payment_Date         DATE  DEFAULT SYSDATE  NULL ,
	Payment_Amount       DECIMAL(7,2)  NULL ,
	Payment_Type         CHAR(9)  NULL 
);

CREATE UNIQUE INDEX XPKPayment ON Payment
(Payment_Number   ASC);

ALTER TABLE Payment
	ADD CONSTRAINT  XPKPayment PRIMARY KEY (Payment_Number);

CREATE TABLE Personal_Check
(
	Check_Number         INTEGER  NULL ,
	Check_Account_Number INTEGER  NULL ,
	Check_Bank_Number    INTEGER  NULL ,
	Check_Driver_License_Number CHAR(15)  NULL ,
	Check_Amount         NUMBER(7,2)  NULL ,
	Payment_Number       INTEGER  NOT NULL 
);

CREATE UNIQUE INDEX XPKPersonal_Check ON Personal_Check
(Payment_Number   ASC);

CREATE TABLE Region
(
	Region_Identification CHAR(9)  NOT NULL ,
	Region_Area          CHAR(7)  NULL ,
	Region_Description   VARCHAR2(75)  NULL 
);

CREATE UNIQUE INDEX XPKRegion ON Region
(Region_Identification   ASC);

ALTER TABLE Region
	ADD CONSTRAINT  XPKRegion PRIMARY KEY (Region_Identification);

CREATE TABLE Royalty
(
	Low_Range            INTEGER  NULL ,
	High_Range           INTEGER  NULL ,
	Royalty_Amount       NUMBER(5,2)  NULL ,
	Royalty_Identification CHAR(9)  NOT NULL 
);

CREATE UNIQUE INDEX XPKRoyalty ON Royalty
(Royalty_Identification   ASC);

ALTER TABLE Royalty
	ADD CONSTRAINT  XPKRoyalty PRIMARY KEY (Royalty_Identification);

CREATE TABLE Royalty_Payment
(
	Author_Identification CHAR(9)  NOT NULL ,
	Book_Identification  CHAR(9)  NOT NULL ,
	Royalty_Identification CHAR(9)  DEFAULT 212  NOT NULL  CONSTRAINT  area_codes_1388055851 CHECK (Royalty_Identification IN (201, 212, 215, 732, 908)),
	Payment_Date         DATE  DEFAULT SYSDATE  NULL ,
	Payment_Amount       DECIMAL(7,2)  NULL 
);

CREATE UNIQUE INDEX XPKRoyalty_Payment ON Royalty_Payment
(Author_Identification   ASC,Book_Identification   ASC,Royalty_Identification   ASC);

ALTER TABLE Royalty_Payment
	ADD CONSTRAINT  XPKRoyalty_Payment PRIMARY KEY (Author_Identification,Book_Identification,Royalty_Identification);

CREATE TABLE Reporting_Structure
(
	Manager              CHAR(9)  NOT NULL ,
	Reports_To           CHAR(9)  NOT NULL ,
	Start_Date           DATE  NULL ,
	End_Date             DATE  NULL 
);

CREATE UNIQUE INDEX XPKReporting_Structure ON Reporting_Structure
(Manager   ASC,Reports_To   ASC);

ALTER TABLE Reporting_Structure
	ADD CONSTRAINT  XPKReporting_Structure PRIMARY KEY (Manager,Reports_To);

CREATE VIEW titleview
   (Book_Nam, Auth_Id, Auth_Lst_Nam, MRSP_Prc, Publshr_Id)
AS SELECT
   Book.Book_Nam, Auth.Auth_Id, Auth.Auth_Lst_Nam,
   Book.MRSP_Prc, Book.Publshr_Id
FROM Book, Auth, BookAuth
;

CREATE VIEW Order_View ( Store_Name,Order_Number,Order_Date,Book_Name,Order_Quantity,Order_Discount_Amount,Order_Price ) 
	 AS  SELECT Store_Name.Store_Name,Purchase_Order.Order_Number,Purchase_Order.Order_Date,Book.Book_Name,Order_Item.Order_Quantity,Order_Item.Order_Discount_Amount,Order_Item.Order_Price
		FROM Order_Item ,Book ,Purchase_Order ,Store_Name ;

CREATE VIEW Publisher_View ( Employee_First_Name,Employee_Last_Name,Publisher_Name,Book_Name,Year_To_Date_Sales_Amount ) 
	 AS  SELECT Employee.Employee_First_Name,Employee.Employee_Last_Name,Publisher.Publisher_Name,Book.Book_Name,Book_YTD_Sales.Year_To_Date_Sales_Amount
		FROM Publisher ,Book ,Book_YTD_Sales ,Employee ;

CREATE VIEW Payment_View ( Card_Number,Credit_Card_Amount,Money_Order_Number,Money_Order_Amount,Check_Number,Check_Amount,Customer_First_Name,Customer_Last_Name,Order_Number,Order_Date ) 
	 AS  SELECT Credit_Card.Card_Number,Credit_Card.Credit_Card_Amount,Money_Order.Money_Order_Number,Money_Order.Money_Order_Amount,Personal_Check.Check_Number,Personal_Check.Check_Amount,Customer.Customer_First_Name,Customer.Customer_Last_Name,Purchase_Order.Order_Number,Purchase_Order.Order_Date
		FROM Money_Order ,Payment ,Credit_Card ,Personal_Check ,Customer ,Purchase_Order ;

ALTER TABLE Publisher_Logo
	ADD (
CONSTRAINT FK_Publisher_Publisher_Logo FOREIGN KEY (Publisher_Identification) REFERENCES Publisher (Publisher_Identification));

ALTER TABLE Book
	ADD (
CONSTRAINT FK_Publisher_Book FOREIGN KEY (Publisher_Identification) REFERENCES Publisher (Publisher_Identification));

ALTER TABLE Book_YTD_Sales
	ADD (
CONSTRAINT FK_Book_Book_YTD_Sales FOREIGN KEY (Book_Identification) REFERENCES Book (Book_Identification));

ALTER TABLE BookAuthor
	ADD (
CONSTRAINT FK_Author_BookAuthor FOREIGN KEY (Author_Identification) REFERENCES Author (Author_Identification));

ALTER TABLE BookAuthor
	ADD (
CONSTRAINT FK_Book_BookAuthor FOREIGN KEY (Book_Identification) REFERENCES Book (Book_Identification));

ALTER TABLE Credit_Card
	ADD (
CONSTRAINT FK_Payment_Credit_Card FOREIGN KEY (Payment_Number) REFERENCES Payment (Payment_Number) ON DELETE CASCADE);

ALTER TABLE Credit_Check
	ADD (
CONSTRAINT FK_Credit_Card_Credit_Check FOREIGN KEY (Payment_Number) REFERENCES Credit_Card (Payment_Number));

ALTER TABLE Employee
	ADD (
CONSTRAINT FK_Job_Employee FOREIGN KEY (Job_Identification) REFERENCES Job (Job_Identification));

ALTER TABLE Store_Name
	ADD (
CONSTRAINT FK_Region_Store_Name FOREIGN KEY (Region_Identification) REFERENCES Region (Region_Identification) ON DELETE SET NULL);

ALTER TABLE Purchase_Order
	ADD (
CONSTRAINT FK_Customer_Purchase_Order FOREIGN KEY (Customer_Identification) REFERENCES Customer (Customer_Identification) ON DELETE SET NULL);

ALTER TABLE Purchase_Order
	ADD (
CONSTRAINT FK_Store_Name_Purchase_Order FOREIGN KEY (Store_Identification) REFERENCES Store_Name (Store_Identification));

ALTER TABLE Order_Item
	ADD (
CONSTRAINT FK_Discount_Order_Item FOREIGN KEY (Discount_Type) REFERENCES Discount (Discount_Type) ON DELETE SET NULL);

ALTER TABLE Order_Item
	ADD (
CONSTRAINT FK_Purchase_Order_Order_Item FOREIGN KEY (Order_Number) REFERENCES Purchase_Order (Order_Number));

ALTER TABLE Order_Item
	ADD (
CONSTRAINT FK_Book_Order_Item FOREIGN KEY (Book_Identification) REFERENCES Book (Book_Identification));

ALTER TABLE Royalty_History
	ADD (
CONSTRAINT FK_Order_Item_Royalty_History FOREIGN KEY (Order_Number, Item_Sequence_Number) REFERENCES Order_Item (Order_Number, Item_Sequence_Number) ON DELETE SET NULL);

ALTER TABLE Book_Retrun
	ADD (
CONSTRAINT FK_Order_Item_Book_Retrun FOREIGN KEY (Order_Number, Item_Sequence_Number) REFERENCES Order_Item (Order_Number, Item_Sequence_Number) ON DELETE SET NULL);

ALTER TABLE Money_Order
	ADD (
CONSTRAINT FK_Payment_Money_Order FOREIGN KEY (Payment_Number) REFERENCES Payment (Payment_Number) ON DELETE CASCADE);

ALTER TABLE Order_Shipment
	ADD (
CONSTRAINT FK_Order_Item_Order_Shipment FOREIGN KEY (Order_Number, Item_Sequence_Number) REFERENCES Order_Item (Order_Number, Item_Sequence_Number));

ALTER TABLE Back_Order
	ADD (
CONSTRAINT FK_Order_Shipment_Back_Order FOREIGN KEY (Order_Shipment_Identifier, Order_Number, Item_Sequence_Number) REFERENCES Order_Shipment (Order_Shipment_Identifier, Order_Number, Item_Sequence_Number));

ALTER TABLE Personal_Check
	ADD (
CONSTRAINT FK_Payment_Personal_Check FOREIGN KEY (Payment_Number) REFERENCES Payment (Payment_Number) ON DELETE CASCADE);

ALTER TABLE Royalty_Payment
	ADD (
CONSTRAINT FK_Royalty_Royalty_Payment FOREIGN KEY (Royalty_Identification) REFERENCES Royalty (Royalty_Identification));

ALTER TABLE Royalty_Payment
	ADD (
CONSTRAINT FK_BookAuthor_Royalty_Payment FOREIGN KEY (Author_Identification, Book_Identification) REFERENCES BookAuthor (Author_Identification, Book_Identification));

ALTER TABLE Reporting_Structure
	ADD (
CONSTRAINT FK_Employee_Manager FOREIGN KEY (Manager) REFERENCES Employee (Employee_Identification));

ALTER TABLE Reporting_Structure
	ADD (
CONSTRAINT FK_Employee_ReportTo FOREIGN KEY (Reports_To) REFERENCES Employee (Employee_Identification));

CREATE  PROCEDURE byroyalty 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select au_id 
   from titleauthor
   where titleauthor.royaltyper = @percentage;
END;
/



CREATE  PROCEDURE reptq1 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
	case when grouping(pub_id) = 1 then 'ALL' 
             else pub_id end as pub_id, avg(price) as avg_price
   from titles
   where price is NOT NULL
   group by pub_id with rollup
   order by pub_id;
END;
/



CREATE  PROCEDURE reptq2 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
      case when grouping(type) = 1 then 'ALL' 
      else type end as type, 
      case when grouping(pub_id) = 1 then 'ALL' 
      else pub_id end as pub_id, avg(ytd_sales) as avg_ytd_sales
   from titles
   where pub_id is NOT NULL
   group by pub_id, type with rollup;
END;
/



CREATE  PROCEDURE reptq3x 
--   (<argument name> <in out nocopy> <argument datatype> <default value>)
AS
BEGIN
   select 
      case when grouping(pub_id) = 1 then 'ALL' 
      else pub_id end as pub_id, 
      case when grouping(type) = 1 then 'ALL' 
      else type end as type, count(title_id) as cnt
   from titles
   where price >@lolimit AND price <@hilimit AND 
         type = @type OR type LIKE '%cook%'
   group by pub_id, type with rollup;
END;
/




CREATE  TRIGGER  tD_Author AFTER DELETE ON Author for each row
-- erwin Builtin Trigger
-- DELETE trigger on Author 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Author  BookAuthor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000fae4", PARENT_OWNER="", PARENT_TABLE="Author"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Author_BookAuthor", FK_COLUMNS="Author_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuthor
      WHERE
        /*  %JoinFKPK(BookAuthor,:%Old," = "," AND") */
        BookAuthor.Author_Identification = :old.Author_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Author because BookAuthor exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Author AFTER UPDATE ON Author for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Author 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Author  BookAuthor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00011f8a", PARENT_OWNER="", PARENT_TABLE="Author"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Author_BookAuthor", FK_COLUMNS="Author_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Author_Identification <> :new.Author_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuthor
      WHERE
        /*  %JoinFKPK(BookAuthor,:%Old," = "," AND") */
        BookAuthor.Author_Identification = :old.Author_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Author because BookAuthor exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Publisher AFTER DELETE ON Publisher for each row
-- erwin Builtin Trigger
-- DELETE trigger on Publisher 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publisher  Publisher_Logo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000213f4", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Publisher_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Publisher_Logo", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Publisher_Logo
      WHERE
        /*  %JoinFKPK(Publisher_Logo,:%Old," = "," AND") */
        Publisher_Logo.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Publisher because Publisher_Logo exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Publisher  Book on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Book", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /*  %JoinFKPK(Book,:%Old," = "," AND") */
        Book.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Publisher because Book exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Publisher AFTER UPDATE ON Publisher for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Publisher 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Publisher  Publisher_Logo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00027b5d", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Publisher_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Publisher_Logo", FK_COLUMNS="Publisher_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Publisher_Identification <> :new.Publisher_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Publisher_Logo
      WHERE
        /*  %JoinFKPK(Publisher_Logo,:%Old," = "," AND") */
        Publisher_Logo.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Publisher because Publisher_Logo exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Publisher  Book on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Book", FK_COLUMNS="Publisher_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Publisher_Identification <> :new.Publisher_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /*  %JoinFKPK(Book,:%Old," = "," AND") */
        Book.Publisher_Identification = :old.Publisher_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Publisher because Book exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Publisher_Logo BEFORE INSERT ON Publisher_Logo for each row
-- erwin Builtin Trigger
-- INSERT trigger on Publisher_Logo 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publisher  Publisher_Logo on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00012300", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Publisher_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Publisher_Logo", FK_COLUMNS="Publisher_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Publisher
      WHERE
        /* %JoinFKPK(:%New,Publisher," = "," AND") */
        :new.Publisher_Identification = Publisher.Publisher_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Publisher_Logo because Publisher does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Publisher_Logo AFTER UPDATE ON Publisher_Logo for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Publisher_Logo 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Publisher  Publisher_Logo on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00011f25", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Publisher_Logo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Publisher_Logo", FK_COLUMNS="Publisher_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Publisher
    WHERE
      /* %JoinFKPK(:%New,Publisher," = "," AND") */
      :new.Publisher_Identification = Publisher.Publisher_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Publisher_Logo because Publisher does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Book AFTER DELETE ON Book for each row
-- erwin Builtin Trigger
-- DELETE trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  BookAuthor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002fc13", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuthor", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuthor
      WHERE
        /*  %JoinFKPK(BookAuthor,:%Old," = "," AND") */
        BookAuthor.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Book because BookAuthor exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Book  Book_YTD_Sales on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sales", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sales
      WHERE
        /*  %JoinFKPK(Book_YTD_Sales,:%Old," = "," AND") */
        Book_YTD_Sales.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Book because Book_YTD_Sales exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Book  Order_Item on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Order_Item", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Order_Item
      WHERE
        /*  %JoinFKPK(Order_Item,:%Old," = "," AND") */
        Order_Item.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Book because Order_Item exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book BEFORE INSERT ON Book for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Publisher  Book on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00011644", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Book", FK_COLUMNS="Publisher_Identification" */
    UPDATE Book
      SET
        /* %SetFK(Book,NULL) */
        Book.Publisher_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Publisher
            WHERE
              /* %JoinFKPK(:%New,Publisher," = "," AND") */
              :new.Publisher_Identification = Publisher.Publisher_Identification
        ) 
        /* %JoinPKPK(Book,:%New," = "," AND") */
         and Book.Book_Identification = :new.Book_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book AFTER UPDATE ON Book for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Book  BookAuthor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004b408", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuthor", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM BookAuthor
      WHERE
        /*  %JoinFKPK(BookAuthor,:%Old," = "," AND") */
        BookAuthor.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because BookAuthor exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Book_YTD_Sales on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sales", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Book_YTD_Sales
      WHERE
        /*  %JoinFKPK(Book_YTD_Sales,:%Old," = "," AND") */
        Book_YTD_Sales.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because Book_YTD_Sales exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Order_Item on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Order_Item", FK_COLUMNS="Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Order_Item
      WHERE
        /*  %JoinFKPK(Order_Item,:%Old," = "," AND") */
        Order_Item.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Book because Order_Item exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Publisher  Book on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Publisher"
    CHILD_OWNER="", CHILD_TABLE="Book"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Publisher_Book", FK_COLUMNS="Publisher_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Publisher
    WHERE
      /* %JoinFKPK(:%New,Publisher," = "," AND") */
      :new.Publisher_Identification = Publisher.Publisher_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Publisher_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book because Publisher does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book_YTD_Sales BEFORE INSERT ON Book_YTD_Sales for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book_YTD_Sales 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  Book_YTD_Sales on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f328", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sales", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Book_YTD_Sales because Book does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book_YTD_Sales AFTER UPDATE ON Book_YTD_Sales for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book_YTD_Sales 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Book  Book_YTD_Sales on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000f4ab", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Book_YTD_Sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Book_YTD_Sales", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book_YTD_Sales because Book does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_BookAuthor AFTER DELETE ON BookAuthor for each row
-- erwin Builtin Trigger
-- DELETE trigger on BookAuthor 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* BookAuthor  Royalty_Payment on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00013518", PARENT_OWNER="", PARENT_TABLE="BookAuthor"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuthor_Royalty_Payment", FK_COLUMNS="Author_Identification""Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Royalty_Payment
      WHERE
        /*  %JoinFKPK(Royalty_Payment,:%Old," = "," AND") */
        Royalty_Payment.Author_Identification = :old.Author_Identification AND
        Royalty_Payment.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete BookAuthor because Royalty_Payment exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_BookAuthor BEFORE INSERT ON BookAuthor for each row
-- erwin Builtin Trigger
-- INSERT trigger on BookAuthor 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  BookAuthor on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00021ad8", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuthor", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert BookAuthor because Book does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Author  BookAuthor on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Author"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Author_BookAuthor", FK_COLUMNS="Author_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Author
      WHERE
        /* %JoinFKPK(:%New,Author," = "," AND") */
        :new.Author_Identification = Author.Author_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert BookAuthor because Author does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_BookAuthor AFTER UPDATE ON BookAuthor for each row
-- erwin Builtin Trigger
-- UPDATE trigger on BookAuthor 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* BookAuthor  Royalty_Payment on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0003a4b8", PARENT_OWNER="", PARENT_TABLE="BookAuthor"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuthor_Royalty_Payment", FK_COLUMNS="Author_Identification""Book_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Author_Identification <> :new.Author_Identification OR 
    :old.Book_Identification <> :new.Book_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Royalty_Payment
      WHERE
        /*  %JoinFKPK(Royalty_Payment,:%Old," = "," AND") */
        Royalty_Payment.Author_Identification = :old.Author_Identification AND
        Royalty_Payment.Book_Identification = :old.Book_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update BookAuthor because Royalty_Payment exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  BookAuthor on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_BookAuthor", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update BookAuthor because Book does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Author  BookAuthor on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Author"
    CHILD_OWNER="", CHILD_TABLE="BookAuthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Author_BookAuthor", FK_COLUMNS="Author_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Author
    WHERE
      /* %JoinFKPK(:%New,Author," = "," AND") */
      :new.Author_Identification = Author.Author_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update BookAuthor because Author does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Credit_Card AFTER DELETE ON Credit_Card for each row
-- erwin Builtin Trigger
-- DELETE trigger on Credit_Card 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Credit_Card  Credit_Check on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f75a", PARENT_OWNER="", PARENT_TABLE="Credit_Card"
    CHILD_OWNER="", CHILD_TABLE="Credit_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Credit_Card_Credit_Check", FK_COLUMNS="Payment_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Credit_Check
      WHERE
        /*  %JoinFKPK(Credit_Check,:%Old," = "," AND") */
        Credit_Check.Payment_Number = :old.Payment_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Credit_Card because Credit_Check exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Credit_Card AFTER UPDATE ON Credit_Card for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Credit_Card 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Credit_Card  Credit_Check on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001240f", PARENT_OWNER="", PARENT_TABLE="Credit_Card"
    CHILD_OWNER="", CHILD_TABLE="Credit_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Credit_Card_Credit_Check", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Credit_Check
      WHERE
        /*  %JoinFKPK(Credit_Check,:%Old," = "," AND") */
        Credit_Check.Payment_Number = :old.Payment_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Credit_Card because Credit_Check exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Credit_Check BEFORE INSERT ON Credit_Check for each row
-- erwin Builtin Trigger
-- INSERT trigger on Credit_Check 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Credit_Card  Credit_Check on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001077a", PARENT_OWNER="", PARENT_TABLE="Credit_Card"
    CHILD_OWNER="", CHILD_TABLE="Credit_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Credit_Card_Credit_Check", FK_COLUMNS="Payment_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Credit_Card
      WHERE
        /* %JoinFKPK(:%New,Credit_Card," = "," AND") */
        :new.Payment_Number = Credit_Card.Payment_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Credit_Check because Credit_Card does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Credit_Check AFTER UPDATE ON Credit_Check for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Credit_Check 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Credit_Card  Credit_Check on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010c8f", PARENT_OWNER="", PARENT_TABLE="Credit_Card"
    CHILD_OWNER="", CHILD_TABLE="Credit_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Credit_Card_Credit_Check", FK_COLUMNS="Payment_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Credit_Card
    WHERE
      /* %JoinFKPK(:%New,Credit_Card," = "," AND") */
      :new.Payment_Number = Credit_Card.Payment_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Credit_Check because Credit_Card does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Customer AFTER DELETE ON Customer for each row
-- erwin Builtin Trigger
-- DELETE trigger on Customer 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Customer  Purchase_Order on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000ef3f", PARENT_OWNER="", PARENT_TABLE="Customer"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Customer_Purchase_Order", FK_COLUMNS="Customer_Identification" */
    UPDATE Purchase_Order
      SET
        /* %SetFK(Purchase_Order,NULL) */
        Purchase_Order.Customer_Identification = NULL
      WHERE
        /* %JoinFKPK(Purchase_Order,:%Old," = "," AND") */
        Purchase_Order.Customer_Identification = :old.Customer_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Customer AFTER UPDATE ON Customer for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Customer 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Customer  Purchase_Order on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00012b2a", PARENT_OWNER="", PARENT_TABLE="Customer"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Customer_Purchase_Order", FK_COLUMNS="Customer_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Customer_Identification <> :new.Customer_Identification
  THEN
    UPDATE Purchase_Order
      SET
        /* %SetFK(Purchase_Order,NULL) */
        Purchase_Order.Customer_Identification = NULL
      WHERE
        /* %JoinFKPK(Purchase_Order,:%Old," = ",",") */
        Purchase_Order.Customer_Identification = :old.Customer_Identification;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Discount AFTER DELETE ON Discount for each row
-- erwin Builtin Trigger
-- DELETE trigger on Discount 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Discount  Order_Item on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000d1a7", PARENT_OWNER="", PARENT_TABLE="Discount"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Discount_Order_Item", FK_COLUMNS="Discount_Type" */
    UPDATE Order_Item
      SET
        /* %SetFK(Order_Item,NULL) */
        Order_Item.Discount_Type = NULL
      WHERE
        /* %JoinFKPK(Order_Item,:%Old," = "," AND") */
        Order_Item.Discount_Type = :old.Discount_Type;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Discount AFTER UPDATE ON Discount for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Discount 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Discount  Order_Item on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000f8d4", PARENT_OWNER="", PARENT_TABLE="Discount"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Discount_Order_Item", FK_COLUMNS="Discount_Type" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Discount_Type <> :new.Discount_Type
  THEN
    UPDATE Order_Item
      SET
        /* %SetFK(Order_Item,NULL) */
        Order_Item.Discount_Type = NULL
      WHERE
        /* %JoinFKPK(Order_Item,:%Old," = ",",") */
        Order_Item.Discount_Type = :old.Discount_Type;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Job AFTER DELETE ON Job for each row
-- erwin Builtin Trigger
-- DELETE trigger on Job 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Job  Employee on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000ec58", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Employee", FK_COLUMNS="Job_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Employee
      WHERE
        /*  %JoinFKPK(Employee,:%Old," = "," AND") */
        Employee.Job_Identification = :old.Job_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Job because Employee exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Job AFTER UPDATE ON Job for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Job 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Job  Employee on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00011c33", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Employee", FK_COLUMNS="Job_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Job_Identification <> :new.Job_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Employee
      WHERE
        /*  %JoinFKPK(Employee,:%Old," = "," AND") */
        Employee.Job_Identification = :old.Job_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Job because Employee exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER employee_insupd
  AFTER INSERT OR UPDATE
  ON Employee
  
  
  

--Get the range of level for this job type from the jobs table.
declare Xmin_lvl smallint;
        Xmax_lvl smallint;
        Xemp_lvl smallint;
        Xjob_id  smallint;

Begin
   select Xmin_lvl = min_lvl,
      Xmax_lvl = max_lvl,
      Xemp_lvl = i.job_lvl,
      Xjob_id = i.job_id
   from employee e, jobs j, inserted i
   where e.emp_id = i.emp_id AND i.job_id = j.job_id;

   IF (Xjob_id = 1) and (Xemp_lvl <> 10) then
      raise_application_error (-20001, 
      'Job id 1 expects the default level of 10.');
   ELSE
      IF NOT (Xemp_lvl BETWEEN Xmin_lvl AND Xmax_lvl) then
         raise_application_error (-20002, 
         'The level for job_id:%d should be between %d and %d.', 
         Xjob_id, Xmin_lvl, Xmax_lvl);
      end if;
   end if;
END;
/



ALTER TRIGGER employee_insupd
	ENABLE;


CREATE  TRIGGER  tD_Employee AFTER DELETE ON Employee for each row
-- erwin Builtin Trigger
-- DELETE trigger on Employee 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Employee  Reporting_Structure on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00022578", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Reports_To = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Employee because Reporting_Structure exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Employee  Reporting_Structure on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Manager = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Employee because Reporting_Structure exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Employee BEFORE INSERT ON Employee for each row
-- erwin Builtin Trigger
-- INSERT trigger on Employee 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Job  Employee on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f6d6", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Employee", FK_COLUMNS="Job_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Job
      WHERE
        /* %JoinFKPK(:%New,Job," = "," AND") */
        :new.Job_Identification = Job.Job_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Employee because Job does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Employee AFTER UPDATE ON Employee for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Employee 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Employee  Reporting_Structure on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00039f9e", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Employee_Identification <> :new.Employee_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Reports_To = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Employee because Reporting_Structure exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Employee  Reporting_Structure on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Employee_Identification <> :new.Employee_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Reporting_Structure
      WHERE
        /*  %JoinFKPK(Reporting_Structure,:%Old," = "," AND") */
        Reporting_Structure.Manager = :old.Employee_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Employee because Reporting_Structure exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Job  Employee on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Job"
    CHILD_OWNER="", CHILD_TABLE="Employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Job_Employee", FK_COLUMNS="Job_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Job
    WHERE
      /* %JoinFKPK(:%New,Job," = "," AND") */
      :new.Job_Identification = Job.Job_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Employee because Job does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Store_Name AFTER DELETE ON Store_Name for each row
-- erwin Builtin Trigger
-- DELETE trigger on Store_Name 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Store_Name  Purchase_Order on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010fac", PARENT_OWNER="", PARENT_TABLE="Store_Name"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Store_Name_Purchase_Order", FK_COLUMNS="Store_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Order
      WHERE
        /*  %JoinFKPK(Purchase_Order,:%Old," = "," AND") */
        Purchase_Order.Store_Identification = :old.Store_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot DELETE Store_Name because Purchase_Order exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Store_Name BEFORE INSERT ON Store_Name for each row
-- erwin Builtin Trigger
-- INSERT trigger on Store_Name 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Region  Store_Name on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00011390", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Store_Name"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Region_Store_Name", FK_COLUMNS="Region_Identification" */
    UPDATE Store_Name
      SET
        /* %SetFK(Store_Name,NULL) */
        Store_Name.Region_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Region
            WHERE
              /* %JoinFKPK(:%New,Region," = "," AND") */
              :new.Region_Identification = Region.Region_Identification
        ) 
        /* %JoinPKPK(Store_Name,:%New," = "," AND") */
         and Store_Name.Store_Identification = :new.Store_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Store_Name AFTER UPDATE ON Store_Name for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Store_Name 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Store_Name  Purchase_Order on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00026770", PARENT_OWNER="", PARENT_TABLE="Store_Name"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Store_Name_Purchase_Order", FK_COLUMNS="Store_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Store_Identification <> :new.Store_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Order
      WHERE
        /*  %JoinFKPK(Purchase_Order,:%Old," = "," AND") */
        Purchase_Order.Store_Identification = :old.Store_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Store_Name because Purchase_Order exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Region  Store_Name on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Store_Name"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Region_Store_Name", FK_COLUMNS="Region_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Region
    WHERE
      /* %JoinFKPK(:%New,Region," = "," AND") */
      :new.Region_Identification = Region.Region_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Region_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Store_Name because Region does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Purchase_Order AFTER DELETE ON Purchase_Order for each row
-- erwin Builtin Trigger
-- DELETE trigger on Purchase_Order 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Purchase_Order  Order_Item on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f4e2", PARENT_OWNER="", PARENT_TABLE="Purchase_Order"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Order_Order_Item", FK_COLUMNS="Order_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Order_Item
      WHERE
        /*  %JoinFKPK(Order_Item,:%Old," = "," AND") */
        Order_Item.Order_Number = :old.Order_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Purchase_Order because Order_Item exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Purchase_Order BEFORE INSERT ON Purchase_Order for each row
-- erwin Builtin Trigger
-- INSERT trigger on Purchase_Order 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Customer  Purchase_Order on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00025913", PARENT_OWNER="", PARENT_TABLE="Customer"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Customer_Purchase_Order", FK_COLUMNS="Customer_Identification" */
    UPDATE Purchase_Order
      SET
        /* %SetFK(Purchase_Order,NULL) */
        Purchase_Order.Customer_Identification = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Customer
            WHERE
              /* %JoinFKPK(:%New,Customer," = "," AND") */
              :new.Customer_Identification = Customer.Customer_Identification
        ) 
        /* %JoinPKPK(Purchase_Order,:%New," = "," AND") */
         and Purchase_Order.Order_Number = :new.Order_Number;

    /* erwin Builtin Trigger */
    /* Store_Name  Purchase_Order on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Store_Name"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Store_Name_Purchase_Order", FK_COLUMNS="Store_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Store_Name
      WHERE
        /* %JoinFKPK(:%New,Store_Name," = "," AND") */
        :new.Store_Identification = Store_Name.Store_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Purchase_Order because Store_Name does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Purchase_Order AFTER UPDATE ON Purchase_Order for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Purchase_Order 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Purchase_Order  Order_Item on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00038450", PARENT_OWNER="", PARENT_TABLE="Purchase_Order"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Order_Order_Item", FK_COLUMNS="Order_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Number <> :new.Order_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Order_Item
      WHERE
        /*  %JoinFKPK(Order_Item,:%Old," = "," AND") */
        Order_Item.Order_Number = :old.Order_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Purchase_Order because Order_Item exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Customer  Purchase_Order on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Customer"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Customer_Purchase_Order", FK_COLUMNS="Customer_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Customer
    WHERE
      /* %JoinFKPK(:%New,Customer," = "," AND") */
      :new.Customer_Identification = Customer.Customer_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Customer_Identification IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Purchase_Order because Customer does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Store_Name  Purchase_Order on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Store_Name"
    CHILD_OWNER="", CHILD_TABLE="Purchase_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Store_Name_Purchase_Order", FK_COLUMNS="Store_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Store_Name
    WHERE
      /* %JoinFKPK(:%New,Store_Name," = "," AND") */
      :new.Store_Identification = Store_Name.Store_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Purchase_Order because Store_Name does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Order_Item AFTER DELETE ON Order_Item for each row
-- erwin Builtin Trigger
-- DELETE trigger on Order_Item 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Item  Order_Shipment on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00038190", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Order_Shipment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Order_Shipment", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Order_Shipment
      WHERE
        /*  %JoinFKPK(Order_Shipment,:%Old," = "," AND") */
        Order_Shipment.Order_Number = :old.Order_Number AND
        Order_Shipment.Item_Sequence_Number = :old.Item_Sequence_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Order_Item because Order_Shipment exists.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Order_Item  Book_Retrun on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Book_Retrun", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Order_Number = NULL,
        Book_Retrun.Item_Sequence_Number = NULL
      WHERE
        /* %JoinFKPK(Book_Retrun,:%Old," = "," AND") */
        Book_Retrun.Order_Number = :old.Order_Number AND
        Book_Retrun.Item_Sequence_Number = :old.Item_Sequence_Number;

    /* erwin Builtin Trigger */
    /* Order_Item  Royalty_History on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Royalty_History"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Royalty_History", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    UPDATE Royalty_History
      SET
        /* %SetFK(Royalty_History,NULL) */
        Royalty_History.Order_Number = NULL,
        Royalty_History.Item_Sequence_Number = NULL
      WHERE
        /* %JoinFKPK(Royalty_History,:%Old," = "," AND") */
        Royalty_History.Order_Number = :old.Order_Number AND
        Royalty_History.Item_Sequence_Number = :old.Item_Sequence_Number;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Order_Item BEFORE INSERT ON Order_Item for each row
-- erwin Builtin Trigger
-- INSERT trigger on Order_Item 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Book  Order_Item on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00034e98", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Order_Item", FK_COLUMNS="Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Book
      WHERE
        /* %JoinFKPK(:%New,Book," = "," AND") */
        :new.Book_Identification = Book.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Order_Item because Book does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Discount  Order_Item on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Discount"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Discount_Order_Item", FK_COLUMNS="Discount_Type" */
    UPDATE Order_Item
      SET
        /* %SetFK(Order_Item,NULL) */
        Order_Item.Discount_Type = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Discount
            WHERE
              /* %JoinFKPK(:%New,Discount," = "," AND") */
              :new.Discount_Type = Discount.Discount_Type
        ) 
        /* %JoinPKPK(Order_Item,:%New," = "," AND") */
         and Order_Item.Order_Number = :new.Order_Number AND
        Order_Item.Item_Sequence_Number = :new.Item_Sequence_Number;

    /* erwin Builtin Trigger */
    /* Purchase_Order  Order_Item on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase_Order"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Order_Order_Item", FK_COLUMNS="Order_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Purchase_Order
      WHERE
        /* %JoinFKPK(:%New,Purchase_Order," = "," AND") */
        :new.Order_Number = Purchase_Order.Order_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Order_Item because Purchase_Order does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Order_Item AFTER UPDATE ON Order_Item for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Order_Item 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Order_Item  Order_Shipment on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00076134", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Order_Shipment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Order_Shipment", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Number <> :new.Order_Number OR 
    :old.Item_Sequence_Number <> :new.Item_Sequence_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Order_Shipment
      WHERE
        /*  %JoinFKPK(Order_Shipment,:%Old," = "," AND") */
        Order_Shipment.Order_Number = :old.Order_Number AND
        Order_Shipment.Item_Sequence_Number = :old.Item_Sequence_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Order_Item because Order_Shipment exists.'
      );
    END IF;
  END IF;

  /* Order_Item  Book_Retrun on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Book_Retrun", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Number <> :new.Order_Number OR 
    :old.Item_Sequence_Number <> :new.Item_Sequence_Number
  THEN
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Order_Number = NULL,
        Book_Retrun.Item_Sequence_Number = NULL
      WHERE
        /* %JoinFKPK(Book_Retrun,:%Old," = ",",") */
        Book_Retrun.Order_Number = :old.Order_Number AND
        Book_Retrun.Item_Sequence_Number = :old.Item_Sequence_Number;
  END IF;

  /* Order_Item  Royalty_History on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Royalty_History"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Royalty_History", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Number <> :new.Order_Number OR 
    :old.Item_Sequence_Number <> :new.Item_Sequence_Number
  THEN
    UPDATE Royalty_History
      SET
        /* %SetFK(Royalty_History,NULL) */
        Royalty_History.Order_Number = NULL,
        Royalty_History.Item_Sequence_Number = NULL
      WHERE
        /* %JoinFKPK(Royalty_History,:%Old," = ",",") */
        Royalty_History.Order_Number = :old.Order_Number AND
        Royalty_History.Item_Sequence_Number = :old.Item_Sequence_Number;
  END IF;

  /* erwin Builtin Trigger */
  /* Book  Order_Item on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Book"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Book_Order_Item", FK_COLUMNS="Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Book
    WHERE
      /* %JoinFKPK(:%New,Book," = "," AND") */
      :new.Book_Identification = Book.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Order_Item because Book does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Discount  Order_Item on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Discount"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Discount_Order_Item", FK_COLUMNS="Discount_Type" */
  SELECT count(*) INTO NUMROWS
    FROM Discount
    WHERE
      /* %JoinFKPK(:%New,Discount," = "," AND") */
      :new.Discount_Type = Discount.Discount_Type;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Discount_Type IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Order_Item because Discount does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Purchase_Order  Order_Item on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Purchase_Order"
    CHILD_OWNER="", CHILD_TABLE="Order_Item"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchase_Order_Order_Item", FK_COLUMNS="Order_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Purchase_Order
    WHERE
      /* %JoinFKPK(:%New,Purchase_Order," = "," AND") */
      :new.Order_Number = Purchase_Order.Order_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Order_Item because Purchase_Order does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Royalty_History BEFORE INSERT ON Royalty_History for each row
-- erwin Builtin Trigger
-- INSERT trigger on Royalty_History 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Item  Royalty_History on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="000164ae", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Royalty_History"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Royalty_History", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    UPDATE Royalty_History
      SET
        /* %SetFK(Royalty_History,NULL) */
        Royalty_History.Order_Number = NULL,
        Royalty_History.Item_Sequence_Number = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Order_Item
            WHERE
              /* %JoinFKPK(:%New,Order_Item," = "," AND") */
              :new.Order_Number = Order_Item.Order_Number AND
              :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number
        ) 
        /* %JoinPKPK(Royalty_History,:%New," = "," AND") */
         and Royalty_History.Royalty_History_Identification = :new.Royalty_History_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Royalty_History AFTER UPDATE ON Royalty_History for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Royalty_History 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Order_Item  Royalty_History on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015db1", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Royalty_History"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Royalty_History", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Order_Item
    WHERE
      /* %JoinFKPK(:%New,Order_Item," = "," AND") */
      :new.Order_Number = Order_Item.Order_Number AND
      :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Order_Number IS NOT NULL AND
    :new.Item_Sequence_Number IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Royalty_History because Order_Item does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Book_Retrun BEFORE INSERT ON Book_Retrun for each row
-- erwin Builtin Trigger
-- INSERT trigger on Book_Retrun 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Item  Book_Retrun on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="000152b2", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Book_Retrun", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    UPDATE Book_Retrun
      SET
        /* %SetFK(Book_Retrun,NULL) */
        Book_Retrun.Order_Number = NULL,
        Book_Retrun.Item_Sequence_Number = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Order_Item
            WHERE
              /* %JoinFKPK(:%New,Order_Item," = "," AND") */
              :new.Order_Number = Order_Item.Order_Number AND
              :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number
        ) 
        /* %JoinPKPK(Book_Retrun,:%New," = "," AND") */
         and Book_Retrun.Book_Return_Identification = :new.Book_Return_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Book_Retrun AFTER UPDATE ON Book_Retrun for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Book_Retrun 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Order_Item  Book_Retrun on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001514e", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Book_Retrun"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Book_Retrun", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Order_Item
    WHERE
      /* %JoinFKPK(:%New,Order_Item," = "," AND") */
      :new.Order_Number = Order_Item.Order_Number AND
      :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Order_Number IS NOT NULL AND
    :new.Item_Sequence_Number IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Book_Retrun because Order_Item does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Order_Shipment AFTER DELETE ON Order_Shipment for each row
-- erwin Builtin Trigger
-- DELETE trigger on Order_Shipment 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Shipment  Back_Order on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00014de9", PARENT_OWNER="", PARENT_TABLE="Order_Shipment"
    CHILD_OWNER="", CHILD_TABLE="Back_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Shipment_Back_Order", FK_COLUMNS="Order_Shipment_Identifier""Order_Number""Item_Sequence_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Back_Order
      WHERE
        /*  %JoinFKPK(Back_Order,:%Old," = "," AND") */
        Back_Order.Order_Shipment_Identifier = :old.Order_Shipment_Identifier AND
        Back_Order.Order_Number = :old.Order_Number AND
        Back_Order.Item_Sequence_Number = :old.Item_Sequence_Number;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Order_Shipment because Back_Order exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Order_Shipment BEFORE INSERT ON Order_Shipment for each row
-- erwin Builtin Trigger
-- INSERT trigger on Order_Shipment 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Item  Order_Shipment on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001298c", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Order_Shipment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Order_Shipment", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Order_Item
      WHERE
        /* %JoinFKPK(:%New,Order_Item," = "," AND") */
        :new.Order_Number = Order_Item.Order_Number AND
        :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Order_Shipment because Order_Item does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Order_Shipment AFTER UPDATE ON Order_Shipment for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Order_Shipment 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Order_Shipment  Back_Order on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002f51f", PARENT_OWNER="", PARENT_TABLE="Order_Shipment"
    CHILD_OWNER="", CHILD_TABLE="Back_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Shipment_Back_Order", FK_COLUMNS="Order_Shipment_Identifier""Order_Number""Item_Sequence_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Order_Shipment_Identifier <> :new.Order_Shipment_Identifier OR 
    :old.Order_Number <> :new.Order_Number OR 
    :old.Item_Sequence_Number <> :new.Item_Sequence_Number
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Back_Order
      WHERE
        /*  %JoinFKPK(Back_Order,:%Old," = "," AND") */
        Back_Order.Order_Shipment_Identifier = :old.Order_Shipment_Identifier AND
        Back_Order.Order_Number = :old.Order_Number AND
        Back_Order.Item_Sequence_Number = :old.Item_Sequence_Number;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Order_Shipment because Back_Order exists.'
      );
    END IF;
  END IF;

  /* erwin Builtin Trigger */
  /* Order_Item  Order_Shipment on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Order_Item"
    CHILD_OWNER="", CHILD_TABLE="Order_Shipment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Item_Order_Shipment", FK_COLUMNS="Order_Number""Item_Sequence_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Order_Item
    WHERE
      /* %JoinFKPK(:%New,Order_Item," = "," AND") */
      :new.Order_Number = Order_Item.Order_Number AND
      :new.Item_Sequence_Number = Order_Item.Item_Sequence_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Order_Shipment because Order_Item does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Back_Order BEFORE INSERT ON Back_Order for each row
-- erwin Builtin Trigger
-- INSERT trigger on Back_Order 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Order_Shipment  Back_Order on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00015d41", PARENT_OWNER="", PARENT_TABLE="Order_Shipment"
    CHILD_OWNER="", CHILD_TABLE="Back_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Shipment_Back_Order", FK_COLUMNS="Order_Shipment_Identifier""Order_Number""Item_Sequence_Number" */
    SELECT count(*) INTO NUMROWS
      FROM Order_Shipment
      WHERE
        /* %JoinFKPK(:%New,Order_Shipment," = "," AND") */
        :new.Order_Shipment_Identifier = Order_Shipment.Order_Shipment_Identifier AND
        :new.Order_Number = Order_Shipment.Order_Number AND
        :new.Item_Sequence_Number = Order_Shipment.Item_Sequence_Number;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Back_Order because Order_Shipment does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Back_Order AFTER UPDATE ON Back_Order for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Back_Order 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Order_Shipment  Back_Order on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00015d22", PARENT_OWNER="", PARENT_TABLE="Order_Shipment"
    CHILD_OWNER="", CHILD_TABLE="Back_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Order_Shipment_Back_Order", FK_COLUMNS="Order_Shipment_Identifier""Order_Number""Item_Sequence_Number" */
  SELECT count(*) INTO NUMROWS
    FROM Order_Shipment
    WHERE
      /* %JoinFKPK(:%New,Order_Shipment," = "," AND") */
      :new.Order_Shipment_Identifier = Order_Shipment.Order_Shipment_Identifier AND
      :new.Order_Number = Order_Shipment.Order_Number AND
      :new.Item_Sequence_Number = Order_Shipment.Item_Sequence_Number;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Back_Order because Order_Shipment does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Payment AFTER DELETE ON Payment for each row
-- erwin Builtin Trigger
-- DELETE trigger on Payment 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Payment  Personal_Check on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00024d71", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Personal_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Personal_Check", FK_COLUMNS="Payment_Number" */
    DELETE FROM Personal_Check
      WHERE
        /*  %JoinFKPK(Personal_Check,:%Old," = "," AND") */
        Personal_Check.Payment_Number = :old.Payment_Number;

    /* erwin Builtin Trigger */
    /* Payment  Money_Order on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Money_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Money_Order", FK_COLUMNS="Payment_Number" */
    DELETE FROM Money_Order
      WHERE
        /*  %JoinFKPK(Money_Order,:%Old," = "," AND") */
        Money_Order.Payment_Number = :old.Payment_Number;

    /* erwin Builtin Trigger */
    /* Payment  Credit_Card on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Credit_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Credit_Card", FK_COLUMNS="Payment_Number" */
    DELETE FROM Credit_Card
      WHERE
        /*  %JoinFKPK(Credit_Card,:%Old," = "," AND") */
        Credit_Card.Payment_Number = :old.Payment_Number;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Payment AFTER UPDATE ON Payment for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Payment 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Payment  Personal_Check on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00034f99", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Personal_Check"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Personal_Check", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Personal_Check
      SET
        /*  %JoinFKPK(Personal_Check,:%New," = ",",") */
        Personal_Check.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Personal_Check,:%Old," = "," AND") */
        Personal_Check.Payment_Number = :old.Payment_Number;
  END IF;

  /* erwin Builtin Trigger */
  /* Payment  Money_Order on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Money_Order"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Money_Order", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Money_Order
      SET
        /*  %JoinFKPK(Money_Order,:%New," = ",",") */
        Money_Order.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Money_Order,:%Old," = "," AND") */
        Money_Order.Payment_Number = :old.Payment_Number;
  END IF;

  /* erwin Builtin Trigger */
  /* Payment  Credit_Card on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="Credit_Card"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Payment_Credit_Card", FK_COLUMNS="Payment_Number" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Payment_Number <> :new.Payment_Number
  THEN
    UPDATE Credit_Card
      SET
        /*  %JoinFKPK(Credit_Card,:%New," = ",",") */
        Credit_Card.Payment_Number = :new.Payment_Number
      WHERE
        /*  %JoinFKPK(Credit_Card,:%Old," = "," AND") */
        Credit_Card.Payment_Number = :old.Payment_Number;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Region AFTER DELETE ON Region for each row
-- erwin Builtin Trigger
-- DELETE trigger on Region 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Region  Store_Name on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000db24", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Store_Name"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Region_Store_Name", FK_COLUMNS="Region_Identification" */
    UPDATE Store_Name
      SET
        /* %SetFK(Store_Name,NULL) */
        Store_Name.Region_Identification = NULL
      WHERE
        /* %JoinFKPK(Store_Name,:%Old," = "," AND") */
        Store_Name.Region_Identification = :old.Region_Identification;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Region AFTER UPDATE ON Region for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Region 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Region  Store_Name on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00011201", PARENT_OWNER="", PARENT_TABLE="Region"
    CHILD_OWNER="", CHILD_TABLE="Store_Name"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Region_Store_Name", FK_COLUMNS="Region_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Region_Identification <> :new.Region_Identification
  THEN
    UPDATE Store_Name
      SET
        /* %SetFK(Store_Name,NULL) */
        Store_Name.Region_Identification = NULL
      WHERE
        /* %JoinFKPK(Store_Name,:%Old," = ",",") */
        Store_Name.Region_Identification = :old.Region_Identification;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER  tD_Royalty AFTER DELETE ON Royalty for each row
-- erwin Builtin Trigger
-- DELETE trigger on Royalty 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Royalty  Royalty_Payment on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001000d", PARENT_OWNER="", PARENT_TABLE="Royalty"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Royalty_Royalty_Payment", FK_COLUMNS="Royalty_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Royalty_Payment
      WHERE
        /*  %JoinFKPK(Royalty_Payment,:%Old," = "," AND") */
        Royalty_Payment.Royalty_Identification = :old.Royalty_Identification;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete Royalty because Royalty_Payment exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Royalty AFTER UPDATE ON Royalty for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Royalty 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Royalty  Royalty_Payment on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00013b8f", PARENT_OWNER="", PARENT_TABLE="Royalty"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Royalty_Royalty_Payment", FK_COLUMNS="Royalty_Identification" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Royalty_Identification <> :new.Royalty_Identification
  THEN
    SELECT count(*) INTO NUMROWS
      FROM Royalty_Payment
      WHERE
        /*  %JoinFKPK(Royalty_Payment,:%Old," = "," AND") */
        Royalty_Payment.Royalty_Identification = :old.Royalty_Identification;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update Royalty because Royalty_Payment exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Royalty_Payment BEFORE INSERT ON Royalty_Payment for each row
-- erwin Builtin Trigger
-- INSERT trigger on Royalty_Payment 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* BookAuthor  Royalty_Payment on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00026435", PARENT_OWNER="", PARENT_TABLE="BookAuthor"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuthor_Royalty_Payment", FK_COLUMNS="Author_Identification""Book_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM BookAuthor
      WHERE
        /* %JoinFKPK(:%New,BookAuthor," = "," AND") */
        :new.Author_Identification = BookAuthor.Author_Identification AND
        :new.Book_Identification = BookAuthor.Book_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Royalty_Payment because BookAuthor does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Royalty  Royalty_Payment on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Royalty"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Royalty_Royalty_Payment", FK_COLUMNS="Royalty_Identification" */
    SELECT count(*) INTO NUMROWS
      FROM Royalty
      WHERE
        /* %JoinFKPK(:%New,Royalty," = "," AND") */
        :new.Royalty_Identification = Royalty.Royalty_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Royalty_Payment because Royalty does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Royalty_Payment AFTER UPDATE ON Royalty_Payment for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Royalty_Payment 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* BookAuthor  Royalty_Payment on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00026d53", PARENT_OWNER="", PARENT_TABLE="BookAuthor"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BookAuthor_Royalty_Payment", FK_COLUMNS="Author_Identification""Book_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM BookAuthor
    WHERE
      /* %JoinFKPK(:%New,BookAuthor," = "," AND") */
      :new.Author_Identification = BookAuthor.Author_Identification AND
      :new.Book_Identification = BookAuthor.Book_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Royalty_Payment because BookAuthor does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Royalty  Royalty_Payment on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Royalty"
    CHILD_OWNER="", CHILD_TABLE="Royalty_Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Royalty_Royalty_Payment", FK_COLUMNS="Royalty_Identification" */
  SELECT count(*) INTO NUMROWS
    FROM Royalty
    WHERE
      /* %JoinFKPK(:%New,Royalty," = "," AND") */
      :new.Royalty_Identification = Royalty.Royalty_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Royalty_Payment because Royalty does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_Reporting_Structure BEFORE INSERT ON Reporting_Structure for each row
-- erwin Builtin Trigger
-- INSERT trigger on Reporting_Structure 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* Employee  Reporting_Structure on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0002346a", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
    SELECT count(*) INTO NUMROWS
      FROM Employee
      WHERE
        /* %JoinFKPK(:%New,Employee," = "," AND") */
        :new.Reports_To = Employee.Employee_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reporting_Structure because Employee does not exist.'
      );
    END IF;

    /* erwin Builtin Trigger */
    /* Employee  Reporting_Structure on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
    SELECT count(*) INTO NUMROWS
      FROM Employee
      WHERE
        /* %JoinFKPK(:%New,Employee," = "," AND") */
        :new.Manager = Employee.Employee_Identification;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reporting_Structure because Employee does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_Reporting_Structure AFTER UPDATE ON Reporting_Structure for each row
-- erwin Builtin Trigger
-- UPDATE trigger on Reporting_Structure 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* Employee  Reporting_Structure on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002326f", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_ReportTo", FK_COLUMNS="Reports_To" */
  SELECT count(*) INTO NUMROWS
    FROM Employee
    WHERE
      /* %JoinFKPK(:%New,Employee," = "," AND") */
      :new.Reports_To = Employee.Employee_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reporting_Structure because Employee does not exist.'
    );
  END IF;

  /* erwin Builtin Trigger */
  /* Employee  Reporting_Structure on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Reporting_Structure"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Employee_Manager", FK_COLUMNS="Manager" */
  SELECT count(*) INTO NUMROWS
    FROM Employee
    WHERE
      /* %JoinFKPK(:%New,Employee," = "," AND") */
      :new.Manager = Employee.Employee_Identification;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reporting_Structure because Employee does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/


