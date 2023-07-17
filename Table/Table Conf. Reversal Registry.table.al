table 18014250 "Table Conf. Reversal Registry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Source Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(2; "Flag Log"; Boolean) { }
    }

    keys
    {
        key(Key1; "Source Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}