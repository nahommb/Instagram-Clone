const mongoose=require('mongoose')

const dataSchema= mongoose.Schema({
    username:String,
    password:String
})
const User = mongoose.model('user',dataSchema);

module.exports = User;