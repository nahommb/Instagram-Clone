const Message = require('../../models/messageSchemaModel')

const getMessage = (req,res)=>{
    Message.find({$or:[{sender:req.params.sender,receiver:req.params.receiver},{sender:req.params.receiver,receiver:req.params.sender}]}).exec().then((data)=>{
        res.send(data);
    }).catch((error) => {
        res.status(500).send({ error: 'An error occurred while fetching the messages.' });
    });
}

module.exports = getMessage;