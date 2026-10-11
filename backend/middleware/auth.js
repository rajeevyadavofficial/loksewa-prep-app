const jwt = require('jsonwebtoken');
const { DB } = require('../config/db');

const JWT_SECRET = process.env.JWT_SECRET || 'loksewa_rbb_it_level5_super_secret_jwt_key_2082';

function signToken(user) {
  return jwt.sign(
    {
      uid: user._id,
      email: user.email,
      plan: user.plan,
      isAdmin: !!user.isAdmin,
    },
    JWT_SECRET,
    { expiresIn: '30d' }
  );
}

async function optionalAuth(req, res, next) {
  const header = req.headers.authorization;
  if (header && header.startsWith('Bearer ')) {
    const token = header.slice(7);
    try {
      const decoded = jwt.verify(token, JWT_SECRET);
      const dbUser = await DB.findUserById(decoded.uid);
      if (dbUser) {
        req.user = dbUser;
        return next();
      }
    } catch (_) {
      // Ignore invalid token for optionalAuth
    }
  }
  req.user = { plan: 'free', isAdmin: false };
  next();
}

async function requireAuth(req, res, next) {
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Authentication required' });
  }
  const token = header.slice(7);
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    const dbUser = await DB.findUserById(decoded.uid);
    if (!dbUser) {
      return res.status(401).json({ error: 'User no longer exists' });
    }
    req.user = dbUser;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Invalid or expired token' });
  }
}

function requireAdmin(req, res, next) {
  if (!req.user || !req.user.isAdmin) {
    return res.status(403).json({ error: 'Admin privileges required' });
  }
  next();
}

module.exports = { signToken, optionalAuth, requireAuth, requireAdmin };
