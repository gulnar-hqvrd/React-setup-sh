import React from "react";
import { useSelector } from "react-redux";
import { useDispatch } from "react-redux";

export default function List() {
  const dispatch = useDispatch();
  // const {categories} = useSelector((state:Rootstate) =>state.categories.categories)
  return <>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Category Name</th>
        <th>Description</th>
        <th>Prosess</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>T-Shirt</td>
        <td>Blue</td>
        <td>Proses</td>
      </tr>
    </tbody>
  </table>
  </>
}
