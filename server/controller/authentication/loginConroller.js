const User= require('../../models/dataShemaModel')
const bcrypt = require('bcrypt')

const loginController = async (req,res)=>{
    const username = req.body.username.toLowerCase()
    console.log(username);
    const userpassword = req.body.password
    //  console.log(password)

    User.findOne ({username: username}).exec().then(async (data)=>{
          if (data){
            // console.log(data['password'])
             var val = await bcrypt.compare(userpassword,data['password'])
                if(val){
                      const { password, ...others } = data.toObject();
                    res.send(others);
                }
              else{
                res.sendStatus(400).json()
              }
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