tableextension 52103 "HMP Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
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
