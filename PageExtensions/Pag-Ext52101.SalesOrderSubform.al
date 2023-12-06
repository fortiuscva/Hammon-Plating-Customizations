pageextension 52101 "HMP Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("HMP Package Tracking No."; Rec."Package Tracking No.")
            {
                ApplicationArea = all;
                Tooltip = 'Specifies the Package Tracking No. of Sales Line';
            }
        }
    }
}
