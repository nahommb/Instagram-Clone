const router = require('express').Router();

const newFollower = require('../controller/userConrollers/addFollowers')
const following = require('../controller/userConrollers/following')

router
.patch('/newfollower/:username',newFollower)
.get('/following/:username',following)


module.exports = router;