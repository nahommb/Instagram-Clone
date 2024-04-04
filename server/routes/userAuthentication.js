const router = require('express').Router();

const loginConroller = require('../controller/authentication/loginConroller')
const signupController = require('../controller/authentication/signupController')

router
.post('/login',loginConroller)
.post('/signup',signupController)

module.exports = router;