const ex = require('express');
const app = ex();
const mongoose = require('mongoose');
const bdy = require('body-parser');
const multer = require('multer')

const getUser = require('./controller/userConrollers/getUser')
const messageContoller = require('./controller/messageController/messageController')
// const loginController = require('./controller/authentication/loginConroller')
const signupController = require('./controller/authentication/signupController')
const getMessage = require('./controller/messageController/getMessage')
const searchUser = require('./controller/userConrollers/searchUser')
const followUser = require('./controller/userConrollers/followUser')
const followSuggestion = require('./controller/userConrollers/followSuggestion')
const following = require('./controller/userConrollers/following')
const followed = require('./controller/userConrollers/followed')
const chatList = require('./controller/userConrollers/chatList')




const userActivity = require('./routes/userActivity');

app.use(bdy.urlencoded({extended:true}));

mongoose.connect("mongodb://127.0.0.1:27017/instadb");

app.use('/user',userActivity)




const postSchema = mongoose.Schema({
    name:{
        type:String,
         
    },
    image:{
        data:Buffer,
        contentType:String
    }
})




const postModel = mongoose.model('posts',postSchema)


const Storage = multer.diskStorage({
    destination:'posts',
    filename:(req,file,cb)=>{
        cb(null,file.originalname)
    }
});
const upload = multer({
    storage:Storage
}).single('post')


app.get('/user',getUser); 
// app.post('/user/login',loginController)
app.post('/user/signup',signupController)
app.post('/user/sendmessage',messageContoller)
app.get('/user/getmessage/:sender/:receiver',getMessage)
app.get('/user/search/:username',searchUser)  
app.post('/user/follow',followUser)
app.get('/user/follows/:username',following)
app.get('/user/followed/:username',followed)
app.get('/user/chatList/:username',chatList)
app.get('/user/followsuggestion/:username',followSuggestion)


app.post('/user/post',function(req,res){
   upload(req,res,(err)=>{
    if(err){
        console.log(err)
    }
    else{
        const newPost = postModel({
            name:req.body.name,
            image:{
                data:req.file.fieldname,
                contentType:'image/png'
            }
        })
        newPost.save().then(()=>res.send('successfully uploaded'))
        .catch((err)=>console.log(err))
    }
   })
})

app.get('/user/post',async (req,res)=>{
    postModel.find({}).exec().then((data)=>{
        res.json(data);
    })
})

app.listen(3000,function(){
    console.log('server started');
})