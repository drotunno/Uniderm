report 18014500 ImportData
{
    Caption = 'ImportData';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './report/Rdl/ImportData.rdlc';

    /*dataset
    {
        dataitem("Table Metadata"; "Table Metadata")
        {
            //DataItemTableView = SORTING("No.");
            RequestFilterFields = ID, DataPerCompany;
            DataItemTableView = sorting(ID) where(DataPerCompany = const(true));
            column(IdTabell; id) { }
            column(Errore; ExternalName) { }
            trigger OnPreDataItem()
            begin
                Wind.OPEN('Copia tabella nr. #1####');

                ActiveSess.SETRANGE("Server Instance ID", SERVICEINSTANCEID);
                ActiveSess.SETRANGE("Session ID", SESSIONID);
                ActiveSess.FINDFIRST;

                BcstrConn := 'Server=' + ActiveSess."Server Computer Name" + ';Database=' + ActiveSess."Database Name" +
                             ';User Id=sa;Password=0mni@sa;';

                BCConn := BCConn.SqlConnection(BcStrConn);
                BCConn.Open();
                IF NomeServer = '' THEN
                    NomeServer := ActiveSess."Server Computer Name";

                IF NomeSoc = '' THEN
                    NomeSoc := COMPANYNAME;

                NAVstrConn := 'Server=' + NomeServer + ';Database=' + NomeDB + ';User Id=sa;Password=0mni@sa;';
                NavConn := NavConn.SqlConnection(NavStrConn);
                NavConn.Open();
            end;

            trigger OnAfterGetRecord()
            begin
                CLEARLASTERROR;
                Wind.UPDATE(1, "Table Metadata".ID);

                MakeSql;
                cu_ImpData.SetParam(SqlCommand, strSql);
                IF cu_ImpData.RUN THEN
                    CurrReport.SKIP;

                ExternalName := COPYSTR(GETLASTERRORTEXT, 1, 150)
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Document)
                {
                    field(NomeServer; NomeServer)
                    {
                        ApplicationArea = All;
                        Caption = 'Nome Server';
                    }
                    field(NomeDB; NomeDB)
                    {
                        ApplicationArea = All;
                        Caption = 'Nome DB';
                    }
                    field(NomeSoc; NomeSoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Nome Società';
                    }
                }
            }
        }
    }

    local procedure MakeSql()
    var
        NomeTabSql, NomeTabSqlDest, NomeCampo, NomeTab : text[100];
        strFieldsDest, strFieldsOrig : text;
        TabIdentity: Boolean;
        l_Field: Record Field;
    begin
        clear(cu_ImpData);
        NomeTab := CONVERTSTR(NomeSoc + '$' + "Table Metadata".Name, '."\/''%', '______');
        NomeTabSqlDest := '[' + CONVERTSTR(COMPANYNAME + '$' + "Table Metadata".Name, '."\/''%', '______') + ']';

        NomeTabSql := '[' + NomeTab + ']';

        SQLCommand := NavConn.CreateCommand();
        CLEAR(strFieldsDest);
        CLEAR(strFieldsOrig);
        l_Field.SETRANGE(TableNo, "Table Metadata".ID);
        l_Field.SETRANGE(Class, l_Field.Class::Normal);
        l_Field.SETRANGE(Enabled, TRUE);
        IF l_Field.FINDSET THEN begin
            repeat
                NomeCampo := CONVERTSTR(l_Field.FieldName, '."\/''%', '______');
                SQLCommand.CommandText := 'select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME=''' + NomeTab +
                                          ''' and COLUMN_NAME=''' + NomeCampo + '''';
                SqlReader := SqlCommand.ExecuteReader();
                strFieldsDest += '[' + CONVERTSTR(l_Field.FieldName, '."\/''%', '______') + '],';
                if not SQLReader.Read() then BEGIN
                    CASE SQLReader.GetString(0) OF
                        'sql_variant':
                            NomeCampo := 'Convert(varchar,[' + NomeCampo + ']),';
                        ELSE
                            NomeCampo := '[' + NomeCampo + '],';
                    END;

                    strFieldsOrig += NomeCampo
                END
                ELSE BEGIN
                    CASE l_Field.Type OF
                        l_Field.Type::Boolean, l_Field.Type::Decimal, l_Field.Type::Integer, l_Field.Type::Option:
                            strFieldsOrig += '0,';
                        ELSE
                            strFieldsOrig += ''''',';
                    END
                END;
            UNTIL l_Field.NEXT = 0;

            strSql := 'select t.name as TableName,c.name as ColumnName from sys.identity_columns c inner join sys.tables t ' +
                      'on c.object_id = t.object_id where t.name = ''' + NomeTab + '''';

            SqlCommand.CommandText := strSql;
            SqlReader := SqlCommand.ExecuteReader();
            TabIdentity := SqlReader.HasRows;

            IF strFieldsDest <> '' THEN BEGIN
                strFieldsDest := COPYSTR(strFieldsDest, 1, STRLEN(strFieldsDest) - 1);
                strFieldsOrig := COPYSTR(strFieldsOrig, 1, STRLEN(strFieldsOrig) - 1);
            END;

            SqlCommand.CommandText := 'delete from ' + NomeTabSqlDest;
            SqlCommand.ExecuteNonQuery();
            if TabIdentity then begin
                SqlCommand.CommandText := 'SET IDENTITY_INSERT ' + NomeTabSqlDest + ' ON';
                SqlCommand.ExecuteNonQuery()
            end;

            strSql := 'Insert into ' + NomeTabSqlDest + ' (' + strFieldsDest + ') select ' + strFieldsOrig +
                      ' from [' + NomeServer + '].' + NomeDB + '.dbo.' + NomeTabSql;

            IF TabIdentity THEN
                strSql += ' SET IDENTITY_INSERT ' + NomeTabSqlDest + ' OFF'
        end
    end;

    var
        Wind: Dialog;
        NomeServer, NomeDB, NomeSoc : Text[30];
        ActiveSess: Record "Active Session";
        IdCampo, NrRec : Integer;
        SQL_BcDataSet, SQL_NAVDataSet : DotNet SQLDataSet;
        SQL_BcDataAdapter, SQL_NAVDataAdapter : DotNet SQLDataAdapter;
        SqlCommand: DotNet SQLCommand;
        SqlReader: DotNet SQLReader;
        BCConn: DotNet SQLConnection;
        NavConn: DotNet SQLConnection;
        BcStrConn, NavStrConn : Text[100];
        strSql: Text;
        cu_ImpData: Codeunit importData;*/
}