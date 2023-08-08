import React from "react";
import './donations.css'
import qrcode from './qr-code.png'
import { Link } from "react-router-dom";

function Donations(){
    return(
       <>
            <div className="donations-container">
                <img id="don-image" src="https://images.unsplash.com/photo-1505455184862-554165e5f6ba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=869&q=80" alt="Snow" />
                <div className="don-text" >
                        <h2>"I have found that among its other benefits, giving liberates the soul of the giver."</h2>
                        <h2>--Maya Angelou--</h2>
                </div>
                    <Link to="https://donate.stripe.com/test_00g01n8fSbEh2KA3cc">
                    <button id="don-button" type="button" class=" btn btn-primary">Donate</button>
                    </Link> 
                    <h2 id="scan-text">Or Scan to donate.</h2>
                    <img src={qrcode} alt="qr-code" id="don-qr-code" />
                    
            </div>              
       </>
       
        
    )
}

export default Donations;