const mongoose = require('mongoose')

const messageSchema= mongoose.Schema({
    sender:String,
    receiver:String,
    message:String
})

const Message = mongoose.model('message',messageSchema);

module.exports = Message;