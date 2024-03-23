// const Follow = require('../../models/followSchemaModel')

// const followcController = (req,res)=>{
//     const follow = Follow({
//         username:req.body.username,
//         follows:req.body.follows
//     })

//    // console.log(req.body.follows)
//    Follow.findOne({username:req.body.username,follows:req.body.follows}).exec().then((data)=>{
//        if(!data){
//         follow.save();
//        }
//       else{
//         console.log('already followed ')
//       }
//    })
//  }
//  module.exports = followcController