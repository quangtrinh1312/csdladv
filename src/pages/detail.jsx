import React from "react";
//get film detail from api
// import { useParams } from "react-router-dom";
const Detail = () => {
    let id = window.location.pathname.split("/")[2];
    return (
        <div style={{marginTop:"100px", height:"80vh"}}>
            <h1>Detail: {id}</h1> <br />
            <h1>call api get detail movie: </h1>
            
        </div>
    );
}

export default Detail;

