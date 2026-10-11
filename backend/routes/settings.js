const express = require('express');
const crypto = require('crypto');
const https = require('https');
const { DB } = require('../config/db');
const { requireAuth, requireAdmin } = require('../middleware/auth');

const router = express.Router();

// Helper: Upload Base64 Data URI to Cloudinary via signed REST API
function uploadToCloudinary(dataUri, folder = 'loksewa_prep') {
  return new Promise((resolve, reject) => {
    const cloudName = process.env.CLOUDINARY_CLOUD_NAME || 'rajeevyadav';
    const apiKey = process.env.CLOUDINARY_API_KEY || '';
    const apiSecret = process.env.CLOUDINARY_API_SECRET || '';

    const timestamp = Math.floor(Date.now() / 1000);
    // Signature parameters in alphabetical order: folder, timestamp
    const stringToSign = `folder=${folder}&timestamp=${timestamp}${apiSecret}`;
    const signature = crypto.createHash('sha1').update(stringToSign).digest('hex');

    const payload = JSON.stringify({
      file: dataUri,
      api_key: apiKey,
      timestamp,
      folder,
      signature,
    });

    const req = https.request(
      {
        hostname: 'api.cloudinary.com',
        path: `/v1_1/${cloudName}/image/upload`,
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(payload),
        },
      },
      (res) => {
        let raw = '';
        res.on('data', (chunk) => (raw += chunk));
        res.on('end', () => {
          try {
            const parsed = JSON.parse(raw);
            if (res.statusCode >= 200 && res.statusCode < 300 && parsed.secure_url) {
              resolve(parsed);
            } else {
              reject(new Error(parsed.error?.message || `Cloudinary HTTP ${res.statusCode}`));
            }
          } catch (e) {
            reject(e);
          }
        });
      }
    );

    req.on('error', reject);
    req.write(payload);
    req.end();
  });
}

// GET /api/settings (Public — used by SubscriptionPage & Payment Modal)
router.get('/', async (req, res) => {
  try {
    const settings = await DB.getSettings();
    return res.json({ settings });
  } catch (err) {
    console.error('Get settings error:', err);
    return res.status(500).json({ error: 'Failed to load payment & contact settings' });
  }
});

// PUT /api/settings (Admin Only — update Payment QR, WhatsApp QR, Contacts, Bank info)
router.put('/', requireAuth, requireAdmin, async (req, res) => {
  try {
    const updated = await DB.updateSettings(req.body || {});
    return res.json({
      message: 'Payment QR, WhatsApp QR & Contact settings saved to MongoDB Atlas!',
      settings: updated,
    });
  } catch (err) {
    console.error('Update settings error:', err);
    return res.status(500).json({ error: 'Failed to update settings' });
  }
});

// POST /api/settings/upload-image (Admin Only — upload QR / image to Cloudinary & optionally save to MongoDB)
router.post('/upload-image', requireAuth, requireAdmin, async (req, res) => {
  try {
    const { imageDataUrl, targetField, folder } = req.body || {};
    if (!imageDataUrl || !imageDataUrl.startsWith('data:image/')) {
      return res.status(400).json({ error: 'Valid base64 imageDataUrl (data:image/...) is required' });
    }

    const uploaded = await uploadToCloudinary(imageDataUrl, folder || 'loksewa_prep');
    let updatedSettings = null;

    const fieldMap = {
      payment_qr_url: 'paymentQrUrl',
      paymentQrUrl: 'paymentQrUrl',
      whatsapp_qr_url: 'whatsappQrUrl',
      whatsappQrUrl: 'whatsappQrUrl',
    };
    const mappedField = fieldMap[targetField];
    if (mappedField) {
      updatedSettings = await DB.updateSettings({ [mappedField]: uploaded.secure_url });
    }

    return res.json({
      message: 'Image uploaded to Cloudinary and saved to MongoDB Atlas!',
      url: uploaded.secure_url,
      public_id: uploaded.public_id,
      settings: updatedSettings,
    });
  } catch (err) {
    console.error('Cloudinary upload error:', err);
    return res.status(500).json({ error: err.message || 'Failed to upload image to Cloudinary' });
  }
});

module.exports = router;
