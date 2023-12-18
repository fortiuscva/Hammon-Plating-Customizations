tableextension 52105 "HMP Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
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
