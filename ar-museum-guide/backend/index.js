const express = require('express');
const admin = require('firebase-admin');
const app = express();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

app.use(express.json());
app.use('/exhibits', require('./routes/exhibits'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));