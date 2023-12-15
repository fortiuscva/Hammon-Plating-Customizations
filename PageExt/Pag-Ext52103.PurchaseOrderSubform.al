pageextension 52103 "HMP Purchase Order Subform" extends "Purchase Order Subform"
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
