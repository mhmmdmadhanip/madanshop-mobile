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

### Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

### Bagaimana penerapan clean architecture pada aplikasi Flutter?

### Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)