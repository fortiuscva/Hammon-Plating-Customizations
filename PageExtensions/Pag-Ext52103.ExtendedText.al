pageextension 52103 "HMP Extended Text" extends "Extended Text"
{
    layout
    {
        addafter("Ending Date")
        {
            field("HMP CoC"; Rec."HMP COC")
            {
                ApplicationArea = All;
            }
        }
    }
}
