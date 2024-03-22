const router = require('express').Router();
const loginConroller = require('../controller/authentication/loginConroller')
const newFollower = require('../controller/userConrollers/addFollowers')


router.post('/auth/login',loginConroller)
.patch('/newfollower/:username',newFollower)

module.exports = [
    router
];