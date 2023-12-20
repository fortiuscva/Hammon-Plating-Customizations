tableextension 52109 "HMP Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(52100; "HMP Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Sell-to Customer Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(52101; "HMP External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."External Document No." where("No." = field("Document No.")));
            Editable = false;
        }

    }
}
