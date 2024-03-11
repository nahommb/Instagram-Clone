const chatList = (req,res)=>{
    Message.find({$or:[{sender:req.params.username},{receiver:req.params.username}]}).exec().then((data)=>{
        if(data){
            res.send(data);
        }
    }).catch();
}
module.exports = chatList;