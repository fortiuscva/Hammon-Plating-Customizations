pageextension 52104 "HMP Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        addafter("No.")
        {
            field("HMP Item type"; Rec."HMP Item type")
            {
                ApplicationArea = all;
                ToolTip = 'Specified the value of Item type field from Item.';
            }
        }
    }
}
