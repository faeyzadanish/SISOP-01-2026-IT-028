<details>
<summary>Soal 1</summary>
Membuat file KANJ.sh

```bash
BEGIN {
    FS=","
}
```

Pada bagian ini, program melakukan konfigurasi awal dengan menentukan FS (Field Separator) sebagai koma (,). Hal ini penting karena file yang digunakan berformat CSV (Comma-Separated Values), sehingga setiap kolom data dapat diakses menggunakan indeks seperti $1, $2, $3, dan seterusnya.
Dengan pengaturan ini, AWK dapat membaca setiap baris data dan memisahkannya ke dalam kolom-kolom yang terstruktur.

```bash
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
```

Bagian ini merupakan inti dari program karena semua data diproses di sini, baris demi baris.

Pertama, program mengecek apakah baris yang sedang dibaca adalah baris pertama (NR == 1). Jika iya, maka baris tersebut dilewati menggunakan next. Hal ini dilakukan karena baris pertama biasanya berisi header (judul kolom), bukan data penumpang yang ingin diolah.
Selanjutnya, setiap baris yang valid akan dihitung sebagai satu penumpang melalui total++. Variabel ini akan menyimpan jumlah keseluruhan penumpang yang ada dalam dataset.
Kemudian, program mencatat nomor gerbong menggunakan carriage[$3] = 1. Di sini, $3 diasumsikan sebagai kolom gerbong. Penggunaan array memungkinkan program menyimpan nilai unik saja, sehingga meskipun satu gerbong muncul berkali-kali, tetap hanya dihitung satu kali nantinya.
Untuk mencari penumpang tertua, program membandingkan nilai umur pada kolom $4 dengan variabel max_age. Jika ditemukan umur yang lebih besar, maka nilai tersebut disimpan sebagai umur maksimum, dan nama penumpang ($2) disimpan sebagai penumpang tertua. Proses ini terus dilakukan sampai semua baris selesai dibaca.
Selain itu, setiap umur penumpang dijumlahkan ke dalam variabel sum_age. Nilai ini nantinya digunakan untuk menghitung rata-rata usia penumpang.
Terakhir, program melakukan pengecekan terhadap kolom $5 yang berisi kelas penumpang. Jika nilainya adalah "Business", maka variabel business akan ditambahkan satu. Dengan cara ini, program dapat menghitung jumlah penumpang yang berada di kelas Business.

```bash
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
```

Bagian END dijalankan setelah seluruh data selesai diproses. Pada bagian ini, program menentukan output yang akan ditampilkan berdasarkan nilai dari variabel mode.
Jika mode bernilai "a", maka program akan menampilkan jumlah total penumpang yang sebelumnya sudah dihitung selama proses iterasi data.
Jika mode bernilai "b", program akan menghitung jumlah gerbong unik dengan melakukan iterasi pada array carriage. Setiap elemen array merepresentasikan satu gerbong, sehingga jumlah elemen array sama dengan jumlah gerbong yang berbeda.
Untuk mode "c", program akan menampilkan nama penumpang tertua beserta usianya. Nilai ini sudah diperoleh sebelumnya saat proses perbandingan umur dilakukan di bagian utama.
Jika mode "d", program menghitung rata-rata usia dengan membagi total umur (sum_age) dengan jumlah penumpang (total). Fungsi int() digunakan agar hasilnya berupa bilangan bulat (dibulatkan ke bawah).
Terakhir, jika mode "e", program akan menampilkan jumlah penumpang yang berada di kelas Business berdasarkan perhitungan yang telah dilakukan sebelumnya.

```bash
awk -v mode=<mode> -f kanj.sh passenger.csv
```

awk → menjalankan program AWK

-v mode=<mode> → mengirim parameter mode ke script

-f kanj.sh → menggunakan file script yang dibuat

passenger.csv → file data yang diproses

<img width="1427" height="888" alt="Screenshot (41)" src="https://github.com/user-attachments/assets/0cf0108e-1fdf-4aad-9f39-653224dbd8e0" />

ini untuk hasil outputnya ketika program dijalankan
