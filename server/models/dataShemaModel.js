const mongoose=require('mongoose')

const dataSchema= mongoose.Schema({
    username:String,
    password:String,
    followers:[]
})
const User = mongoose.model('user',dataSchema);

module.exports = User;