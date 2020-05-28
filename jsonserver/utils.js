const { pathToRegexp, match, parse, compile } = require("path-to-regexp");
const jwt = require('jsonwebtoken');

function verifyToken(req,res,next){
    const bearerHeader = req.headers['authorization'];
    //check if bearer is undefined
    if (typeof bearerHeader != 'undefined')    {
        const bearer = bearerHeader.split(' ');
        const token = bearer[1];
        jwt.verify(token, process.env.SECRET_KEY || 'mysecretkey', (err, authData)=>{
            if(err){
                res.sendStatus(403);
            }else{
                req.userInfo = authData
                next();
            }
        });
    }else{
        //Forbidden
        res.sendStatus(403);
    }
}

function exclude(path, middleware) {
    const regex = pathToRegexp(path);
    return function(req, res, next) {
        if (regex.exec(req.path)) {
            return next(req,res);
        } else {
            return middleware(req, res, next);
        }
    };
};

module.exports = {
    verifyToken: verifyToken,
    exclude: exclude
};