tableextension 52108 "HMP Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(52100; "HMP Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header Archive"."Sell-to Customer Name" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }
        field(52101; "HMP External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header Archive"."External Document No." where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }

    }
}
