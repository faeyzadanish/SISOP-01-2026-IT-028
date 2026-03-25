awk -F'"' '
    /"id":/ {id=$4} 
    /"site_name":/ {name=$4} 
    /"latitude":/ {lat=$4} 
    /"longitude":/ {long=$4}
    /}/ {
        if(id != "") {
            print id "," name "," lat "," long
            id=""; name=""; lat=""; long=""
        }
    }
' gsxtrack.json | sort -t',' -k1 > titik-penting.txt
