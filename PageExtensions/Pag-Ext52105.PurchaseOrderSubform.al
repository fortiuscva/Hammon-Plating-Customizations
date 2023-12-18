pageextension 52105 "HMP Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("HMP Item type"; ItemTypeLcl)
            {
                Caption = 'Item type';
                ApplicationArea = all;
                ToolTip = 'Specified the value of Item type field from Item.';
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(ItemTypeLcl);
        if (rec.Type = rec.Type::Item) and (Rec."No." <> '') then
            ItemTypeLcl := GeneralFunctionsCULcl.GetItemType(rec."No.")
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(ItemTypeLcl);
        if (rec.Type = rec.Type::Item) and (Rec."No." <> '') then
            ItemTypeLcl := GeneralFunctionsCULcl.GetItemType(rec."No.")
    end;

    var
        GeneralFunctionsCULcl: Codeunit "HMP General Functions";
        ItemTypeLcl: Text;
}
