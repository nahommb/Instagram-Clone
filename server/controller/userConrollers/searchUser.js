const User = require('../../models/dataShemaModel')

const searchUser = (req,res)=>{
    User.findOne({username:req.params.username}).exec().then((data)=>{
      
      if (data) {
          const { password, ...others } = data.toObject();
          res.send(others);
         
        }
      else{
          res.json(
              {
              'response':"nothing"
          }
          )
          console.log("user does not exist");
      }
      
      
    }).catch();
  }

  module.exports = searchUser;