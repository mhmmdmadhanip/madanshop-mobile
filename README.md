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
