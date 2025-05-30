importScripts('https://www.gstatic.com/firebasejs/10.10.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.10.0/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyCcBGbVao2fqPAMpfUiY03sPqgE-0zEwX4",
    authDomain: "tata-47a2e.firebaseapp.com",
    projectId: "tata-47a2e",
    storageBucket: "tata-47a2e.firebasestorage.app",
    messagingSenderId: "397693381447",
    appId: "1:397693381447:web:f1b42a2e92d9907b32fa62",
    measurementId: "G-H8SKYG0TXF"
});
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log("📩 Received background message: ", payload);
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: '/icons/app-icon.png'
  });
});