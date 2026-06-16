import '../models/motor_model.dart';
import '../models/booking_model.dart';
import '../models/message_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../models/voucher_model.dart';
import '../models/point_history_model.dart';
import '../models/faq_model.dart';
import '../models/app_info_model.dart';

class DummyData {
  static final List<Motor> motors = [
    Motor(
      id: 'm1',
      name: 'Honda Vario 125',
      price: 'Rp 85.000',
      rating: '4.8',
      category: 'Matic',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: false,
    ),
    Motor(
      id: 'm2',
      name: 'Yamaha NMAX 155',
      price: 'Rp 110.000',
      rating: '4.9',
      category: 'Matic',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: true,
    ),
    Motor(
      id: 'm3',
      name: 'Honda Beat',
      price: 'Rp 70.000',
      rating: '4.7',
      category: 'Matic',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: true,
    ),
    Motor(
      id: 'm4',
      name: 'Yamaha Aerox 155',
      price: 'Rp 100.000',
      rating: '4.8',
      category: 'Matic',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: false,
    ),
    Motor(
      id: 'm5',
      name: 'Honda CBR 150R',
      price: 'Rp 150.000',
      rating: '4.9',
      category: 'Sport',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: false,
    ),
    Motor(
      id: 'm6',
      name: 'Yamaha Fazzio',
      price: 'Rp 95.000',
      rating: '4.6',
      category: 'Retro',
      image: 'https://images.unsplash.com/photo-1625234199148-356b7c53d5fa?q=80&w=400',
      isFavorite: false,
    ),
  ];

  static final List<Booking> bookings = [
    Booking(
      id: 'b1',
      motor: motors[0], // Honda Vario 125
      startDate: '20 Mei 2024',
      endDate: '22 Mei 2024',
      price: 'Rp 170.000',
      status: 'Aktif',
    ),
    Booking(
      id: 'b2',
      motor: motors[1], // Yamaha NMAX 155
      startDate: '10 Mei 2024',
      endDate: '12 Mei 2024',
      price: 'Rp 220.000',
      status: 'Selesai',
    ),
  ];

  static final List<Message> messages = [
    Message(
      id: 'msg1',
      senderName: 'Admin MotorKU',
      text: 'Pesanan Honda Vario 125 Anda sudah kami konfirmasi. Silahkan...',
      time: '10:30',
      unreadCount: 2,
      isOnline: true,
      avatar: 'https://ui-avatars.com/api/?name=Admin+M&background=7A58E6&color=fff&rounded=true&bold=true',
    ),
    Message(
      id: 'msg2',
      senderName: 'Pak Budi (Pengirim Motor)',
      text: 'Halo kak, saya sudah di depan lokasi pengantaran ya. Sesuai t...',
      time: 'Kemarin',
      unreadCount: 1,
      isOnline: true,
      avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200&auto=format&fit=crop',
    ),
    Message(
      id: 'msg3',
      senderName: 'CS Bantuan',
      text: 'Baik kak, keluhan mengenai helm sudah kami catat dan akan sege...',
      time: '12/05',
      unreadCount: 0,
      isOnline: false,
      avatar: 'https://ui-avatars.com/api/?name=CS&background=E5E7EB&color=2D3142&rounded=true&bold=true',
    ),
    Message(
      id: 'msg4',
      senderName: 'Promo & Info',
      text: 'Diskon 50% untuk sewa minimal 3 hari! Gunakan kode promo: GASS...',
      time: '10/05',
      unreadCount: 0,
      isOnline: false,
      avatar: 'https://ui-avatars.com/api/?name=%25&background=F3F0FF&color=7A58E6&rounded=true&bold=true',
    ),
  ];

  static final Map<String, List<ChatDetail>> chatDetails = {
    'Admin MotorKU': [
      ChatDetail(
        id: 'cd1',
        text: 'Halo Mas Akbar, pesanan motor Vario 125 untuk tanggal 20 Mei sudah kami terima dan konfirmasi ya.',
        time: '10:00',
        isMe: false,
      ),
      ChatDetail(
        id: 'cd2',
        text: 'Baik Pak, terima kasih. Untuk pengambilan motornya nanti bagaimana prosesnya?',
        time: '10:05',
        isMe: true,
      ),
      ChatDetail(
        id: 'cd3',
        text: 'Silakan datang langsung ke lokasi cabang Mataram City Center (MCC). Nanti tinggal tunjukkan E-Tiket atau QR Code yang ada di aplikasi ke petugas kami di lapangan.',
        time: '10:07',
        isMe: false,
      ),
      ChatDetail(
        id: 'cd4',
        text: 'Oke siap Pak, besok pagi jam 10 saya meluncur ke lokasi.',
        time: '10:10',
        isMe: true,
      ),
      ChatDetail(
        id: 'cd5',
        text: 'Baik ditunggu kedatangannya Mas Akbar. Hati-hati di jalan! 🙏',
        time: '10:42',
        isMe: false,
      ),
    ],
  };

  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Pembayaran Berhasil',
      description: 'Pembayaran untuk Honda Vario 125 telah berhasil dikonfirmasi.',
      time: '10 Menit yang lalu',
      type: 'Pembayaran',
    ),
    NotificationModel(
      id: 'n2',
      title: 'Promo Spesial Akhir Pekan!',
      description: 'Diskon 20% untuk semua jenis motor matic. Gunakan kode MATIC20.',
      time: '2 Jam yang lalu',
      type: 'Promo',
    ),
    NotificationModel(
      id: 'n3',
      title: 'Masa Sewa Akan Habis',
      description: 'Masa sewa Yamaha NMAX Anda akan habis dalam 2 jam.',
      time: 'Kemarin',
      type: 'Booking',
    ),
  ];

  static final List<UserModel> users = [
    UserModel(
      id: 'u1',
      name: 'Reza Maulana',
      email: 'reza.maulana@gmail.com',
      password: 'password123',
      phone: '081234567890',
      avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200',
      isPremium: true,
      points: 2450,
      rating: 4.9,
      totalBookings: 12,
      birthDate: '15 Agustus 1998',
      gender: 'Laki-laki',
      occupation: 'Software Engineer',
      address: 'Jl. Sudirman No. 123, Jakarta Selatan, DKI Jakarta',
    ),
    UserModel(
      id: 'u2',
      name: 'Akbar',
      email: 'akbar@gmail.com',
      password: 'admin',
      phone: '089876543210',
      avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200',
      isPremium: false,
      points: 150,
      rating: 4.5,
      totalBookings: 3,
      birthDate: '10 Mei 2000',
      gender: 'Laki-laki',
      occupation: 'Mahasiswa',
      address: 'Jl. Kaliurang Km 5, Sleman, DI Yogyakarta',
    )
  ];

  static UserModel currentUser = users[0]; // Simulated logged in user

  static final List<VoucherModel> vouchers = [
    VoucherModel(
      id: 'v1',
      title: 'Diskon 20% Akhir Pekan',
      code: 'WEEKEND20',
      description: 'Potongan harga maksimal Rp 50.000 untuk penyewaan di hari Sabtu & Minggu.',
      expiryDate: 'Berlaku s/d 30 Mei 2024',
      discountPercentage: 20,
      pointsCost: 500,
    ),
    VoucherModel(
      id: 'v2',
      title: 'Potongan Rp 25.000 Pengguna Baru',
      code: 'NEWUSER25',
      description: 'Khusus pengguna baru yang melakukan booking pertama kali melalui aplikasi.',
      expiryDate: 'Berlaku s/d 15 Juni 2024',
      discountPercentage: 25,
      pointsCost: 750,
    ),
  ];

  static final List<PointHistoryModel> pointHistories = [
    PointHistoryModel(
      id: 'ph1',
      title: 'Sewa Honda Vario 125',
      points: 150,
      date: '20 Mei 2024',
      isEarned: true,
    ),
    PointHistoryModel(
      id: 'ph2',
      title: 'Tukar Voucher Diskon 20%',
      points: 500,
      date: '15 Mei 2024',
      isEarned: false,
    ),
    PointHistoryModel(
      id: 'ph3',
      title: 'Bonus Pengguna Baru',
      points: 1000,
      date: '01 Mei 2024',
      isEarned: true,
    ),
  ];

  static final List<FaqModel> faqs = [
    FaqModel(
      id: 'f1',
      question: 'Bagaimana cara menyewa motor?',
      answer: 'Anda dapat menyewa motor dengan memilih motor yang tersedia di halaman Beranda, lalu pilih tanggal penyewaan dan ikuti proses pembayaran hingga selesai.',
    ),
    FaqModel(
      id: 'f2',
      question: 'Apakah ada jaminan yang harus diberikan?',
      answer: 'Ya, kami membutuhkan e-KTP asli sebagai jaminan selama masa penyewaan. Dokumen akan dikembalikan setelah motor dikembalikan dalam kondisi baik.',
    ),
    FaqModel(
      id: 'f3',
      question: 'Bagaimana jika motor mengalami kerusakan di jalan?',
      answer: 'Harap segera hubungi layanan pelanggan kami melalui menu Bantuan. Kami akan mengirimkan tim teknisi atau memberikan motor pengganti jika diperlukan.',
    ),
    FaqModel(
      id: 'f4',
      question: 'Apakah bisa memperpanjang masa sewa?',
      answer: 'Tentu bisa. Anda dapat memperpanjang masa sewa melalui menu Riwayat Booking sebelum masa sewa aktif Anda berakhir.',
    ),
  ];

  static final List<AppInfoModel> terms = [
    AppInfoModel(
      id: 't1',
      title: '1. Persyaratan Peminjam',
      content: 'Peminjam harus berusia minimal 18 tahun, memiliki e-KTP asli yang valid, serta SIM C yang masih berlaku.',
    ),
    AppInfoModel(
      id: 't2',
      title: '2. Kebijakan Penggunaan',
      content: 'Motor hanya boleh digunakan di dalam wilayah yang telah disepakati. Dilarang keras memindahtangankan motor kepada pihak ketiga tanpa izin.',
    ),
    AppInfoModel(
      id: 't3',
      title: '3. Denda & Keterlambatan',
      content: 'Keterlambatan pengembalian akan dikenakan denda sebesar Rp 10.000 per jam. Jika lebih dari 24 jam, akan dihitung sebagai sewa 1 hari penuh.',
    ),
  ];

  static final List<AppInfoModel> privacy = [
    AppInfoModel(
      id: 'p1',
      title: '1. Pengumpulan Data',
      content: 'Kami mengumpulkan data pribadi Anda seperti nama, nomor telepon, alamat email, dan foto KTP untuk keperluan verifikasi keamanan.',
    ),
    AppInfoModel(
      id: 'p2',
      title: '2. Penggunaan Data',
      content: 'Data Anda digunakan secara eksklusif untuk memproses transaksi, menghubungi Anda jika terjadi keadaan darurat, dan peningkatan layanan.',
    ),
    AppInfoModel(
      id: 'p3',
      title: '3. Keamanan Informasi',
      content: 'Kami menggunakan sistem enkripsi standar industri untuk melindungi data sensitif Anda dari akses yang tidak sah.',
    ),
  ];

  static final List<Map<String, String>> languages = [
    {"nama": "Indonesia", "kode": "ID"},
    {"nama": "English (US)", "kode": "EN"},
    {"nama": "Jepang (日本語)", "kode": "JP"},
    {"nama": "Korea (한국어)", "kode": "KR"},
  ];
}
