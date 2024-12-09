import firebase from "firebase/app";
import 'firebase/firestore';
import 'firebase/auth';
import "firebase/analytics";
import "firebase/database";
firebase.initializeApp({
    apiKey: "AIzaSyCQ6wVn3SL7JT8E31m1OjIRkPubUWHb7WY",
    authDomain: "univ-syllabus.firebaseapp.com",
    projectId: "univ-syllabus",
    storageBucket: "univ-syllabus.appspot.com",
    messagingSenderId: "515864974460",
    appId: "1:515864974460:web:b7c9744d317bd963eca5f9",
    measurementId: "G-9VMW9WHCSG"
});
const analytics = firebase.analytics();

const getIp = async () => {
    const response = await fetch("https://ipinfo.io?callback");
    const data = await response.json();
    return data.ip;
};
getIp().then(ip => analytics.setUserProperties({ ip: ip }));
export default firebase;
export const db = firebase.firestore();
export const rdb = firebase.database().ref();