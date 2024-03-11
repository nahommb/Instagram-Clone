const User = require('../../models/dataShemaModel')
const Follow = require('../../models/followSchemaModel')

const followSuggestion = (req,res)=>{
   
    var follwingData = [req.params.username];
   
        Follow.find({username:req.params.username}).exec().then((followingdata)=>{
            followingdata.forEach(element => {
               
                follwingData.push(element['follows'])
            });
            if(followingdata){
               User.aggregate([
                { $match:{username:{$nin:follwingData}}},
                {$sample:{size:5},},
                {$project:{password:0}}
               ]).exec().then((data)=>{
                if(data){
                    res.send(data)
                }    
               })
            }
        }).catch((error)=>{
            res.status(500).send('internal server error');
        })
}

module.exports = followSuggestion