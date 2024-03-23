const router = require('express').Router();
const loginConroller = require('../controller/authentication/loginConroller')
const newFollower = require('../controller/userConrollers/addFollowers')
const following = require('../controller/userConrollers/following')

router.post('/auth/login',loginConroller)
.patch('/newfollower/:username',newFollower)
.get('/following/:username',following)
module.exports = [
    router
];