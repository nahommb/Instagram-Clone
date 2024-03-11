const Follow = require('../../models/followSchemaModel')

const following = (req,res)=>{
    Follow.find({username:req.params.username}).exec().then((data)=>{
        if(data){
            res.send(data);
        }
    }).catch();
}

module.exports = following