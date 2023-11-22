# Muhammad Madhani Putra
# PBP A - 2206028503

## Jawaban Soal Tugas 7

### Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
- Stateless widget
    - Setelah sebuah widget dibuat, properti atau nilainya tidak dapat diubah (dapat diubah jika membuat widget baru)
    - Rendering yang cepat karena bersifat statis 
- Stateful widget
    - Memungkinkan perubahan nilai atau properti
    - Memerlukan manajemen state yang lebih kompleks yang dapat mempengaruhi performa, terutama jika banyak pembaruan state terjadi.


### Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- **MyHomePage:** Kelas ini merepresentasikan halaman utama aplikasi Anda. Ia mengextends StatelessWidget, yang berarti ia tidak mempertahankan state apapun antar pemanggilan build.
- **Scaffold:** Widget yang menyediakan struktur dasar tampilan visual untuk aplikasi, termasuk AppBar, body, dan floatingActionButton.
- **AppBar:** Sebuah Material Design app bar yang menampilkan judul aplikasi, navbar, dll.
- **ShopCard:** Kelas widget buatan sendiri yang menerima objek ShopItem dan menampilkan informasinya dalam bentuk card.
- **MaterialApp:** Sebuah widget yang memberikan tampilan berdasarkan Material Design.
- **InkWell:** Sebuah rectangle area yang dapat diklik dan akan memberikan efek visual saat ditekan(message box).
- **Container:** Sebuah box yang berisikan widget lain.
- **Icon:** Widget yang akan menampilkan sebuah ikon Material Design.
- **Center:** Sebuah widget yang memposisikan anaknya ke tengah.
- **Text:** Widget yang menampilkan serangkaian karakter dengan gaya yang dapat disesuaikan.
- **SingleChildScrollView:** Sebuah box yang dapat scroll, yang cocok untuk box tunggal yang akan memiliki beberapa anak tetapi tidak semua anak terlihat sekaligus.
- **Padding:** Widget yang memberikan padding pada widget anaknya.
- **Column:** Sebuah box yang menampilkan anak-anaknya dalam urutan vertikal.
- **GridView:** Sebuah scrollable grid yang menampilkan widget sebagai tiles.

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)
1.  Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.
    - Jalankan command flutter create madanshop untuk membuat proyek Flutter baru
    - Berpindah direktori ke proyek flutter baru dengan menjalankan command `cd madanshop`
2. Membuat tiga tombol sederhana dengan ikon dan teks untuk:
    - Pada `main.dart`hapus `MyHomePage(title: 'Flutter Demo Home Page')` menjadi `MyHomePage()`
    - Pada `menu.dart`:
    - Tambahkan teks dan card dengan menambahkan barang-barang yang dijual. Define tipe pada list seperti berikut:
    ```
    class InventoryItem {
        final String name;
        final IconData icon;
        final Color color;

        InventoryItem(this.name, this.icon, this.color);
    }
    ```
    - Ubah sifat widget halaman dari stateful menjadi stateless. Lakukan perubahan pada bagian `({super.key, required this.title})` menjadi `({Key? key}) : super(key: key);`. Selain itu, tambahkan barang-barang yang dijual (nama, icon, dan warna) dengan code berikut:
        ```
        final List<InventoryItem> items = [
            InventoryItem("Lihat Item", Icons.checklist, Colors.red.shade400),
            InventoryItem("Tambah Item", Icons.add_shopping_cart, Colors.green.shade400),
            InventoryItem("Logout", Icons.logout, Colors.blue.shade400),
        ];
        ```
    - Ubah method Widget build(BuildContext context) menjadi seperti berikut:
    ```
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Madanshop',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.cyan.shade300,
        ),
        body: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Madanshop', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((InventoryItem item) {
                    // Iterasi untuk setiap item
                    return ShopCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }
    ```
    - Membuat widget stateless baru untuk menampilkan card dengan code berikut:
    ```
    class InventoryCard extends StatelessWidget {
        final InventoryItem item;

        const InventoryCard(this.item, {super.key}); // Constructor

        @override
        Widget build(BuildContext context) {
            return Material(
            color: item.color,
            child: InkWell(
                // Area responsive terhadap sentuhan
                onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}!")));
                },
                child: Container(
                // Container untuk menyimpan Icon dan Text
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                        item.icon,
                        color: Colors.white,
                        size: 30.0,
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        ),
                    ],
                    ),
                ),
                ),
            ),
            );
        }
    }
    ```
3. Memunculkan Snackbar
    - Tambahkan kode berikut di dalam child InkWell
    ```
    onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
    ```

## Jawaban Soal Tugas 8

### Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
- Navigator.push() dapat digunakan untuk menambahkan route baru ke tumpukan navigator yang memungkinkan pengguna untuk kembali ke route sebelumnya.
  - Contoh: Aplikasi yang memiliki daftar produk, ketika ingin melihat detail dari sebuah produk kita dapat menggunakan Navigator.push() untuk menavigasi ke halaman detail produk.
- Navigator.pushReplacement() dapat digunakan untuk menggantikan route saat ini dengan route baru pada tumpukan navigator. Method ini berguna jika pengguna tidak bisa kembali ke route sebelumnya.
  - Contoh:  Setelah pengguna berhasil login, Anda mungkin tidak ingin mereka kembali ke halaman login lagi dengan menekan tombol back.

### Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
- Container: Digunakan untuk mendekorasi child widget-nya dengan warna, border, margin, dan padding. Juga dapat digunakan untuk transformasi geometrik.
- Column & Row: Digunakan untuk layout dalam bentuk vertikal (Column) atau horizontal (Row). Baik Column maupun Row dapat memiliki beberapa child widgets.
- Align & Center: Digunakan untuk menentukan posisi widget-nya dalam parent widget. Center akan menengahkan child di dalamnya.
- Padding: Memberikan padding pada child widget-nya, yaitu memberikan spasi tambahan di sekitar widget.
- Wrap: Mirip dengan Row atau Column tetapi bisa otomatis beralih ke baris atau kolom berikutnya jika tidak ada ruang.
- Stack: Memungkinkan widget untuk ditumpuk di atas satu sama lain. Berguna untuk posisi widget di atas widget lainnya, seperti latar belakang dengan teks di atasnya.
- ListView: Digunakan untuk membuat daftar scrollable yang dapat menampung banyak children.
- GridView: Layout dalam bentuk grid yang scrollable, berguna untuk menampilkan banyak data dalam bentuk grid.
- Table: Menata widgets dalam format tabel dengan baris dan kolom yang tetap.
- Flow: Memberikan kontrol penataan yang lebih kompleks, bisa membuat layout yang tidak bisa dibuat dengan Row atau Column.
- ConstrainedBox & SizedBox: Digunakan untuk membatasi ukuran widget child, bisa secara spesifik atau dengan batasan tertentu.

### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Saya menggunakan TextFormField, alasan saya menggunakan ini karena TextFromField dapat digunakan untuk menerima input form dan dapat digunakan untuk menghandle submisi dan validasi input.

### Bagaimana penerapan clean architecture pada aplikasi Flutter?
Penerapan clean architecture pada aplikasi Flutter bertujuan untuk memisahkan kode menjadi lapisan-lapisan yang tidak tergantung secara langsung satu sama lain, sehingga memudahkan dalam pengujian, pemeliharaan, dan skalabilitas aplikasi. Berikut ini adalah lapisan-lapisan umum dalam clean architecture yang bisa diaplikasikan pada Flutter:

- Presentation Layer: Menyimpan semua kode yang berhubungan dengan UI
- Domain Layer: Lapisan inti yang menentukan bisnis logika aplikasi
- Data Layer: Mengimplementasikan Repository Interfaces yang didefinisikan di domain layer
- Infrastructure Layer (opsional): Ekstensi dari data layer

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)
1. Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru dengan ketentuan sebagai berikut:
  - Membuat file `inventorylist_form.dart` pada direktori lib.
2. Memakai minimal tiga elemen input, yaitu name, amount, description. Tambahkan elemen input sesuai dengan model pada aplikasi tugas Django yang telah kamu buat.
  - Edit class _ShopFormPageState di file shoplist_form.dart dan tambahkan elemen-elemen yang dibutuhkan (name, amount, description, dan price.)
3. Memiliki sebuah tombol Save
  - Edit bagian return Scaffold(...) pada file inventorylist.dart agar dapat menyimpan data setelah inputform divalidasi.
4. Validasi semua input dengan menggunakan kode berikut
  - Input tidak boleh kosong
  ```
  validator: (String? value) {
    if (value == null || value.isEmpty) {
        return "Nama tidak boleh kosong!";
    }
    return null;
  },
  ```
  - Input sesuai dengan atribut modelenya
  ```
  validator: (String? value) {
    if (value == null || value.isEmpty) {
        return "Amount tidak boleh kosong!";
    }
    if (int.tryParse(value) == null) {
        return "Amount harus berupa angka!";
    }
    return null;
  },
  ```
5. Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.
  - Tambah drawer di main.dart
  - Tambahkan navigator di shop_card.dart

6. Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru.
  - Edit class _ShopFormPageState di shoplist_form.dart dan menambahkan showDialog di onPressed 
7. Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:
  - Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Item. Edit class LeftDrawer di left_drawer.dart dan tambahkan dua ListTile untuk halaman utama dan tambah item.
  - Ketika memiih opsi Halaman Utama, maka aplikasi akan mengarahkan pengguna ke halaman utama. Edit class LeftDrawer di left_drawer.dart
  - Ketika memiih opsi (Tambah Item), maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru. Edit class LeftDrawer di left_drawer.dart

## Jawaban Soal Tugas 9

### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Kita bisa melakukannya dengan menggunakan Map<String, dynamic> untuk menangani data JSON secara langsung. Pengambilan data JSON tanpa model memberikan fleksibilitas karena kita tidak perlu mendefinisikan struktur data terlebih dahulu. Hal ini berguna untuk prototyping cepat atau ketika berinteraksi dengan API yang sering berubah. Developer juga tidak perlu menulis kode tambahan untuk serialisasi dan deserialisasi data, yang bisa menghemat waktu pengembangan.

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Fungsi dari CookieRequest adalah untuk menyimpan dan mengelola data sesi pengguna, seperti token autentikasi atau preferensi pengguna. Hal ini sangat penting dalam aplikasi yang membutuhkan pemeliharaan sesi pengguna.

Alasan mengapa sebuah instance CookieRequest perlu dibagikan ke semua komponen dalam aplikasi adalah untuk menjaga konsistensi sesi pengguna di seluruh aplikasi. Ini memastikan bahwa setiap komponen aplikasi dapat mengakses dan memanfaatkan data sesi yang sama. Misalnya, jika pengguna telah masuk (login), cookie yang memuat token autentikasi harus dapat diakses oleh semua komponen yang memerlukan verifikasi autentikasi, sehingga pengguna tidak perlu masuk berulang kali saat berpindah antar fitur aplikasi.

### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
  1. Membuat model kustom Manfaatkan website Quicktype untuk membuat data JSON yang didapat dari endpoint /json pada tugas Django.
  2. Menambahkan dependensi HTTP Pada proyek Flutter, tambahkan dependensi http dan tambahkan kode <uses-permission android:name="android.permission.INTERNET" /> pada android/app/src/main/AndroidManifest.xml untuk memperbolehkan akses internet.
  3. Melakukan Fetch Data Pada salah satu file lib/screens yang ingin melakukan fetch data, implementasi fungsi asinkronus dan mengirim permintaan HTTP.
  4. Untuk menampilkan data di Flutter, kita menggunakan berbagai widget yang disediakan oleh Flutter. Dalam tugas ini, saya menggunakan ListView.builder untuk menampilkan daftar item

### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
  1. Pengguna memasukkan data akun yaitu username dan password pada laman LoginPage.
  2. Tombol login ditekan dan fungsi login pada CookieRequest terpanggil yang mengirimkan HTTP request dengan endpoint URL proyek Django.
  3. Pada Django, dilakukan autentikasi seperti user = authenticate(username=username, password=password) pada views.py milik authentication.
  4. Setelah itu dicek, apakah user is not None dan user.is_active:?
  5. Kembali ke Flutter, jika request.loggedIn, pengguna diarahkan ke MyHomePage dan muncul tampilan selamat datang menggunakan SnackBar.

### Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
- Scaffold: Widget ini digunakan sebagai kerangka dasar untuk layout halaman di Flutter. Ini menyediakan struktur dasar seperti appBar, body, dan lainnya.

- AppBar: Widget ini digunakan untuk menampilkan app bar di bagian atas layar. Di dalamnya, Kita menampilkan judul halaman yang diambil dari data item.

- Form: Widget ini digunakan untuk membuat formulir yang dapat diisi oleh pengguna. Ini membantu dalam validasi dan pengelolaan data formulir.

- IconButton: Widget ini digunakan untuk menampilkan tombol ikon di app bar. Dalam kasus ini, Kita menggunakan ikon panah kembali (Icons.arrow_back) yang, ketika ditekan, akan memicu fungsi untuk kembali ke halaman sebelumnya (Navigator.pop(context)).

- Padding: Widget ini digunakan untuk memberikan padding di sekitar konten lainnya, dalam hal ini di sekitar kolom yang menampilkan detail produk.

- Column: Widget ini digunakan untuk menata beberapa widget lainnya secara vertikal. Ini digunakan untuk menampilkan informasi detail produk.

- Text: Widget ini digunakan untuk menampilkan teks di layar. Dalam hal ini, digunakan untuk menampilkan berbagai atribut dari item, seperti nama, jumlah, harga, deskripsi, dan kategori

- TextFormField: Widget ini digunakan untuk menerima input teks dari pengguna. Setiap TextFormField dikonfigurasi dengan dekorasi, validator, dan fungsi onChanged.

- ElevatedButton: Widget ini digunakan untuk membuat tombol yang, ketika ditekan, akan menjalankan fungsi yang diberikan. Dalam kasus ini, tombol digunakan untuk mengirim data formulir ke server

- Align: Widget ini digunakan untuk mengatur posisi widget anaknya, dalam hal ini digunakan untuk menempatkan tombol di bagian bawah

- SingleChildScrollView: Widget ini memungkinkan pengguna untuk menggulir melalui konten yang mungkin tidak muat di layar

- FutureBuilder: Widget ini digunakan untuk membangun UI berdasarkan hasil dari Future. Dalam kasus ini, digunakan untuk membangun UI setelah data dari fetchItem() diperoleh

- ListView.builder: Widget ini digunakan untuk membuat daftar item yang dapat digulir. Ini membangun item daftar secara dinamis berdasarkan data yang diperoleh

- InkWell: Widget ini digunakan untuk menangani ketukan pada item daftar. Ketika item ditekan, ia akan menavigasi ke DetailProductPage dengan data item yang relevan

- Container: Widget ini digunakan untuk mengelompokkan dan memberikan margin, padding, dan tata letak lainnya pada item daftar

- SizedBox: Widget ini digunakan untuk memberikan jarak antar widget dalam Column.

- ShopCard: Widget ini adalah widget kustom, digunakan untuk menampilkan kartu untuk setiap item dalam grid. Setiap ShopCard mewakili sebuah item dalam aplikasi

- LeftDrawer: Widget adalah widget kustom, digunakan untuk menampilkan menu drawer di sisi kiri layar.

- Drawer: Widget ini digunakan untuk membuat menu drawer yang dapat ditarik dari sisi layar. Ini memberikan navigasi tambahan dalam aplikasi

- ListView: Widget ini digunakan untuk membuat daftar item yang dapat discroll. Dalam konteks ini, digunakan untuk menampilkan item-item dalam drawer.

- ListTile: Widget ini digunakan untuk membuat item yang dapat diklik di dalam ListView. Dalam hal ini, digunakan untuk membuat item navigasi di drawer

- Icon: Widget ini digunakan untuk menampilkan ikon di samping teks dalam ListTile

- Material: Widget ini digunakan sebagai dasar untuk menampilkan komponen UI yang mengikuti Material Design. Di sini, digunakan untuk memberikan warna latar belakang pada kartu

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
