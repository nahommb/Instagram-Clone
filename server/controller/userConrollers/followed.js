const Follow = require('../../models/followSchemaModel')

const followed = (req,res)=>{
    Follow.find({follows:req.params.username}).exec().then((data)=>{
        if(data){
            res.send(data);
        }
    }).catch();
}

module.exports = followed;