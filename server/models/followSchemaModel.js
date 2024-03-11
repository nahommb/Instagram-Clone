const mongoose = require('mongoose')

const followSchema = mongoose.Schema({
    username:String,
    follows:String
})
const Follow = mongoose.model('follow',followSchema);

module.exports = Follow