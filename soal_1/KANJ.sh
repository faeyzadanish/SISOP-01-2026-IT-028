BEGIN {
    FS=","
}

{
    if (NR == 1) next

    total++
    carriage[$3] = 1

    if ($4 > max_age) {
        max_age = $4
        oldest = $2
    }

    sum_age += $4

    if ($5 == "Business") {
        business++
    }
}

END {
    if (mode == "a") {
        print "Jumlah seluruh penumpang KANJ adalah " total " orang"
    }
    else if (mode == "b") {
        for (c in carriage) count++
        print "Jumlah gerbong penumpang KANJ adalah " count
    }
    else if (mode == "c") {
        print oldest " adalah penumpang kereta tertua dengan usia " max_age " tahun"
    }
    else if (mode == "d") {
        avg = int(sum_age / total)
        print "Rata-rata usia penumpang adalah " avg " tahun"
    }
    else if (mode == "e") {
        print "Jumlah penumpang business class ada " business " orang"
    }
}
