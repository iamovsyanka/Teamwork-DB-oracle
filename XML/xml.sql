create or replace directory UTLDATA AS 'C:/app/xml/';

create or replace procedure ExportUsersToXml is
  DOC DBMS_XMLDOM.DOMDocument;                                                                                        
  XDATA  XMLTYPE;                                                                                                                                                                                                                
  CURSOR XMLCUR IS                                                                                                     
    SELECT XMLELEMENT("USERS",    
      XMLAttributes('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",                        
      'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation"),
      XMLAGG(XMLELEMENT("USER",
        XMLELEMENT("ID",U.ID),
        xmlelement("NAME",u.username),
        xmlelement("EMAIL",u.email),
        xmlelement("PASSWORD",u.password),
        XMLELEMENT("ROLEID",U.roleId)
      ))                                                                                                                                   
) FROM USERS U; 
BEGIN
  OPEN XMLCUR;
    LOOP 
      FETCH XMLCUR INTO XDATA;                                                                                             
    EXIT WHEN XMLCUR%NOTFOUND;
    END LOOP;
  CLOSE XMLCUR;                                                                                                        
  DOC := DBMS_XMLDOM.NewDOMDocument(XDATA);                                                                            
  DBMS_XMLDOM.WRITETOFILE(DOC, 'UTLDATA/users.xml');
END;

begin
  ExportUsersToXml();
end;

create or replace procedure ImportUsersFromXml
IS
  L_CLOB CLOB;
  L_BFILE  BFILE := BFILENAME('UTLDATA', 'users.xml');
  
  L_DEST_OFFSET   INTEGER := 1;
  L_SRC_OFFSET    INTEGER := 1;
  L_BFILE_CSID    NUMBER  := 0;
  L_LANG_CONTEXT  INTEGER := 0;
  L_WARNING       INTEGER := 0;
  
  P                DBMS_XMLPARSER.PARSER;
  v_doc            dbms_xmldom.domdocument;
  v_root_element   dbms_xmldom.domelement;
  V_CHILD_NODES    DBMS_XMLDOM.DOMNODELIST;
  V_CURRENT_NODE   DBMS_XMLDOM.DOMNODE;
   
  u users%rowtype;
begin
  DBMS_LOB.CREATETEMPORARY (L_CLOB, TRUE);
  DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
  
  DBMS_LOB.LOADCLOBFROMFILE (DEST_LOB => L_CLOB, SRC_BFILE => L_BFILE, AMOUNT => DBMS_LOB.LOBMAXSIZE,
    DEST_OFFSET => L_DEST_OFFSET, SRC_OFFSET => L_SRC_OFFSET, BFILE_CSID => L_BFILE_CSID,
    LANG_CONTEXT => L_LANG_CONTEXT, WARNING => L_WARNING);
  DBMS_LOB.FILECLOSE(L_BFILE);
  COMMIT;
   P := Dbms_Xmlparser.Newparser;                     
   DBMS_XMLPARSER.PARSECLOB(P,L_CLOB);      
   V_DOC := DBMS_XMLPARSER.GETDOCUMENT(P);
   V_ROOT_ELEMENT := DBMS_XMLDOM.Getdocumentelement(v_Doc);
   V_CHILD_NODES := DBMS_XMLDOM.GETCHILDRENBYTAGNAME(V_ROOT_ELEMENT,'*');
  
   FOR i IN 0 .. DBMS_XMLDOM.GETLENGTH(V_CHILD_NODES) - 1
   LOOP
      V_CURRENT_NODE := DBMS_XMLDOM.ITEM(V_CHILD_NODES,i);
     
      DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,
        'ID/text()',U.ID);
      Dbms_Xslprocessor.Valueof(V_Current_Node,
        'NAME/text()',U.USERNAME);
      Dbms_Xslprocessor.Valueof(V_Current_Node,
        'EMAIL/text()',U.EMAIL);
      dbms_xslprocessor.valueof(v_current_node,
        'PASSWORD/text()',U.password);
      DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE,
        'ROLEID/text()',U.ROLEID);
      
      insert into Users(Username,Email,password,Roleid) 
        values(U.USERNAME,U.EMAIL,U.password,U.ROLEID);
   end loop;
  
  DBMS_LOB.FREETEMPORARY(L_CLOB);
  DBMS_XMLPARSER.FREEPARSER(P);
  DBMS_XMLDOM.FREEDOCUMENT(V_DOC);
  commit;
END;

BEGIN
  ImportUsersFromXml();
END;

select * from USERS;