import React from 'react'
import { useNavigate } from 'react-router-dom';

const Logout = ( {onLogout} ) => {
    const navigate = useNavigate()

    const handleLogoutClick = (e) => {
        e.preventDefault()
        fetch("/logout", { 
            method: "DELETE",
        })


        navigate('/')
    }

  return (
    <div>
      <button onClick={handleLogoutClick}>Logout</button>
    </div>
  )
}

export default Logout