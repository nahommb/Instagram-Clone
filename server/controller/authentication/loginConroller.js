const User= require('../../models/dataShemaModel')

const loginController = (req,res)=>{
    const username = req.body.username.toLowerCase()
  console.log(username);
  
      User.findOne({username: username,password:req.body.password}).exec().then((data)=>{
          if (data) {
              const { password, ...others } = data.toObject();
              res.send(others);
             // console.log(data);
            }
          else{
              res.json({
                  'response':'user does not exist'
              })
              console.log("user does not exist");
          }
      }).catch()
      
  }

  module.exports = loginController;