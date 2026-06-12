import '../models/motor_model.dart';
import '../models/booking_model.dart';
import '../models/message_model.dart';
import '../models/notification_model.dart';

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
}
