import React from "react";
import { Link, useNavigate } from "react-router-dom";
import logo from "./path.png";

function Navbar({user, setUser}){
  const navigate = useNavigate();

  function handleLogout() {
    fetch("/logout", { method: "DELETE" }).then((r) => {
      if (r.ok) {
        setUser(null);
        navigate("/");
      }
    });
  }

  const handleSignupClick = () => {
    // Navigate to the "/signup" route
    navigate('/login');
  };

    return(
        <>
            <nav class="navbar navbar-expand-md sticky-navbar ">
      <div class="container">
        <a class="navbar-brand d-md-none d-xs-block py-3" href="#">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
    
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          
          <ul class="navbar-nav mx-auto">
            <li >
                <img src={logo} className="nav-logo" alt="Company Logo"/>
                 </li>

            <li class="nav-item">
              <Link to='/' class="nav-link mx-2" active aria-current="page" >Home</Link>
            </li>
            <li class="nav-item">
              <Link to='/charities' class="nav-link mx-2">Charities</Link>
            </li>
            <li class="nav-item">
              
              <Link to='/create-charity' class="nav-link mx-2">Create Charity</Link>
            </li>
            <li class="nav-item">
              <Link to='/aboutus' class="nav-link mx-2">About Us</Link>
            </li>
            <li  class="nav-item">
              
              <Link to='/donations' class=" btn btn-primary" id="donate-btn" >Donate</Link>
            </li>
            
          </ul>
          <ul class="navbar-nav mx-auto">
          <div className="sign-in">
            {!user ? (
              <>
                <li class="nav-item">
              <Link to='/login' class="nav-link mx-2">Login</Link>
              </li>
              <li class="nav-item">
              <Link to='/signup' onClick={handleSignupClick} class="nav-link mx-2">Signup</Link>
              </li>
              </>
            ) : (
              <li>
              <button onClick={handleLogout}  class="nav-link mx-2">Logout</button>
              
            </li>
            )}
              
            </div>
          </ul>
        </div>
      </div>
    </nav>
        </>
    )
    
}

export default Navbar;