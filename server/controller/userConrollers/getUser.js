const User= require('../../models/dataShemaModel')

const user_controller = (req, res)=>{
    User.find({}).exec().then((data) => {

        if (data.length > 0) {
          const modifiedData = data.map((user) => {
            const { password, ...others } = user.toObject();
            return others;
          });
          res.send(modifiedData);
        } else {
          res.send('No users found');
          console.log('No users found');
        }
      })
      .catch((error) => {
        console.error(error);
        res.status(500).send('Internal Server Error');
      });
    }
    module.exports = user_controller;