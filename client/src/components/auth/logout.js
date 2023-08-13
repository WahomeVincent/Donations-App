import React from 'react'
import { useNavigate } from 'react-router-dom';

const Logout = ( {setUser} ) => {
    const navigate = useNavigate()

    const handleLogoutClick = (e) => {
        e.preventDefault()
        fetch("/logout", { 
            method: "DELETE",
        })
        navigate('/landing-page')
    }

  return (
    <div>
      <button onClick={handleLogoutClick}>Logout</button>
    </div>
  )
}

export default Logout