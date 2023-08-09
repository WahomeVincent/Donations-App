import React, {useState} from "react";
import { Link, useNavigate } from "react-router-dom";

const Login = ( {onLogin}) => {

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [errors, setErrors] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);

    
    async function login(){
      const response = await fetch(`/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password }),
      })
      console.log(response);

      if (response.ok) {
        setIsLoading(false);
        const user = await response.json();
        onLogin(user);
        
        navigate('/')
      } else {
        const err = await response.json();
        setErrors(err.message || "Invalid Username or Password");
      }
    }
    login();
  };


    return(
        <>
            
            <section className="vh-100" style={{ backgroundColor: '#9A616D' }}>
      <div className="container py-5 h-100">
        <div className="row d-flex justify-content-center align-items-center h-100">
          <div className="col col-xl-10">
            <div className="card" style={{ borderRadius: '1rem' }}>
              <div className="row g-0">
                <div className="col-md-6 col-lg-5 d-none d-md-block">
                  <img
                    src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img1.webp"
                    alt="login form"
                    className="img-fluid"
                    style={{ borderRadius: '1rem 0 0 1rem' }}
                  />
                </div>
                <div className="col-md-6 col-lg-7 d-flex align-items-center">
                  <div className="card-body p-4 p-lg-5 text-black">
                  <h1>Login</h1>
                   <h3 style={{backgroundColor: 'red'}}>{errors && <p>{errors}</p>}</h3>
                    <form onSubmit={handleSubmit}> 
                      

                      <h5 className="fw-normal mb-3 pb-3" style={{ letterSpacing: '1px' }}>
                        Sign into your account
                      </h5>

                      <div className="form-outline mb-4">
                        <input 
                        type="email" 
                        // id="form2Example17" 
                        id="email"
                        className="form-control form-control-lg" 
                        autoComplete="off"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        />
                        <label className="form-label" htmlFor="form2Example17">
                          Email address
                        </label>
                      </div>

                      <div className="form-outline mb-4">
                        <input 
                        type="password" 
                        // id="form2Example27"
                        id="password" 
                        className="form-control form-control-lg" 
                        autoComplete="current-password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        />
                        <label className="form-label" htmlFor="form2Example27">
                          Password
                        </label>
                      </div>

                      <div className="pt-1 mb-4">
                      <button type="submit" class="btn btn-primary" id="donate-btn" >
                      {isLoading ? "Loading..." : "Login"}
                      </button>

                      </div>

                      
                      <p className="mb-5 pb-lg-2" style={{ color: '#393f81' }}>
                        Don't have an account?  
                        <Link to='/signup' > Register here</Link>
                        {/* <a href="#!" style={{ color: '#393f81' }}>Register here</a> */}
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

export default Login;