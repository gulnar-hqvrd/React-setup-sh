cd admin_panel

cat >src/app/rootReducer.ts <<EOF
import { combineReducers } from "@reduxjs/toolkit";
// import categoryReducer from "../features/category/categorySlice";
// import productReducer from "../features/product/productSlice";
// import userReducer from "../features/user/userSlice";

const rootReducer = combineReducers({
  // category: categoryReducer,
  // product: productReducer,
  // user: userReducer,
});

export default rootReducer;
EOF