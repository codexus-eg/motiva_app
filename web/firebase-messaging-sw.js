importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: 'AIzaSyCBn9EmdljXeize3u6YuCambUgvylQXnqo',
  authDomain: 'motiva-6b2ef.firebaseapp.com',
  projectId: 'motiva-6b2ef',
  storageBucket: 'motiva-6b2ef.firebasestorage.app',
  messagingSenderId: '257633657471',
  appId: '1:257633657471:web:ee824e26f494286eac554a',
  measurementId: 'G-T7D5FGXWZM',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log('[firebase-messaging-sw.js] Received background message', message);
  const notificationTitle = message.notification.title;
  const notificationOptions = {
    body: message.notification.body,
    icon: './icons/Icon-192.png',
  };
  self.registration.showNotification(notificationTitle, notificationOptions);
});
