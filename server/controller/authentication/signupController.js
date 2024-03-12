const User= require('../../models/dataShemaModel')
const bcrypt = require('bcrypt')

const signupController = async (req,res)=>{

    const username = req.body.username;
    const password = await bcrypt.hash(req.body.password,10);


    User.findOne({username:username}).exec().then((data)=>{
        if(!data){
            console.log(username) 
            console.log(password)

            const user = User({
                username:username,
                password:password
                })

            user.save();
            res.send('Registerd')
        }
        else{
            res.send('user already exist');
            console.log("user already exist")
        }
    }).catch() 

}
module.exports = signupController;