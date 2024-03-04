using { Currency, managed, sap } from '@sap/cds/common';
namespace sap.capire.bookshop;

// define entity Employees {
//   key ID : Integer;
//   name : String;
//   Designation : String;
// }

// define type User : String(111);
// define type Amount {
//   value : Decimal(10,3);
//   currency : Currency;
// }

// entity Mar { 
//   emails: many String; 
// }
// entity Bar { 
//   emails: many { kind:String; address:String; }; 
// }
// entity Car { 
//   emails: many EmailAddress; 
// }

// type EmailAddresses : many { 
//   kind:String; 
//   address:String; 
// }
// type EmailAddress : { 
//   kind:String; 
//   address:String; 
// }

entity Books : managed {
  key ID : Integer;
  @mandatory title  : localized String(100);
  descr  : localized String(1000);
  @mandatory author : Association to Authors;
  genre  : Association to Genres;
  stock  : Integer;
  price  : Decimal;
  currency : Currency;
  image : LargeBinary @Core.MediaType : 'image/png';
}

entity Authors : managed {
  key ID : Integer;
  @mandatory name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}
