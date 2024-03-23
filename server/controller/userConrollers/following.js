const User = require('../../models/dataShemaModel')


const following = (req,res)=>{
    User.findOne({username:req.params.username}).exec().then((data)=>{
        if(data){
            followingList = data.followers
            console.log(followingList)
            res.json({
                'followingList': followingList
            });
        }
    }).catch();
}

module.exports = following