const ex = require('express');
const app = ex();
const mongoose = require('mongoose');
const bdy = require('body-parser');

app.use(bdy.urlencoded({extended:true}));

mongoose.connect("mongodb://127.0.0.1:27017/instadb");

const dataSchema= mongoose.Schema({
    username:String,
    password:String
})
const messageSchema= mongoose.Schema({
    sender:String,
    receiver:String,
    message:String
})

const User = mongoose.model('user',dataSchema);
const Message = mongoose.model('message',messageSchema);

app.get('/user', function(req, res) {
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
  }); 


app.post('/user/login',function(req,res){
    
    User.findOne({username: req.body.username,password:req.body.password}).exec().then((data)=>{
        if (data) {
            const { password, ...others } = data.toObject();
            res.send(others);
           // console.log(data);
          }
        else{
            //res.send('"user does not exist')
            console.log("user does not exist");
        }
    }).catch()
    
})

app.post('/user/signup',function(req,res){

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

})
app.post('/user/sendmessage',function(req,res){
    const message = Message({
        sender:req.body.sender,
        receiver:req.body.receiver,
        message:req.body.message,
    })
    console.log(message); 
    message.save();
})

app.get('/user/getmessage/:sender/:receiver',function(req,res){
    Message.find({$or:[{sender:req.params.sender,receiver:req.params.receiver},{sender:req.params.receiver,receiver:req.params.sender}]}).exec().then((data)=>{
        res.send(data);
    }).catch((error) => {
        res.status(500).send({ error: 'An error occurred while fetching the messages.' });
    });
})

app.get('/user/search/:username',function(req,res){
  User.findOne({username:req.params.username}).exec().then((data)=>{
    
    if (data) {
        const { password, ...others } = data.toObject();
        res.send(others);
       
      }
    else{
        console.log("user does not exist");
    }
    
    
  }).catch();
})  
 
 
app.listen(3000,function(){
    console.log('server started');
})