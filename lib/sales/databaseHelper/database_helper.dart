import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper.internal();

  static final DBHelper dbHelper = DBHelper.internal();

  factory DBHelper() => dbHelper;
  static const businessTable = 'businessTable';
  static const loginTable = 'loginTable';
  static const loginStatus = 'loginStatus';
  static const territoryTable = 'territoryTable';
  static const tsoInfoTable = 'tsoInfoTable';
  static const dealerTable = 'dealerTable';
  static const productNature = 'productNature';
  static const productTable = 'productTable';
  static const productAccessories = 'productAccessories';
  static const caCusPrice = 'caCusPrice';
  static const cartTable = 'cartTable';
  static const cartDetailsTable = 'cartDetailsTable';
  static const cartAccessoriesTable = 'cartAccessoriesTable';
  static const giftItem = 'giftItem';
  static const promoHeader = 'promoHeader';
  static const promoDetails = 'promoDetails';
  static const caCusDisc = 'caCusDisc';
  static const workNoteTable = 'addWorkNote';
  //static const workNoteTable = 'workNote';
  static const dealerVisitTable = 'dealerVisitTable';

  //deposit entry tables
  static const bankTable = 'bankTable';
  static const paymentTable = 'paymentTable';
  static const invoiceTable = 'invoiceTable';
  static const depositTable = 'depositTable';

  static const lastSyncTime = 'lastSyncTime';


  static final _version = 1;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'salesforce.db');
    print(dbPath);
    var openDb = await openDatabase(dbPath, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute("""
        CREATE TABLE $businessTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(150), 
          zorg VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $loginTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          xname VARCHAR(150), 
          xstaff VARCHAR(150), 
          xdeptname VARCHAR(150), 
          xposition VARCHAR(150), 
          xempbank VARCHAR(150),
          xacc VARCHAR(150),
          xsex VARCHAR(150),
          xempcategory VARCHAR(150),
          xrole VARCHAR(150),
          zemail VARCHAR(150),
          xpassword VARCHAR(150),
          xdesignation VARCHAR(150),
          xsid VARCHAR(150),
          supname VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $loginStatus (
          loginStatus TEXT 
          )""");
      await db.execute("""
        CREATE TABLE $territoryTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(150),
          xterritory VARCHAR(150),
          xtso VARCHAR(150), 
          xzone VARCHAR(150), 
          xzm VARCHAR(150), 
          xdivision VARCHAR(150), 
          xdm VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $tsoInfoTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(150),
          achievement VARCHAR(150),
          target VARCHAR(150),
          totalSO VARCHAR(150),
          totalDPnum VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $dealerTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER , 
          xcus VARCHAR(150), 
          xorg VARCHAR(150),
          xphone VARCHAR(150),
          xmadd VARCHAR(150), 
          xgcus VARCHAR(150),
          xterritory VARCHAR(150),
          xcontact VARCHAR(150),
          xmobile VARCHAR(150),
          xtso VARCHAR(150),
          xzone VARCHAR(150),
          xzm VARCHAR(150),
          xdivision VARCHAR(150),
          xdm VARCHAR(150),
          xthana VARCHAR(150),
          xdistrict VARCHAR(150),
          xdisc VARCHAR(150),
          xdiscdetamt VARCHAR(150),
          xtype VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $productNature (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER , 
          xcode VARCHAR(150),
          xlong VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $productTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER , 
          xitem VARCHAR(150), 
          xdesc VARCHAR(150), 
          mainRate VARCHAR(150), 
          xrate VARCHAR(150), 
          xdealerp VARCHAR(150), 
          xmrp VARCHAR(150),
          xcolor VARCHAR(150),
          color VARCHAR(150),
          xdisc VARCHAR(150),
          xcapacity VARCHAR(150),
          xunit VARCHAR(150), 
          xunitsel VARCHAR(150), 
          xcatitem VARCHAR(150), 
          xstype VARCHAR(150), 
          stype VARCHAR(150), 
          xpnature VARCHAR(150),
          xdateeff VARCHAR(150),
          xdateexp VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $productAccessories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER,
          xrow VARCHAR(150),
          xitem VARCHAR(150), 
          xitemaccessories VARCHAR(150),
          name VARCHAR(150),
          xunit VARCHAR(150),
          xqty VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $caCusPrice (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          xrow VARCHAR(150), 
          xcus VARCHAR(150), 
          xitem VARCHAR(150), 
          xrate VARCHAR(150), 
          xcost VARCHAR(150),
          xdateeff VARCHAR(150),
          xdateexp VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $cartTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER,
          cartID VARCHAR(50),
          xcus VARCHAR(50),
          xtso VARCHAR(50),
          xorg VARCHAR(150),
          xterritory VARCHAR(150),
          xopincapply VARCHAR(10),
          total REAL,
          xdisctype VARCHAR(20),
          xfwh VARCHAR(50),
          xdm VARCHAR(50), 
          xdivision VARCHAR(150),
          xzm VARCHAR(50),
          xzone VARCHAR(50), 
          xpnature VARCHAR(150),
          lattitude VARCHAR(150),
          longitude VARCHAR(150),
          xstatus VARCHAR(150),
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )""");
      await db.execute("""
        CREATE TABLE $cartDetailsTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER,
          cartID VARCHAR(150) NOT NULL,          
          xitem VARCHAR(150),          
          xdesc VARCHAR(150),
          xunit VARCHAR(150),
          xcolor VARCHAR(50),
          xstype VARCHAR(50),
          xrate REAL,
          xdisc REAL,
          xdiscamt REAL,
          xdiscad REAL,
          xdiscadamt REAL,
          xlineamt REAL,
          xqty REAL,
          subTotal REAL,
          giftStatus VARCHAR(20),
          yes_no VARCHAR(20),
          xmasteritem VARCHAR(20),
          xnote VARCHAR(20),
          FOREIGN KEY (cartID) REFERENCES $cartTable(cartID)
          )""");
      await db.execute("""
          CREATE TABLE $cartAccessoriesTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER,         
          xitem VARCHAR(150),          
          accName VARCHAR(150),
          xqty REAL,
          xunit VARCHAR(150),
          xmasteritem VARCHAR(150)
        )
        """);
      await db.execute("""
        CREATE TABLE $giftItem (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid INTEGER,          
          xrow VARCHAR(150),          
          xwh VARCHAR(150),
          xitem VARCHAR(150),
          xgiftitem VARCHAR(150),
          xqty VARCHAR(150),
          xqtybonus VARCHAR(150),
          xdateeff VARCHAR(150),
          xdateexp VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $promoHeader (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(10),          
          xtrnnum VARCHAR(50),          
          xstype VARCHAR(20),
          xfdate VARCHAR(20),
          xtdate VARCHAR(20),
          xref VARCHAR(20)
          )""");
      await db.execute("""
        CREATE TABLE $promoDetails (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(10),          
          xrow INTEGER,          
          xtrnnum VARCHAR(50),
          xstype VARCHAR(20),
          xcolor VARCHAR(20),
          xtype VARCHAR(20),
          xfslab VARCHAR(20),
          xtslab VARCHAR(20),
          xamount VARCHAR(20)
          )""");
      await db.execute("""
        CREATE TABLE $caCusDisc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          zid VARCHAR(10),          
          xcus VARCHAR(50),          
          xitem VARCHAR(20),
          xdisc VARCHAR(20),
          xdateeff VARCHAR(20),
          xdateexp VARCHAR(20)
          )""");
      await db.execute("""
        CREATE TABLE $workNoteTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,     
          tsoId VARCHAR(150),          
          note VARCHAR(150),         
          subtitle VARCHAR(150),         
          createdAt VARCHAR(150)
          )""");

      // await db.execute("""
      //   CREATE TABLE $workNoteTable (
      //     id INTEGER PRIMARY KEY AUTOINCREMENT,
      //     tsoId VARCHAR(150),
      //     note VARCHAR(150),
      //     subtitle VARCHAR(150),
      //     createdAt VARCHAR(150)
      //     )""");
      await db.execute("""
        CREATE TABLE $dealerVisitTable (
          id INTEGER PRIMARY KEY,
          tsoId VARCHAR(150),
          dealerName VARCHAR(150),   
          xidsup VARCHAR(150),       
          xdate VARCHAR(150),         
          InTime VARCHAR(150),
          Latitude VARCHAR(150),
          Longitude VARCHAR(150),
          location VARCHAR(150),
          ImagePath VARCHAR(150)
          )""");
      await db.execute("""
        CREATE TABLE $bankTable (
          id INTEGER PRIMARY KEY,
          zid VARCHAR(10),
          xbank VARCHAR(100),
          xname VARCHAR(100),
          xbacc VARCHAR(100),
          xacc VARCHAR(100)
          )""");
      await db.execute("""
        CREATE TABLE $paymentTable (
          id INTEGER PRIMARY KEY,
          zid VARCHAR(10),
          xcode VARCHAR(100)
          )""");
      await db.execute("""
        CREATE TABLE $depositTable (
          id INTEGER PRIMARY KEY,
          depositID VARCHAR(20),
          zid VARCHAR(10),
          zauserid VARCHAR(150),
          xterritory VARCHAR(150),
          xtso VARCHAR(150),
          xpreparer VARCHAR(150),
          xdm VARCHAR(150),
          xdivision VARCHAR(150),
          xzm VARCHAR(150),
          xzone VARCHAR(150),
          xcus VARCHAR(150),
          xcusname VARCHAR(150),
          xamount VARCHAR(150),
          xarnature VARCHAR(150),
          xpaymenttype VARCHAR(150),
          xbank VARCHAR(150),
          bankCode VARCHAR(150),
          xbranch VARCHAR(150),
          xcusbank VARCHAR(150),
          xchequeno VARCHAR(150),
          xdate VARCHAR(150),
          xnote VARCHAR(150),
          xstatus VARCHAR(150)
          )""");

      await db.execute("""
        CREATE TABLE $lastSyncTime (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          syncFeature VARCHAR(150),
          time VARCHAR(150)
          )""");

    }, onUpgrade: (Database db, int oldversion, int newversion) async {
      if (oldversion < newversion) {
        print("Version Upgrade");
      }
    });
    return openDb;
  }
}
