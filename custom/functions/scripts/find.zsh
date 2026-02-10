#!/usr/bin/zsh
find_pdf_to_html() {
    printed_working_directory=$(pwd)
    pdf_files=($(find "$printed_working_directory" -type f -name "*.pdf"))
    html_template="<!DOCTYPE html>
    <html>
    <head>
        <title>PDF Links</title>
    </head>
    <body>
        <h1>PDF Files</h1>
        <ul>
    "
    for pdf in "${pdf_files[@]}"; do
        html_template+="        <li><a href=\"$pdf\">$(basename "$pdf")</a></li>
    "
    done
    html_template+="    </ul>
    </body>
    </html>
    "
    temp_file=$(mktemp --suffix=.html)
    echo "$html_template" > "$temp_file"
    xdg-open "$temp_file"
}
