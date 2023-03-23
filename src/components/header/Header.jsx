import React, { useEffect, useRef, useState } from "react";
import { Link, useHistory, useLocation } from "react-router-dom";
import tmdbApi from "../../api/tmdbApi";
import "./header.scss";

// import logo from "./../../assets/logo.png";

// import * as Config from "./../../constants/Config";

const headerNav = [
  {
    display: "Home",
    path: `/`,
  },
  {
    display: "Movies",
    path: `/movie`,
  },
  {
    display: "TV Series",
    path: `/tv`,
  },
];

const Header = () => {
  let history = useHistory();
  const { pathname } = useLocation();
  const headerRef = useRef(null);
  const [items, setItems] = useState([]);
  const active = headerNav.findIndex((e) => e.path === pathname);

  function logout(e) {
    //confirm do you want to logout
    let out = window.confirm("Do you want to logout?");
    if (out === true) {
      localStorage.removeItem("token");
      history.replace("/login");
    } else {
      e.preventDefault();
      return;
    }

  }

  useEffect(() => {
    const shrinkHeader = () => {
      if (
        document.body.scrollTop > 100 ||
        document.documentElement.scrollTop > 100
      ) {
        headerRef.current.classList.add("shrink");
      } else {
        headerRef.current.classList.remove("shrink");
      }
    };

    window.addEventListener("scroll", shrinkHeader);

    return () => {
      window.removeEventListener("scroll", shrinkHeader);
    };
  }, []);
  //call api genres
  useEffect(() => {
    const getGenresList = async () => {
      let response = null;
      const params = {};
      response = await tmdbApi.getGenres({ params });
      setItems(response.genres);

    };
    getGenresList();
  }, []);
  return (
    <div ref={headerRef} className="header">
      <div className="header__wrap container">
        <div className="logo">
          <img src={'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcJV8o6WqlDiYhUlLyRcwKxRvj1S36C6a3_g&usqp=CAU'} alt="logo" />
          {/* <Link to={`/`}>POL</Link> */}
          <a href="">POL</a>
        </div>

        <ul className="header__nav">
          <li key={3} className="dropdown">
            <a href="#" class="dropbtn">Genres</a>
            <div class="dropdown-content">
              <div className="dropdown-content-flex">
                {items.map((item, index) => (
                  <a href="#" key={index}>{item.name}</a>
                ))}
              </div>
            </div>
          </li>
          {headerNav.map((e, i) => (
            <li key={i} className={`${i === active ? "active" : ""}`}>
              {/* <Link to={e.path}>{e.display}</Link> */}
              <a className={`${i === active ? "active" : ""}`} href="#">{e.display}</a>
            </li>
          ))}

          <li>
            <a href="" onClick={logout}>Log Out</a>
          </li>
        </ul>
      </div>
    </div>
  );
};

export default Header;
