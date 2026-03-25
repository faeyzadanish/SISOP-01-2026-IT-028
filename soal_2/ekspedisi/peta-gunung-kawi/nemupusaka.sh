p1=$(grep "node_001" titik-penting.txt)
p2=$(grep "node_004" titik-penting.txt)
lat1=$(echo $p1 | cut -d',' -f3); lon1=$(echo $p1 | cut -d',' -f4)
lat2=$(echo $p2 | cut -d',' -f3); lon2=$(echo $p2 | cut -d',' -f4)
res_lat=$(echo "scale=10; ($lat1 + $lat2) / 2" | bc)
res_lon=$(echo "scale=10; ($lon1 + $lon2) / 2" | bc)
echo "$res_lat, $res_long" > posisipusaka.txt
echo "Koordinat pusat: $res_lat, $res_lon"
