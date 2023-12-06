pageextension 52102 "HMP Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("HMP Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                Tooltip = 'Specifies Vendor Shipment No. of Purchase order';
            }
        }
    }
}
