import './App.css';

<<<<<<< HEAD
import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import Home from './home';
import Aboutus from './aboutus';
import Login from './login';
import Signup from './signup';
=======
import React, {useState, useEffect} from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom'
import Home from './home';
import Aboutus from './aboutus';
import Logout from './components/auth/logout';
import Login from './components/auth/login';
import Signup from './components/auth/signup';
>>>>>>> b460c366 (Backend)
import Navbar from './components/navbar';
import Volunteer from './volunteer';
import Charities from './charities';
import Createcharity from './createcharity';
import Donations from './donations';

function App() {
<<<<<<< HEAD
=======
  const [user, setUser] = useState(null);

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const res = await fetch("/me");
        if (res.ok) {
          const data = await res.json();
          setUser(data);
        }
      } catch (error) {
        console.error("Error fetching user data:", error);
      }
    };

    fetchUserData();
  }, []);

 
    return(
      <>
         <Router>
          {/* The NavBar and LandingPage are accessible when the user is not logged in */}
          <Navbar user={user} setUser={setUser} />
          <main>
            <Routes>
              {!user && (
                <>
              <Route path='/' element={<Home />} />
              <Route path='/aboutus' element={<Aboutus />} />
              <Route path='/charities' element={<Charities />} />
              <Route path="/signup" element={<Signup setUser={setUser} />} />
              <Route path="/login" element={<Login onLogin={setUser} />} />
              <Route path='/donations' element={<Donations />} />
<<<<<<< HEAD

            </Routes>
          </main>
        </Router>
      </>
    )
  }



>>>>>>> b460c366 (Backend)
  return (
    <div className="App">
      <Router>
        <div><Navbar /></div>
        
        <Routes>
          <Route path='/' element={<Home />} />
=======
              </>
              )}
              {user && (
                <>
                      <Route path='/' element={<Home />} />
>>>>>>> 1362ac09 (Change permission access to components)
          <Route path='/aboutus' element={<Aboutus />} />
          <Route path='/logout' element={<Logout onLogout={setUser}/>} />
          <Route path="/login" element={<Login onLogin={setUser} />} />

          <Route path='/signup' element={<Signup onLogin={setUser} />} />
          <Route path='/charities' element={<Charities />} />
          <Route path='/create-charity' element={<Createcharity />} />
          <Route path='/volunteer' element={<Volunteer />} />
          <Route path='/donations' element={<Donations />} />
          <Route path='*' element={<h1>PAGE NOT FOUND :: 404 Status</h1>} />
       
                </>
              )}
            </Routes>
          </main>
        </Router>
      </>
    )
  

}

export default App;
