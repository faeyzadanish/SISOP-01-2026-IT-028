BEGIN {
    FS = "[,;\t]"
    pilihan = ARGV[ARGC-1]
    delete ARGV[ARGC-1]
}

{
    gsub(/\r/, "", $0)
}

NR == 1 {
    for (i = 1; i <= NF; i++) {
        col = tolower($i)
        if (col ~ /nama/) c_name = i
        if (col ~ /usia/) c_age = i
        if (col ~ /kelas/) c_class = i
        if (col ~ /gerbong/) c_gerbong = i
    }
    next
}

{
    count++
    
    if (c_gerbong && $c_gerbong != "") {
        gerbong[$c_gerbong] = 1
    }
    
    if (c_age) {
        val_age = $c_age + 0
        if (val_age > 0) {
            if (val_age > max_age) {
                max_age = val_age
                oldest_name = $c_name
            }
            sum_age += val_age
            n_age++
        }
    }
    
    if (c_class && tolower($c_class) ~ /business/) {
        bus++
    }
}

END {
    if (pilihan == "a") {
        print "Jumlah seluruh penumpang KANJ adalah " (count+0) " orang"
    } 
    else if (pilihan == "b") {
        total_g = 0
        for (i in gerbong) total_g++
        print "Jumlah gerbong penumpang KANJ adalah " (total_g+0)
    } 
    else if (pilihan == "c") {
        gsub(/"/, "", oldest_name)
        print oldest_name " adalah penumpang kereta tertua dengan usia " (max_age+0) " tahun"
    } 
    else if (pilihan == "d") {
        res_age = (n_age > 0) ? (sum_age / n_age) : 0
        printf "Rata-rata usia penumpang adalah %.0f tahun\n", res_age
    } 
    else if (pilihan == "e") {
        print "Jumlah penumpang business class ada " (bus+0) " orang"
    } 
    else {
        print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
    }
}
