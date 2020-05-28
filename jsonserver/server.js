//include packages
utils = require('./utils');
const bodyParser = require('body-parser');
const multer = require('multer');
const upload = multer({ dest: 'avatar/' });
// json-server router
const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();
const port = process.env.PORT || 3000;
// Jsonwebtoken
const jwt = require('jsonwebtoken');
// Connect Neo4j in heroku
var neo4j = require('neo4j');
var graphenedbURL = process.env['GRAPHENEDB_URL'] || "http://localhost:7474/db/data/"
var neo4jdb = new neo4j.GraphDatabase(graphenedbURL);
// Connect MySQL
const mysql = require('mysql');
var mysql_db;
function handleDisconnect() {
    mysql_db = mysql.createConnection({
        host: process.env.MYSQL_HOST || 'us-cdbr-iron-east-01.cleardb.net',
        user: process.env.MYSQL_USER || 'baffbb7f8d26e3',
        password: process.env.MYSQL_PASSWORD || 'c983e2d7',
        database: process.env.MYSQL_DATABASE || 'heroku_bb5e87fda8141d2',
    });
    mysql_db.connect(function(err) {
        if(err) {
            console.log('error when connecting to db:', err);
            setTimeout(handleDisconnect, 2000);
        }
        console.log("***MySQL Running***");
    });
    mysql_db.on('error', function(err) {
        console.log('db error', err);
        if(err.code === 'PROTOCOL_CONNECTION_LOST') {
            handleDisconnect();
        } else {
            throw err;
        }
    });
}
handleDisconnect();
// Cloudinary
const cloudinary = require('cloudinary');
cloudinary.config({
    cloud_name: 'hntupmhmi',
    api_key: '851164953851241',
    api_secret: 'Dn6cTZDxBEHofFxUMm948bNewBI'
});  // Remove when remote
// nlp-compromise
const nlp = require('compromise');
// Before Routes
server.use(bodyParser.json());
server.use(bodyParser.urlencoded({ extended: true }));
server.use(middlewares);

server.get('/api', (req,res)=>{
    res.json({
        status: 'success',
        message:"Welcome to API!"
    });
});

server.get('/api/nlp', (req,res)=>{
    let doc = nlp("吴颖既用功又聪明.");
    res.json({
        status: 'success',
        message: doc
    });
});

server.get('/api/avatar/:userid', (req,res)=>{
    var userid = req.params.userid;
    var url = cloudinary.url(userid,{transformation: [
            {width: 400,height: 400,radius: "max", crop: "crop"},
            {width: 200, crop: "scale"},
            {default_image: "avatar0.png"}
        ]});
    res.json({
        status: 'success',
        avatar:url
    });
});
server.post('/api/avatar', upload.single('avatar'), (req,res)=>{
    var file = req.file;
    var userid = req.body['userid'];
    cloudinary.uploader.upload(file.path,
        function(result) {
            res.json({
                status: 'success',
                result: result
            })
        }, {public_id: userid});
});
server.post('/api/register',(req,res)=>{
    let body = req.body;
    let sql = `INSERT INTO  user (username,password,email) VALUES ('${body.username}','${body.password}','${body.email||'empty'}');`;
    mysql_db.query(sql, (err, result)=>{
        if (err) console.error(err);
        if (result !== 'undefined'){
            res.json({status: 'success'});
        }else{
            if (err.code === "ER_DUP_ENTRY") res.json({err:'username already exists.', message:'用户名已经存在。'});
            else res.json({status: 'fail',err:'insert database failed.', message:'用户注册失败。'});
        }
    })
})

server.post('/api/login',(req,res)=>{
    let body = req.body;
    console.log(`登入 ${body.email} ${body.password}`);
    let sql = `SELECT * FROM  user WHERE email='${body.email}' AND password='${body.password}';`;
    mysql_db.query(sql, (err, result)=>{
        if (err) console.error(err);
        if (result.length>0){
            jwt.sign({result},process.env.SECRET_KEY ||'mysecretkey', (err, token)=>{
                if(err){
                    res.json({
                        status: 'fail',
                        err: 'token authorization failed.',
                        message: 'Token授权失败，请重试。'
                    });
                }else{
                    res.json({
                        status: 'success',
                        token: token,
                    });
                }
            });
        }else{
            res.json({status: 'fail',err:'wrong username or password.', message:'用户名或密码错误。'});
        }
    })
});

server.use(router);
server.use(utils.exclude('/api/:other', utils.verifyToken));
// Use JWT below

server.get('/userinfo', (req,res)=>{
    const userInfo = req.userInfo;
    res.json({
        status: 'success',
        userinfo: userInfo.user
    });
});

server.get('/graph/:p1', (req,res)=>{
    var p1 = req.params.p1;
    neo4jdb.cypher({
        query: 'MATCH (n:Person {name: {personName}}) RETURN n',
        params: {
            personName: p1
        }
    }, function(err, results){
        if (err) {
            console.error('Error of Neo4j:', err);
            res.json({
                status: 'fail',
                err: err
            });
        } else {
            res.json({
                status: 'success',
                data: results
            });
        }
    });
});


server.use(jsonServer.bodyParser);


server.listen(port,()=>{console.log("***JsonServer Running***")});