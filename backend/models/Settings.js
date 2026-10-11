const mongoose = require('mongoose');

const SettingsSchema = new mongoose.Schema(
  {
    key: {
      type: String,
      default: 'payment_config',
      unique: true,
    },
    whatsappNumber: {
      type: String,
      default: '+977-9705419699',
    },
    whatsappLink: {
      type: String,
      default: 'https://wa.me/9779705419699',
    },
    whatsappQrUrl: {
      type: String,
      default: 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720922/loksewa_prep/s2kdezawa20cg6ycco7d.jpg',
    },
    paymentQrUrl: {
      type: String,
      default: 'https://res.cloudinary.com/rajeevyadav/image/upload/v1791720911/loksewa_prep/wxs7zoxae5cwyczac6lx.jpg',
    },
    esewaId: {
      type: String,
      default: '9800000000',
    },
    khaltiId: {
      type: String,
      default: '9800000001',
    },
    fonepayMerchant: {
      type: String,
      default: 'LokSewa Prep Nepal (FonePay QR)',
    },
    bankName: {
      type: String,
      default: 'Rastriya Banijya Bank (RBB)',
    },
    bankAccountName: {
      type: String,
      default: 'LokSewa Prep Nepal Pvt. Ltd.',
    },
    bankAccountNumber: {
      type: String,
      default: '1010001007180003',
    },
    bankBranch: {
      type: String,
      default: 'Singhadurbar Plaza Branch, Kathmandu',
    },
    supportEmail: {
      type: String,
      default: 'support@loksewaprep.com.np',
    },
    supportPhone: {
      type: String,
      default: '+977-01-4200000 / 9800000000',
    },
    officeAddress: {
      type: String,
      default: 'Putalisadak, Kathmandu, Nepal',
    },
    verificationNote: {
      type: String,
      default: 'After completing payment via eSewa, Khalti, FonePay QR, or Bank Transfer, please send your payment screenshot along with your registered Email Address to our official WhatsApp number or scan the WhatsApp QR code below. Your Basic/Premium plan will be activated immediately upon verification.',
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Settings', SettingsSchema);
