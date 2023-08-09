import React, {useState} from "react";
import { useNavigate } from "react-router-dom";
// import logo from './path.png'
import { Link } from "react-router-dom";

function Signup({setUser}){

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [password_confirmation, setPasswordConfirmation] = useState("");
  const [errors, setErrors] = useState([]);
  const [isLoading, setIsLoading] = useState(false);


  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrors([]);
    setIsLoading(true);
    if (password !== password_confirmation) {
      setErrors(["Passwords do not match"]);
      setIsLoading(false);
      return;
    }

    if (!validateEmail(email)) {
      setErrors(["Please enter a valid email"]);
      setIsLoading(false);
      return;
    }

    try {
      

      const response = await fetch("/signup", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({email, password, password_confirmation }),
      });


      // setIsLoading(false);

      if (response.ok == true) {
        // console.log('1');
        const data = await response.json();
        // Assuming you want to set the user after successful sign-up
        // setUser(data.user);
        console.log('2');

        navigate("/login");
      } else {
        console.log('error');


        const err = await response.json();
        setErrors([err.message || "Invalid Username or Password"]);
      }


    } catch (error) {
      setErrors(["An error occurred during signup. Please try again."]);
      setIsLoading(false);
    }
  };

  const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  };

    return(
        <>
            
            <section className="vh-100" style={{ backgroundColor: '#9A616D' }}>
      <div className="container py-3 h-100 small container">
        <div className="row d-flex justify-content-center align-items-center h-100">
          <div className="col col-xl-10">
            <div className="card" style={{ borderRadius: '1rem' }}>
              <div className="row g-0">
                <div className="col-md-6 col-lg-5 d-none d-md-block">
                  <img
                    src="https://plus.unsplash.com/premium_photo-1681487013658-0e858fe92840?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGFmcmljYW4lMjBnaXJsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"
                    alt="login form"
                    className="image-logo"
                  />
                </div>
                <div className="col-md-6 col-lg-7 d-flex align-items-center">
                  <div className="card-body p-4 p-lg-5 text-black">
                    <form onSubmit={handleSubmit}>
                      <div className="d-flex align-items-center mb-3 pb-1">
                        {/* <img src={logo} alt="logo" className="logo" /> */}
                      </div>

                      <h5 className="fw-normal mb-3 pb-3" style={{ letterSpacing: '1px' }}>
                        Sign up for an account
                      </h5>

                     

                      <div className="form-outline mb-4">
                        <input type="email"
                        //  id="form2Example17"
                        className="form-control form-control-lg" 
                        id="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                        />
                        <label className="form-label" htmlFor="form2Example17">
                          Email address
                        </label>
                      </div>

                      <div className="form-outline mb-4">
                        <input
                         type="password" 
                        //  id="form2Example27" 
                        id="password"
                        className="form-control form-control-lg"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        autoComplete="new-password"
                        required
                          />
                        <label className="form-label" htmlFor="form2Example27">
                          Password
                        </label>
                      </div>

                      <div className="form-outline mb-4">
                        <input 
                        type="password"
                        // id="form2Example27" 
                        id="password_confirmation"
                        className="form-control form-control-lg" 
                        value={password_confirmation}
                        onChange={(e) => setPasswordConfirmation(e.target.value)}
                        autoComplete="new-password"
                        required
                            />
                        <label className="form-label" htmlFor="form2Example27">
                          Confirm Password
                        </label>
                      </div>

                      <div className="pt-1 mb-4">
                      <button type="submit" class="btn btn-primary" id="donate-btn" >Sign Up</button>

                      </div>

                     
                      <p className="mb-5 pb-lg-2" style={{ color: '#393f81' }}>
                        Already have an account? 
                        <Link to='/login' >Login here</Link>
                        {/* <a href="#!" style={{ color: '#393f81' }}>Login here</a> */}
                      </p>
                      
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
        </>
    )
}

export default Signup;