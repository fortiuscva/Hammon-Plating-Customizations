pageextension 52106 "Posted Sales Shipment Lines" extends "Posted Sales Shipment Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("HMP Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("HMP Sell-to Customer Name"; Rec."HMP Sell-to Customer Name")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("HMP Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("HMP External Document No."; Rec."HMP External Document No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
}
