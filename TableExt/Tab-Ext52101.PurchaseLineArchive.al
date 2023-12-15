tableextension 52101 "HMP Purchase Line Archive" extends "Purchase Line Archive"
{
    fields
    {
        field(52100; "HMP Item type"; Enum "Item Type")
        {
            Caption = 'Item type';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Type where("No." = field("No.")));
            Editable = false;
        }
    }
}
