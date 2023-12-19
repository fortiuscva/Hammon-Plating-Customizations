tableextension 52106 "HMP Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(52100; "HMP Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Header"."Sell-to Customer Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(52101; "HMP External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Shipment Header"."External Document No." where("No." = field("Document No.")));
            Editable = false;
        }

    }
    var
        SalesSh: Record "Sales Shipment Header";
}
