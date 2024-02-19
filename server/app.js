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

const followSchema = mongoose.Schema({
    username:String,
    follows:String
})

const User = mongoose.model('user',dataSchema);
const Message = mongoose.model('message',messageSchema);
const Follow = mongoose.model('follow',followSchema);

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
        res.json(
            {
            'response':"nothing"
        }
        )
        console.log("user does not exist");
    }
    
    
  }).catch();
})  
 app.post('/user/follow',function(req,res){
    const follow = Follow({
        username:req.body.username,
        follows:req.body.follows
    })

   // console.log(req.body.follows)
   Follow.findOne({username:req.body.username,follows:req.body.follows}).exec().then((data)=>{
       if(!data){
        follow.save();
       }
      else{
        console.log('already followed ')
      }
   })

 })
 
app.get('/user/follows/:username',function(req,res){
    Follow.find({username:req.params.username}).exec().then((data)=>{
        if(data){
            res.send(data);
        }
    }).catch();
})

app.get('/user/followed/:username',function(req,res){
    Follow.find({follows:req.params.username}).exec().then((data)=>{
        if(data){
            res.send(data);
        }
    }).catch();
})
app.get('/user/followsuggetion/:username',function(req,res){
      User.aggregate([{ $sample: { size: 2 } }]).exec().then((data)=>{
        var follwingData = [];
       
        if(data){
            Follow.find({username:req.params.username}).exec().then((followingdata)=>{
                followingdata.forEach(element => {
                    follwingData.push(element['follows'])
                });
                if(followingdata){
                   User.aggregate([
                    { $match:{username:{$nin:follwingData}}},
                    {$sample:{size:2}}
                   ])
                }
            }).catch();

            // for(var i=0; i<data.length;i++){
                // data.forEach(users => { 
                //     var notFollowing=[];
                //     follwingData.forEach(followingusers => {
                //          console.log(users['username'])
                //          console.log(followingusers['username'])

                //        if(users['username']===followingusers['follows']){
                //             notFollowing.push(users);
                           
                            

                //        }
                //     })
                // //    console.log (notFollowing);
                // }); 
               
            // }

            res.send(data);
        }
    }).catch();
})

// app.get('/user/notfollowing/:username',function(req,res){
//     User.find({}).exec().then((data)=>{
//         if(data){
            
//             for(var i=0;i<data.length;i++){

//             }
//         }
//     })
// })

app.listen(3000,function(){
    console.log('server started');
})