const User = require('../../models/dataShemaModel')

const insertFollower = async (req,res)=> {
   await User.find({username: req.params.username}).exec().then((data)=>{
        if(data){
            console.log(data)
            const newfollower = req.body.newfollower
            data[0].followers.push(newfollower);
            console.log(req.body.newfollower)

            data[0].save()
            res.send('done');
        }
   })
}

module.exports = insertFollower;