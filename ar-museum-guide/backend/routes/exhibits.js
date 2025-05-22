const express = require('express');
const router = express.Router();
const admin = require('firebase-admin');
const db = admin.firestore();

router.get('/', async (req, res) => {
  try {
    const snapshot = await db.collection('exhibits').get();
    const exhibits = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.json(exhibits);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

router.post('/', async (req, res) => {
  try {
    const exhibit = req.body;
    await db.collection('exhibits').add(exhibit);
    res.status(201).send('Exhibit added');
  } catch (error) {
    res.status(500).send(error.message);
  }
});

router.delete('/:id', async (req, res) => {
  try {
    await db.collection('exhibits').doc(req.params.id).delete();
    res.status(200).send('Exhibit deleted');
  } catch (error) {
    res.status(500).send(error.message);
  }
});

module.exports = router;