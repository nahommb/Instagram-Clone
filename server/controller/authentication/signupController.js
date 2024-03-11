const User= require('../../models/dataShemaModel')

const signupController = (req,res)=>{

    const username = req.body.username;
    const password = req.body.password;

    User.findOne({username:username}).exec().then((data)=>{
        if(!data){
            console.log(username) 

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