const User = require('../../models/dataShemaModel')

const insertFollower = async (req,res)=> {

    try{
         await User.findOne({username: req.params.username}).exec().then((data)=>{
            if(data){
                // console.log(data)
                const newfollower = req.body.newfollower
                if(!data.followers.includes(newfollower) && data.username!==newfollower){
                    data.followers.push(newfollower);
                    console.log(req.body.newfollower)

                    data.save()
                    res.send('done');
                }
                else{
                    res.json('already followed')
                    
                }
            
            }
    })
    }
    catch(err){
        throw err
    }

}

module.exports = insertFollower;