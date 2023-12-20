tableextension 52107 "HMP Sales Line" extends "Sales Line"
{
    fields
    {
        field(52100; "HMP Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }
        field(52101; "HMP External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."External Document No." where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }

    }
}
