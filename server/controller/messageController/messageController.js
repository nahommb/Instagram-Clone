const Message = require('../../models/messageSchemaModel')
const messageController = (req,res)=>{
    const message = Message({
        sender:req.body.sender,
        receiver:req.body.receiver,
        message:req.body.message,
    })
    console.log(message); 
    res.send('successed')
    message.save();
}

module.exports = messageController