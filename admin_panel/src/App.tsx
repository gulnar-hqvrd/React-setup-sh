import React from "react";
import "./App.css";
import Header from "./layout/header";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { CategoryCreate, CategoryList } from "./features/categories";
import Sidebar from "./layout/sidebar";

function App() {
  return (
    <>
      <Header />
      <Router>
        <div>
          <Sidebar />
          <div>
            <Routes>
              <Route path="/categories" element={<CategoryList />}></Route>
              <Route path="/categories" element={<CategoryCreate />}></Route>
              <Route path="/" element={<Home />}></Route>
            </Routes>
          </div>
        </div>
      </Router>
    </>
  );
}

const Home: React.FC = () => (
  <>
    <div>
      <h2>Home Page</h2>
      <p>Welcome</p>
    </div>
  </>
);
export default App;
