import PySimpleGUI as sg

file_list_column = [
    [
        sg.Text("Input SVG file"),
        sg.In(size=(25, 1), enable_events=True, key="-Input SVG-"),
        sg.FileBrowse(),
    ],
    [
        sg.Text("Output SVG name"),
        sg.In(size=(25, 1), enable_events=True, key="-Output SVG-")
    ],
    [
        sg.Text("TrackDiag Init .st"),
        sg.In(size=(25, 1), enable_events=True, key="-TrackDiagSt-"),
        sg.FileBrowse(),
    ],
    [
        sg.Button(button_text="Generate TrakMap Files")
    ]
]
# For now will only show the name of the file that was chosen

layout = [
    [
        sg.Column(file_list_column),
        sg.VSeperator(),
    ]
]
window = sg.Window("Image Viewer", layout)

while True:
    event, values = window.read()
    if event == "Exit" or event == sg.WIN_CLOSED:
        break
#Request Filename of input svg
#Request output filename
#Request path to TrackDiag.st
