#f:: {
    winState := WinGetMinMax("A")
    if (winState = 1) {
        WinRestore("A")
    } else {
        WinMaximize("A")
    }
}

#q::  ; Win + Q: Close window (Alt+F4)
{
    Send "!{F4}"
}

#t::  ; Win + T: Open Windows Terminal
{
    Run "wt.exe"
}

#e::  ; Win + E: Open Files Community
{
    Run "files-preview.exe"
}
