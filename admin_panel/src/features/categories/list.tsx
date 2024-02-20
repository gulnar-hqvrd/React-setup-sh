import React, { useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../../app/hooks";
import { RootState } from "../../app/store";
import { fetchCategories } from "./categorySlice";

export default function List() {
  const dispatch = useAppDispatch();

  const categories = useAppSelector((state: RootState) => state);

  useEffect(() => {
    dispatch(fetchCategories());
  }, [dispatch]);

  return (
    <>
      <div>
        <h2>Kategoriler</h2>
        <table>
          <thead>
            <tr>
              <th>Id</th>
              <th>Kategori Adı</th>
              <th>Açıklama</th>
              <th>İşlemler</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>2</td>
              <td>3</td>
              <td></td>
            </tr>
          </tbody>
        </table>
      </div>
    </>
  );
}
