<details>
<summary>Soal 1</summary>
    
### Membuat file KANJ.sh
<p align="justify">
Pembuatan file KANJ.sh bertujuan untuk mengotomatisasi pengolahan data penumpang dari file passenger.csv agar setiap permintaan soal (opsi a sampai e) dapat dijalankan secara sistematis melalui satu perintah awk. Penggunaan script ini memungkinkan pemrosesan kolom data seperti jumlah penumpang, total gerbong, pencarian usia tertua, perhitungan rata-rata usia, hingga klasifikasi penumpang business class dilakukan secara cepat dan akurat sesuai format output yang diinstruksikan oleh dosen. Dengan menyimpan kode dalam file script, instruksi pengerjaan menjadi lebih terorganisir dan memudahkan proses eksekusi perintah yang berulang tanpa harus menulis ulang logika program di terminal.
</p>

### Bagian Inisialisasi
```bash
BEGIN {
    FS = "[,;\t]"
    pilihan = ARGV[ARGC-1]
    delete ARGV[ARGC-1]
}
```

* ```FS = "[,;\t]"```: Menentukan Field Separator (pemisah kolom). Kode ini membuat script fleksibel karena bisa membaca file yang dipisahkan koma (,), titik koma (;), atau tab (\t).
* ```pilihan = ARGV[ARGC-1]```: Mengambil argumen terakhir yang diketik di terminal (huruf a, b, c, d, atau e) dan menyimpannya ke variabel pilihan.
* ```delete ARGV[ARGC-1]```: Menghapus argumen huruf tersebut dari daftar file. Jika tidak dihapus, AWK akan mengira huruf "a" atau "b" adalah nama file dan akan memunculkan error file not found.

### Bagian Normalisasi Data
```bash
{
    gsub(/\r/, "", $0)
}
```

```gsub(/\r/, "", $0)```: Menghapus karakter Carriage Return (\r) yang biasanya muncul jika file CSV dibuat di Windows. Ini mencegah error pembacaan data di sistem Linux.

### Bagian Identifikasi Kolom Otomatis (NR == 1)
```bash
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
```

* ```NR == 1```: Instruksi khusus untuk baris pertama (Header).
* ```tolower($i)```: Mengubah judul kolom menjadi huruf kecil semua agar pencarian lebih akurat.
* ```if (col ~ /.../)```: Mencari nomor kolom secara otomatis berdasarkan kata kunci. Jadi, jika kolom "Usia" pindah urutan, script tidak akan rusak.
* ```next```: Langsung lanjut ke baris berikutnya setelah selesai memetakan kolom.

### Bagian Pengolahan Data Penumpang
```bash
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
```

* ```count++```: Menghitung total seluruh penumpang yang ada.
* ```gerbong[$c_gerbong]``` = 1: Memasukkan kode gerbong ke dalam associative array. Karena array index bersifat unik, maka gerbong yang sama tidak akan terhitung dua kali.
* ```val_age > max_age```: Logika untuk mencari usia tertinggi. Jika ditemukan usia yang lebih besar dari data sebelumnya, script akan memperbarui nilai max_age dan menyimpan nama penumpangnya.
* ```sum_age += val_age```: Menjumlahkan seluruh usia untuk keperluan rata-rata.
* ```bus++```: Menambah hitungan jika pada kolom kelas ditemukan kata "business".

### Bagian Penampilan Hasil (END)
```bash
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
```

* Bagian ini mengecek isi variabel pilihan. Jika user mengetik a, maka yang muncul adalah total penumpang, dan seterusnya.
* ```printf "%.0f"```: Digunakan pada opsi d untuk membulatkan hasil rata-rata usia agar tidak ada angka di belakang koma.

### Output

<img width="1247" height="811" alt="Screenshot (95)" src="https://github.com/user-attachments/assets/fb09f902-87d4-4ef1-b146-4adcab95932c" />

