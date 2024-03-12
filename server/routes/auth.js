const router = require('express').Router();
const loginConroller = require('../controller/authentication/loginConroller')

router.post('/auth/login',loginConroller)

module.exports = [
    router
];